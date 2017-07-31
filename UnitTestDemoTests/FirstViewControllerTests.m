//
//  FirstViewControllerTests.m
//  ViewControllerUnitTestDemo
//
//  Created by linkunzhu on 2017/7/25.
//  Copyright © 2017年 易图资讯. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "FirstViewController.h"
#import "PersonalCenterViewController.h"
#import "PersonalCenterViewModel.h"

#import "PersonalCenterViewModelMock.h"
#import "PersonalCenterNavigationServiceMock.h"
#import "UINavigationControllerMock.h"

#import "UIView+TestingHelper.h"
#import "UIButton+TestingHelper.h"

@interface FirstViewControllerTests : XCTestCase

@property (nonatomic, strong) FirstViewController *vc;
@property (nonatomic, weak) UIButton *nextPageBtn;
@property (nonatomic, strong) PersonalCenterViewModelMock *viewModel;
@property (nonatomic, strong) PersonalCenterNavigationServiceMock *navigationService;

@end

@implementation FirstViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.vc = [sb instantiateViewControllerWithIdentifier:@"FirstViewController"];
    /// 不起作用，因为vc通过sb初始化失败后，不会执行setUp方法
    if (!self.vc) {
        NSLog(@"Storyboard初始化控制器失败");
    }
    self.nextPageBtn = [self.vc.view buttonWithText:@"下一页"];
    self.navigationService = [[PersonalCenterNavigationServiceMock alloc] init];
    self.viewModel = [[PersonalCenterViewModelMock alloc] init];
    
    UIApplication *app = [UIApplication sharedApplication];
    [app.keyWindow addSubview:self.vc.view];
    [app.keyWindow makeKeyAndVisible];
}

- (void)tearDown {
    [self.vc.view removeFromSuperview];
    self.vc = nil;
    [super tearDown];
}

#pragma mark - 测试viewController

/// 不起作用，因为vc通过sb初始化失败后，不会执行测试用例
- (void)testInitFirstViewControllerSuccessWithStoryboard{
    XCTAssertNotNil(self.vc);
}

- (void)testViewShouldContainToNextPageButton{
    XCTAssertNotNil(self.nextPageBtn);
}

- (void)testExistPersonalCenterViewModelInstance{
    PersonalCenterViewModelMock *pVMMock = [[PersonalCenterViewModelMock alloc] init];
    self.vc.personalCenterVM = pVMMock;
    XCTAssertNotNil(self.vc.personalCenterVM);
    XCTAssertTrue([self.vc.personalCenterVM isKindOfClass:[PersonalCenterViewModel class]]);
}

/// 如果要通过检测navVC.topViewController这个属性来验证有没有push控制器，那么调用pushViewController:animated:方法时，animated参数要设置为NO。
- (void)testPushViewControllerMustSetAnimatedAsFalse{
    FirstViewController *rootVC = [[FirstViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    PersonalCenterViewController *destVC = [[PersonalCenterViewController alloc] init];
    [navVC pushViewController:destVC animated:NO];
    XCTAssertEqual(2, [navVC.viewControllers count]);
    XCTAssertTrue([navVC.topViewController isKindOfClass:[PersonalCenterViewController class]]);
}

- (void)testPushViewControllerMustNotSetAnimatedAsYes{
    FirstViewController *rootVC = [[FirstViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    PersonalCenterViewController *destVC = [[PersonalCenterViewController alloc] init];
    [navVC pushViewController:destVC animated:YES];
    XCTAssertEqual(1, [navVC.viewControllers count]);
    XCTAssertTrue([navVC.topViewController isKindOfClass:[FirstViewController class]]);
}



#pragma mark - 测试viewModel

/// 如果产品的代码的push方法的animated参数必须是YES，那么得用依赖注入的方式，测试调用push方法的方法是否执行。确认这一点就好，不用继续确认是否真的push成功。
/// 因为，push方法，属于苹果代码，单元测试的原则是，我们不测试苹果代码。因此这里，我们只确认调用了push方法即可。
/// 但是，这里，除了观察navVC.topViewController的属性值变更外，好像没别的办法观察到执行了push方法的效果。
/// 所以，要通过依赖注入的方法，暴露相关对象，然后检验被依赖对象的状态改变，这里是检测依赖对象是否执行了某个方法
- (void)testTapNextPageButtonShouldInvokePersonalCenterViewModelExecuteToPersonalCenterMethod{
    PersonalCenterViewModelMock *pVMMock = [[PersonalCenterViewModelMock alloc] init];
    self.vc.personalCenterVM = pVMMock;
    //XCTestExpectation *expect = [self expectationWithDescription:@"超时了"];
    // block被执行很快时，看来不需要使用异步执行测试的机制
    [pVMMock methodCalled:^(NSString *methodName) {
        XCTAssertEqual(methodName, @"toPersonalCenter");
        //[expect fulfill];
    }];
    [self.nextPageBtn tapTheButton];
    //[self waitForExpectationsWithTimeout:2 handler:nil];
}


#pragma mark - 测试navigationService


/**
 测试PersonalCenterViewModel对象调用toPersonalCenter方法时会触发navigationService属性调用toDestinationControllerWithInfo:方法；
 传递参数为PersonalCenterViewModel对象。
 */
- (void)test_navigationService_callMethod_toDestinationControllerWithInfo{
    
    XCTestExpectation *exp = [self expectationWithDescription:@"超时了"];
    UINavigationController *navVC = [[UINavigationController alloc] init];
    PersonalCenterNavigationServiceMock *service = [[PersonalCenterNavigationServiceMock alloc] initWithNavigationController:navVC];
    service.methodCalledHandler = ^(NSString *method, id info){
        XCTAssertEqual(method, @"toDestinationControllerWithInfo");
        XCTAssertTrue([info isKindOfClass:[PersonalCenterViewModel class]]);
        [exp fulfill];
    };
    PersonalCenterViewModelMock *viewModel = [[PersonalCenterViewModelMock alloc] initWithUserId:@"123" navigationService:service];
    [viewModel toPersonalCenter];
    [self waitForExpectationsWithTimeout:2 handler:nil];
}

/**
 点击下一页按钮，navigationService相关属性被赋值。
 */
- (void)test_properties_NavigationControllerDestinationControllerTransferInfo_Exist{
    UINavigationController *navVC = [[UINavigationController alloc] init];
    PersonalCenterNavigationServiceMock *service = [[PersonalCenterNavigationServiceMock alloc] initWithNavigationController:navVC];
    PersonalCenterViewModelMock *viewModel = [[PersonalCenterViewModelMock alloc] initWithUserId:@"123" navigationService:service];
    self.vc.personalCenterVM = viewModel;
    [self.nextPageBtn tapTheButton];
    XCTAssertNotNil(service.destinationController);
    XCTAssertTrue([service.destinationController isKindOfClass:[PersonalCenterViewController class]]);
    XCTAssertNotNil(service.navigationController);
    XCTAssertTrue([service.navigationController isKindOfClass:[UINavigationController class]]);
    XCTAssertNotNil(service.transferInfo);
    XCTAssertTrue([service.transferInfo isKindOfClass:[PersonalCenterViewModel class]]);
}

#pragma mark - 测试导航控制器

- (void)testNavigationControllerPushNextViewControllerWhenNextPageBtnTap{
    UINavigationControllerMock *navVC = [[UINavigationControllerMock alloc] init];
    PersonalCenterNavigationServiceMock *service = [[PersonalCenterNavigationServiceMock alloc] initWithNavigationController:navVC];
    PersonalCenterViewModelMock *viewModel = [[PersonalCenterViewModelMock alloc] initWithUserId:@"123" navigationService:service];
    self.vc.personalCenterVM = viewModel;
    XCTestExpectation *exp = [self expectationWithDescription:@"超时了"];
    navVC.methodCalledHandler = ^(NSString *method, id info){
        XCTAssertEqual(method, @"pushViewController");
        XCTAssertTrue([info isKindOfClass:[PersonalCenterViewController class]]);
        [exp fulfill];
    };
    [self.nextPageBtn tapTheButton];
    [self waitForExpectationsWithTimeout:2 handler:nil];

}

#pragma mark - 测试内存释放

- (void)testFirstViewControllerDealloc
{
    __weak FirstViewController *weakReference;
    @autoreleasepool {
        FirstViewController *reference = [[FirstViewController alloc] init]; // or similar instance creator.
        weakReference = reference;
        
        // Test your magic here.
        [reference viewDidLoad];
        NSLog(@"personalCenterVM : %@",reference.personalCenterVM);
        NSLog(@"personalCenterNavService : %@",reference.personalCenterNavService);
    }
    // At this point the everything is working fine, the weak reference must be nil.
    XCTAssertNil(weakReference.personalCenterVM);
    XCTAssertNil(weakReference.personalCenterNavService);
    XCTAssertNil(weakReference);
}

@end























