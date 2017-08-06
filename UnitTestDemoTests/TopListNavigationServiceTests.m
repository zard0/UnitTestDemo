//
//  TopListNavigationServiceTests.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/5.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TopListNavigationService.h"
#import "TopListViewModel.h"
#import "TopListViewController.h"

@interface TopListNavigationServiceTests : XCTestCase

@property (nonatomic, strong) UINavigationController *lastNav;
@property (nonatomic, strong) TopListNavigationService *navigationService;

@end

@implementation TopListNavigationServiceTests

- (void)setUp {
    [super setUp];
    self.lastNav = [[UINavigationController alloc] init];
    self.navigationService = [[TopListNavigationService alloc] initWithNavigationController:self.lastNav];
}

- (void)tearDown {
    self.lastNav = nil;
    self.navigationService = nil;
    
    [super tearDown];
}

- (void)testNavigationServiceConformNavigtionServiceProtocol{
    XCTAssertTrue([self.navigationService conformsToProtocol:@protocol(NavigationServiceProtocol)]);
}

- (void)testNavigationServiceImplInitWithNavigationControllerMethod{
    XCTAssertTrue([self.navigationService respondsToSelector:@selector(initWithNavigationController:)]);
}

- (void)testNavigationServiceImplToControllerWithViewModelMethod{
    XCTAssertTrue([self.navigationService respondsToSelector:@selector(toControllerWithViewModel:)]);
}

- (void)testNavigationServicePropertyDestinationControllerIsReadonly{
    XCTAssertTrue([self.navigationService respondsToSelector:@selector(destinationController)]);
    XCTAssertFalse([self.navigationService respondsToSelector:@selector(setDestinationController:)]);
}

- (void)testNavigationServicePropertyNavigationControllerIsWeak{
    __block TopListNavigationService *service;
    @autoreleasepool {
        service = [[TopListNavigationService alloc] initWithNavigationController:[[UINavigationController alloc] init]];
    }
    // weak引用，会被自动释放池释放，强引用不会。
    XCTAssertNil(service.navigationController);
}

- (void)test_Call_ToControllerWithViewModel_WithoutNavigationController_WillNotCreateDestinationController{
    TopListNavigationService *service = [[TopListNavigationService alloc] initWithNavigationController:nil];
    TopListViewModel *viewModel = [[TopListViewModel alloc] init];
    [service toControllerWithViewModel:viewModel];
    XCTAssertNil(service.destinationController);
}

- (void)test_Call_ToControllerWithViewModel_WithNilViewModel_WillCreateDestination_AsTopListViewControllerWithNilViewModelNilApiServiceNilNavigationService{
    [self.navigationService toControllerWithViewModel:nil];
    XCTAssertNil(self.navigationService.destinatioViewModel);
    XCTAssertTrue([self.navigationService.destinationController isKindOfClass:[TopListViewController class]]);
    TopListViewController *controller = (TopListViewController *)self.navigationService.destinationController;
    XCTAssertNil(controller.viewModel);
    XCTAssertNil(controller.navigationService);
}

- (void)test_Call_ToControllerWithViewModel_WithNotNilButNotTopListViewModel_WillNotCreateDestinationController{
    NSObject *otherViewModel = [[NSObject alloc] init];
    [self.navigationService toControllerWithViewModel:otherViewModel];
    XCTAssertNil(self.navigationService.destinatioViewModel);
}

- (void)test_Call_ToControllerWithViewModel_WithFullyInitedViewModel_WillCreateDestination_AsTopListViewControllerWithViewModelApiServiceNavigationService{
    // 不是很多测试用例用到的资源就不要放在setUp方法执行，以免影响其他用例的执行速度
    TopListViewModel *viewModel = [[TopListViewModel alloc] initWithApiService:nil navigationService:self.navigationService];
    [self.navigationService toControllerWithViewModel:viewModel];
    XCTAssertNotNil(self.navigationService.navigationController);
    XCTAssertNotNil(self.navigationService.destinatioViewModel);
    XCTAssertNotNil(self.navigationService.destinationController);
    XCTAssertTrue([self.navigationService.destinationController isKindOfClass:[TopListViewController class]]);
    TopListViewController *controller = (TopListViewController *)self.navigationService.destinationController;
    XCTAssertNotNil(controller.viewModel);
    XCTAssertNotNil(controller.navigationService);
}

@end


















