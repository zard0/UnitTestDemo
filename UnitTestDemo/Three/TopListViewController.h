//
//  TopListViewController.h
//  ViewControllerUnitTestDemo
//
//  Created by linkunzhu on 2017/7/21.
//  Copyright © 2017年 易图资讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopListViewModel.h"
#import "TopListNavigationService.h"

@interface TopListViewController : UITableViewController

/// 暴露属性，实现可测试性，strong引用，为了让控制器管理自己的相关资源，readonly为了强制使用指定的初始化方法
@property (nonatomic, readonly, strong) TopListNavigationService *navigationService;
@property (nonatomic, readonly, strong) TopListViewModel *viewModel;

- (instancetype)initWithViewModel:(TopListViewModel *)viewModel;

@end
