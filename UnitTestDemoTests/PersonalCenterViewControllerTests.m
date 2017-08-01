//
//  PersonalCenterViewControllerTests.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/1.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PersonalCenterViewController.h"
#import "PersonalCenterViewControllerMock.h"
#import "PersonalCenterViewModelMock.h"
#import "PersonalCenterApiServiceMock.h"

@interface PersonalCenterViewControllerTests : XCTestCase

@property (nonatomic, strong) PersonalCenterViewController *vc;
@property (nonatomic, strong) PersonalCenterApiServiceMock *apiService;
@property (nonatomic, strong) PersonalCenterViewModelMock *viewModel;

@end

@implementation PersonalCenterViewControllerTests

- (void)setUp {
    [super setUp];
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    self.vc = [sb instantiateViewControllerWithIdentifier:@"PersonalCenterViewController"];
//    
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    [window addSubview:self.vc.view];
//    [window makeKeyAndVisible];
}

- (void)tearDown {
    [self.vc.view removeFromSuperview];
    self.apiService = nil;
    self.viewModel = nil;
    self.vc = nil;
    [super tearDown];
}


//- (void)testShouldShowADefaultAvatar{
//    UIImageView *avatarView = [self.vc.view viewWithTag:100];
//    XCTAssertNotNil(avatarView.image);
//}
//
//- (void)testAvatarSizeIs50x50{
//    UIImageView *avatarView = [self.vc.view viewWithTag:100];
//    XCTAssertEqual(avatarView.frame.size.width, 50);
//    XCTAssertEqual(avatarView.frame.size.height, 50);
//}

- (void)testApiServiceIsReadyBeforeViewDidLoad{
    [self setupPersonalCenterControllerWithUserId:@"100" isMock:YES];
    XCTestExpectation *exp = [self expectationWithDescription:@"超时了"];
    self.vc.methodCalledHandler = ^(NSString *methodName, id info) {
        XCTAssertEqual(methodName, @"viewDidLoad");
        XCTAssertNotNil(self.vc.viewModel.apiService);
        [exp fulfill];
    };
    // 会触发viewDidLoad方法
    [self makeControllerVisible];
    [self waitForExpectationsWithTimeout:4 handler:nil];
}

- (void)testNameLabelShouldHasText{
    self.apiService = [[PersonalCenterApiServiceMock alloc] initWithUserId:@"100"];
    self.viewModel = [[PersonalCenterViewModelMock alloc] initWithApiService:self.apiService navigationService:nil];
    self.vc = [self personalCenterControllerByStoryboard];
    self.vc.viewModel = self.viewModel;
    UILabel *nameLb = [self.vc.view viewWithTag:200];
    XCTestExpectation *exp = [self expectationWithDescription:@"超时了"];
    dispatch_after(4, dispatch_get_main_queue(), ^{
        XCTAssertNotNil(nameLb.text);
        XCTAssertNotEqual(nameLb.text.length, 0);
        [exp fulfill];
    });
    [self makeControllerVisible];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

#pragma mark - Helper

- (void)setupPersonalCenterControllerWithUserId:(NSString *)userId isMock:(BOOL)isMock{
    self.apiService = [[PersonalCenterApiServiceMock alloc] initWithUserId:userId];
    self.viewModel = [[PersonalCenterViewModelMock alloc] initWithApiService:self.apiService navigationService:nil];
    if (isMock) {
        self.vc = [[PersonalCenterViewControllerMock alloc] initWithViewModel:self.viewModel];
    }else{
        self.vc = [[PersonalCenterViewController alloc] initWithViewModel:self.viewModel];
    }
}

- (PersonalCenterViewController *)personalCenterControllerByStoryboard{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:@"PersonalCenterViewController"];
}


- (void)makeControllerVisible{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.vc.view];
    [window makeKeyAndVisible];
}
@end















