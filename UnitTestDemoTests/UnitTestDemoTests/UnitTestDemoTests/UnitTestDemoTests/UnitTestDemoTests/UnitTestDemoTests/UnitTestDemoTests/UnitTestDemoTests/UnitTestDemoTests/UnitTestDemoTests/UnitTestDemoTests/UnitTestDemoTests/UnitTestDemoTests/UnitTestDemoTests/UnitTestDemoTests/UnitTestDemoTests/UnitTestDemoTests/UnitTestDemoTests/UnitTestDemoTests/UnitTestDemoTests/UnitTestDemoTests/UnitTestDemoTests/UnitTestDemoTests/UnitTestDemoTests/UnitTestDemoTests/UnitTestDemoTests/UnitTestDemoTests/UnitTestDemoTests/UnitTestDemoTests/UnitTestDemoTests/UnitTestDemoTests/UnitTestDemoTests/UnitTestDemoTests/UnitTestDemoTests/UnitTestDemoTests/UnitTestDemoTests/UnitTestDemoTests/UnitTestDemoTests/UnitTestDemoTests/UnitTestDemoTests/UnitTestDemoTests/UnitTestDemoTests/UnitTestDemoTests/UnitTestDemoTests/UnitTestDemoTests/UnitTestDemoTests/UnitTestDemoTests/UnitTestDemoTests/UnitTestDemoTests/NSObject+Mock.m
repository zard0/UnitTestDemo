//
//  NSObject+Mock.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/1.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "NSObject+Mock.h"
#import <objc/runtime.h>

static const void * MethodCalledHandlerKey = &MethodCalledHandlerKey;

@implementation NSObject (Mock)

@dynamic methodCalledHandler;

- (void(^)(NSString *methodName, id info))methodCalledHandler{
    return objc_getAssociatedObject(self, MethodCalledHandlerKey);
}

- (void)setMethodCalledHandler:(void (^)(NSString *, id))methodCalledHandler{
    objc_setAssociatedObject(self, MethodCalledHandlerKey, methodCalledHandler, OBJC_ASSOCIATION_COPY);
}

- (void)callMethod:(NSString *)method withInfo:(id)info{
    if (self.methodCalledHandler) {
        self.methodCalledHandler(method,info);
    }
}

@end
