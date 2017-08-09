//
//  TopListApiServiceTests.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/6.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TopListApiServiceMock.h"

@interface TopListApiServiceTests : XCTestCase

@property (nonatomic, strong) TopListApiServiceMock *serviceMock;

@end

@implementation TopListApiServiceTests

- (void)setUp {
    [super setUp];
    self.serviceMock = [[TopListApiServiceMock alloc] init];
}

- (void)tearDown {
    self.serviceMock = nil;
    [super tearDown];
}

- (void)test_ConformTo_TopListApiServiceProtocol{
    XCTAssertTrue([self.serviceMock conformsToProtocol:@protocol(TopListApiServiceProtocol) ]);
}

- (void)test_ImplMethod_GetTopListWithCategoryIdSuccessFailure{
    XCTAssertTrue([self.serviceMock respondsToSelector:@selector(getTopListWithCategoryId:success:failure:)]);
}

- (void)test_CategoryId_100_RequestFailure_withErrorMsgNoResponse{
    XCTestExpectation *exp = [self expectationWithDescription:@"超时了"];
    __block NSInteger count = 0;
    [self.serviceMock getTopListWithCategoryId:@"100" success:^(NSDictionary *response) {
        count++;
    } failure:^(NSString *errorMsg) {
        XCTAssertEqual(errorMsg, @"网络出问题了");
        // 调用了失败block，获得了正确的失败提示信息，则期待被满足
        [exp fulfill];
    }];
    [self waitForExpectationsWithTimeout:2 handler:^(NSError * _Nullable error) {
        // 等待时间过后，无论是否符合期待，这个handler最后总会被执行
        // 所以适合在这里验证在其他地方无法被验证的断言
        // success block 不能被调用
        XCTAssertEqual(count, 0);
    }];
}

@end




















