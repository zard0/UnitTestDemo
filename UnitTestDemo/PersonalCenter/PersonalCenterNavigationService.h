//
//  PersonalCenterNavigationService.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/31.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 个人中心模块导航服务对象
 */
@interface PersonalCenterNavigationService : NSObject

@property (nonatomic, readonly) UINavigationController *navigationController;
@property (nonatomic, readonly) UIViewController *destinationController;
@property (nonatomic, readonly) id transferInfo;

- (instancetype)initWithNavigationController:(UINavigationController *)navVC;
/**
 导航方法

 @param info 存储导航到下一个界面所需携带的参数
 */
- (void)toDestinationControllerWithInfo:(id)info;

@end
