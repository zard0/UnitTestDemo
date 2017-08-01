//
//  UINavigationControllerMock.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/31.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "UINavigationControllerMock.h"

@implementation UINavigationControllerMock

- (void)callMethod:(NSString *)method withInfo:(id)info{
    if (self.methodCalledHandler) {
        self.methodCalledHandler(method,info);
    }
}

/// 重写
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self callMethod:@"pushViewController" withInfo:viewController];
    [super pushViewController:viewController animated:animated];
}

@end
