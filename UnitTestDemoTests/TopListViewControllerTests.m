//
//  TopListViewControllerTests.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/5.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TopListViewController.h"
#import "TopListViewControllerMock.h"
#import "TopListNavigationService.h"
#import "TopListApiServiceMock.h"
#import "TopListViewModel.h"
#import "UIView+TestingHelper.h"

@interface TopListViewControllerTests : XCTestCase

///这三个属性会在上一个页面的控制器里面被强引用。用这种方式，控制器在跳转到其他模块是可以不需要关联控制器，方便以后维护。
@property (nonatomic, strong) TopListNavigationService *navigationService;
@property (nonatomic, strong) TopListViewModel *viewModel;
@property (nonatomic, strong) TopListViewController *controller;
@property (nonatomic, strong) UINavigationController *lastPageNav;

@end

@implementation TopListViewControllerTests

- (void)setUp {
    [super setUp];
    self.lastPageNav = [[UINavigationController alloc] init];
    self.navigationService = [[TopListNavigationService alloc] initWithNavigationController:self.lastPageNav];
    self.viewModel = [[TopListViewModel alloc] initWithApiService:nil navigationService:self.navigationService];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark - navigationService初始化测试

- (void)testNavigationServiceExist{
    XCTAssertTrue(self.navigationService);
}


- (void)testNavigationServicePropertyNavigationControllerHasValue{
    XCTAssertNotNil(self.navigationService.navigationController);
}

#pragma mark - viewModel初始化测试

- (void)testViewModelExist{
    XCTAssertTrue(self.viewModel);
}


- (void)testViewModelReferToATopListNavigationServiceInstance{
    XCTAssertTrue([self.viewModel.navigationService isKindOfClass:[TopListNavigationService class]]);
    XCTAssertNotNil(self.viewModel.navigationService);
}


#pragma mark - controller初始化测试

- (void)test_Before_ViewDidLoad_ViewModelIsExist{
    UINavigationController *navVC = [[UINavigationController alloc] init];
    TopListNavigationService *navService = [[TopListNavigationService alloc] initWithNavigationController:navVC];
    TopListViewModel *viewModel = [[TopListViewModel alloc] initWithCategoryId:@"100" apiService:nil navigationService:navService];
    XCTestExpectation *exp = [self expectationWithDescription:@"超时了"];
    TopListViewControllerMock *mockVC = [[TopListViewControllerMock alloc] initWithViewModel:viewModel];
    mockVC.beforeViewDidLoadHandler = ^(TopListViewControllerMock *mockVC){
        XCTAssertNotNil(mockVC.viewModel);
        [exp fulfill];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:mockVC.view];
    [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        [mockVC.view removeFromSuperview];
    }];
}


/**
 如果不关心ApiService是何时、怎么被创建的，可以不写这样的测试用例，因为这种测试用例也算是测试controller的内部实现了。
 */
- (void)test_After_ViewDidLoad_ApiServiceIsCreated_AndRequestDataWithCategoryIdFromViewModel{
    
}

/**
 只关注controller的行为是否正确，那就以特定条件去初始化它后，它的状态是否做了相应的改变，中间过程不管。
 不过这样的测试用例失败后可能不容易排查问题，因为中间过程可能很多。所以，如果有可能，还是把每一个重要的过程用一个独立
 的测试用例去覆盖，一旦测试用例失败了，很快就能定位到哪个环节出了问题。
 单元测试测UI的行为是力不从心的，只有少数情况可以测一下，比如viewDidLoad方法的调用，其他生命周期方法，有些情况可以
 直接调用来观察，有时候不行，毕竟由系统托管的方法，还是不要随意由我们自己调用的好。单元测试主要用途是测试单个对象和其内部逻辑。
 */

- (void)test_viewDidLoad_WithFailureRequest{
    TopListApiServiceMock *apiServiceMock = [[TopListApiServiceMock alloc] init];
    TopListViewModel *viewModel = [[TopListViewModel alloc] initWithCategoryId:@"100" apiService:apiServiceMock navigationService:nil];
    XCTestExpectation *exp = [self expectationWithDescription:@"超时了"];
    TopListViewController *vc = [[TopListViewController alloc] initWithViewModel:viewModel];
    //要用异步测试机制，一定要显式地调动有异步操作的方法，否则不会执行异步测试机制
    [vc viewDidLoad];
    __block BOOL called = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        called = YES;
        UILabel *msgLb = [vc.view labelWithText:@"网络出问题了"];
        XCTAssertNotNil(msgLb);
        [exp fulfill];
    });
    
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        XCTAssertTrue(called);
        [vc.view removeFromSuperview];
    }];
}

@end





















