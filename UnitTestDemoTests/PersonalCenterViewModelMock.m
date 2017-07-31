//
//  PersonalCenterViewModelMock.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/31.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "PersonalCenterViewModelMock.h"

@interface PersonalCenterViewModelMock()

@property (nonatomic, copy) void(^methodCalledHandler)(NSString *methodName);

@end

@implementation PersonalCenterViewModelMock

- (void)methodCalled:(void (^)(NSString *))handler{
    self.methodCalledHandler = handler;
}

- (void)notiMethodCalled:(NSString *)methodName{
    if (self.methodCalledHandler) {
        self.methodCalledHandler(methodName);
    }
}

- (void)toPersonalCenter{
    [self notiMethodCalled:@"toPersonalCenter"];
    [super toPersonalCenter];
}

@end
