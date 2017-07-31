//
//  FirstViewController.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/27.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalCenterViewModel.h"
#import "PersonalCenterNavigationService.h"

@interface FirstViewController : UIViewController

/// 暴露出来，方便注入mock对象测试
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, strong) PersonalCenterNavigationService *personalCenterNavService;

@end

