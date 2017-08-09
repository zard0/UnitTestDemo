//
//  TopListViewControllerMock.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/6.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "TopListViewController.h"

@interface TopListViewControllerMock : TopListViewController

@property (nonatomic, copy) void(^beforeViewDidLoadHandler)(TopListViewControllerMock *mockVC);
@property (nonatomic, copy) void(^afterViewDidApearHandler)(TopListViewControllerMock *mockVC);

@end
