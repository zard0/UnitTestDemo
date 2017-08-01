//
//  UIButton+TestingHelper.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/28.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "UIButton+TestingHelper.h"

@implementation UIButton (TestingHelper)

- (void)tapTheButton{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

@end
