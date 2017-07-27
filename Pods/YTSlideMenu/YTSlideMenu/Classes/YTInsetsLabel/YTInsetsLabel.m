//
//  YTInsetsLabel.m
//  YTSlideMenuDemo
//
//  Created by linkunzhu on 16/11/23.
//  Copyright © 2016年 linkunzhu. All rights reserved.
//

#import "YTInsetsLabel.h"

@interface YTInsetsLabel()

@end

@implementation YTInsetsLabel

-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(id) initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(void) drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

@end
