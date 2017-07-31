//
//  PersonalCenterNavigationServiceMock.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/31.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "PersonalCenterNavigationServiceMock.h"

@implementation PersonalCenterNavigationServiceMock

- (void)callMethod:(NSString *)method withInfo:(id)info{
    if (self.methodCalledHandler) {
        self.methodCalledHandler(method,info);
    }
}

- (void)toDestinationControllerWithInfo:(id)info{
    [self callMethod:@"toDestinationControllerWithInfo" withInfo:info];
    [super toDestinationControllerWithInfo:info];
}

@end
