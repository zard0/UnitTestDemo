//
//  YTInsetsLabel.m
//  YTSlideMenuDemo
//
//  Created by linkunzhu on 16/11/23.
//  Copyright © 2016年 linkunzhu. All rights reserved.
//

#import "SomeClass.h"

@interface SomeClass()

@end

@implementation SomeClass

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
