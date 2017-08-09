//
//  TopListViewControllerMock.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/6.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "TopListViewControllerMock.h"

@interface TopListViewControllerMock ()

@end

@implementation TopListViewControllerMock

- (void)viewDidLoad {
    if (self.beforeViewDidLoadHandler) {
        self.beforeViewDidLoadHandler(self);
    }
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.afterViewDidApearHandler) {
        self.afterViewDidApearHandler(self);
    }
}

@end
