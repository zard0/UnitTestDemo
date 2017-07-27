//
//  YTMarkView.m
//  YTSlideMenuDemo
//
//  Created by linkunzhu on 16/11/22.
//  Copyright © 2016年 linkunzhu. All rights reserved.
//

#import "YTMarkView.h"

/**
 *  @author linkunzhu, 16-11-22 18:11:51
 *
 *  这个View加到别的View上面，点击它时，它不拦截点击事件，让事件直接穿透它传给在它下面的View。
    使用场景：有些地方需要用到一些覆盖view来标记位置，但是又不想让这些覆盖view影响点击等交互事件。
 */

@implementation YTMarkView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return NO;
}

@end
