//
//  UIView+TestingHelper.h
//  ViewControllerUnitTestDemo
//
//  Created by linkunzhu on 2017/7/25.
//  Copyright © 2017年 易图资讯. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 帮助测试用例根据text获取view里面的button和label
 */
@interface UIView (TestingHelper)

- (UIButton *)buttonWithText:(NSString *)text;
- (UILabel *)labelWithText:(NSString *)text;

@end
