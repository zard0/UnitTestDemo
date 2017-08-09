//
//  UIView+TestingHelper.m
//  ViewControllerUnitTestDemo
//
//  Created by linkunzhu on 2017/7/25.
//  Copyright © 2017年 易图资讯. All rights reserved.
//

#import "UIView+TestingHelper.h"

@implementation UIView (TestingHelper)

- (UIButton *)buttonWithText:(NSString *)text{
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            if ([button.titleLabel.text isEqualToString:text]) {
                return button;
            }else{
                [subview buttonWithText:text];
            }
        }else{
            [subview buttonWithText:text];
        }
    }
    return nil;
}

- (UILabel *)labelWithText:(NSString *)text{
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subview;
            if ([label.text isEqualToString:text]) {
                return label;
            }else{
                [subview labelWithText:text];
            }
        }else{
            [subview labelWithText:text];
        }
    }
    return nil;
}

@end
