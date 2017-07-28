//
//  PersonalCenterViewController.h
//  ViewControllerUnitTestDemo
//
//  Created by linkunzhu on 2017/7/25.
//  Copyright © 2017年 易图资讯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalCenterViewModel.h"

@interface PersonalCenterViewController : UIViewController

/// 方便测试。需要时弱引用，因为viewModel被上一个页面所创建和持有。
@property (nonatomic, weak, readonly) PersonalCenterViewModel *viewModel;

/**
 最常用的构造方法
 
 @param viewModel <#viewModel description#>
 @return <#return value description#>
 */
- (instancetype)initWithViewModel:(PersonalCenterViewModel *)viewModel;

@end
