//
//  YTInsetsLabel.h
//  YTSlideMenuDemo
//
//  Created by linkunzhu on 16/11/23.
//  Copyright © 2016年 linkunzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTInsetsLabel : UILabel

@property (nonatomic, assign) UIEdgeInsets insets;

-(id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets;
-(id)initWithInsets:(UIEdgeInsets)insets;

@end
