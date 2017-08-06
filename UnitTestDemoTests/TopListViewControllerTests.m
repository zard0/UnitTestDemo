//
//  TopListViewControllerTests.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/5.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TopListViewController.h"
#import "TopListNavigationService.h"
#import "TopListViewModel.h"

@interface TopListViewControllerTests : XCTestCase

///这三个属性会在上一个页面的控制器里面被强引用。用这种方式，控制器在跳转到其他模块是可以不需要关联控制器，方便以后维护。
@property (nonatomic, strong) TopListNavigationService *navigationService;
@property (nonatomic, strong) TopListViewModel *viewModel;

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

- (void)testViewModelIsReady{
    
}

- (void)testApiServiceIsReady{
    //XCTAssertNotNil(self.apiService);
}

- (void)testNavigationServiceIsReady{
    
}



@end














