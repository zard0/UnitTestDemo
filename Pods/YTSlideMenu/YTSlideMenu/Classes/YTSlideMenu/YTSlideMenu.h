//
//  YTSlideMenu.h
//  YTSlideMenuDemo
//
//  Created by linkunzhu on 16/11/21.
//  Copyright © 2016年 linkunzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^slideBlock)(UIViewController *controller, NSInteger index);

@interface YTSlideMenu : NSObject
//如过没有办法通过- (void)showInView:(UIView *)view inController:(UIViewController *)controller;
//来显示菜单，那么就得通过对这个属性赋值的方式，让菜单拿到导航控制器，然后让菜单的子控制器再通过这个属性拿到导航控制器
@property (nonatomic, weak) UINavigationController *navVC;
@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, assign) CGFloat fontSize;

- (instancetype)initWithControllers:(NSArray *)controllers frame:(CGRect)frame;

/// 显示菜单方法
//拿不到控制器时的显示方法
- (void)showInView:(UIView *)view;
//可以知道当前控制器时建议使用的显示方法
//它可以让子控制器通过[subViewController.parentViewController navigationController]拿到导航控制器
- (void)showInView:(UIView *)view inController:(UIViewController *)controller;

/// 设置badge方法
- (void)showNoneBadgeForItem:(NSInteger)index;
- (void)showDotBadgeForItem:(NSInteger)index;
- (void)showMoreBadgeForItem:(NSInteger)index;
- (void)showBadgeText:(NSString *)text forItem:(NSInteger)index;
- (void)showCustomBadgeImage:(UIImage *)image forItem:(NSInteger)index;

/// 处理翻页事件
- (void)willMoveToPage:(slideBlock)block;
- (void)didMoveToPage:(slideBlock)block;

/// 调用翻页方法
- (void)moveToPageAtIndex:(NSInteger)index;

@end
