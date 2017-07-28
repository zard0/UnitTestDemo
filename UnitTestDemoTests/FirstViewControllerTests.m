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

#import "UIView+TestingHelper.h"
#import "UIButton+TestingHelper.h"

@interface FirstViewControllerTests : XCTestCase

@property (nonatomic, strong) FirstViewController *vc;

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
    UIApplication *app = [UIApplication sharedApplication];
    [app.keyWindow addSubview:self.vc.view];
    [app.keyWindow makeKeyAndVisible];
}

- (void)tearDown {
    [self.vc.view removeFromSuperview];
    self.vc = nil;
    [super tearDown];
}

/// 不起作用，因为vc通过sb初始化失败后，不会执行测试用例
- (void)testInitFirstViewControllerSuccessWithStoryboard{
    XCTAssertNotNil(self.vc);
}

- (void)testViewShouldContainToNextPageButton{
    
    UIButton *button = [self.vc.view buttonWithText:@"下一页"];
    XCTAssertNotNil(button);
}

- (void)testExistPersonalCenterViewModelInstance{
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

/// 如果产品的代码的push方法的animated参数必须是YES，那么得用依赖注入的方式，测试调用push方法的方法是否执行。确认这一点就好，不用继续确认是否真的push成功。
/// 因为，push方法，属于苹果代码，单元测试的原则是，我们不测试苹果代码。因此这里，我们只确认调用了push方法即可。
/// 但是，这里，除了观察navVC.topViewController的属性值变更外，好像没别的办法观察到执行了push方法的效果。
/// 所以，要通过依赖注入的方法，暴露相关对象，然后检验被依赖对象的状态改变
- (void)testTapNextPageButtonShouldInvokePersonalCenterViewModelExecuteToPersonalCenterMethod{
    

}


@end























