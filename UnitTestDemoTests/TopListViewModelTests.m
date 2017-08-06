//
//  TopListViewModelTests.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/5.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TopListNavigationService.h"
#import "TopListViewModel.h"

@interface TopListViewModelTests : XCTestCase

@end

@implementation TopListViewModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testViewModelPropertyNavigationServiceIsWeak{
    __block TopListViewModel *viewModel;
    @autoreleasepool {
        TopListNavigationService *navigationService = [[TopListNavigationService alloc] init];
        viewModel = [[TopListViewModel alloc] initWithApiService:nil navigationService:navigationService];
    }
    XCTAssertNil(viewModel.navigationService);
}


@end
