//
//  PersonalCenterViewModel.h
//  ViewControllerUnitTestDemo
//
//  Created by linkunzhu on 2017/7/25.
//  Copyright © 2017年 易图资讯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalCenterNavigationService.h"

@interface PersonalCenterViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *userId;
/// 负责导航
@property (nonatomic, weak, readonly) PersonalCenterNavigationService *navigationService;

- (instancetype)initWithUserId:(NSString *)userId navigationService:(PersonalCenterNavigationService *)service;

/**
 跳转到用户中心页面
 */
- (void)toPersonalCenter;

@end
