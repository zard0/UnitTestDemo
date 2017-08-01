//
//  UINavigationControllerMock.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/31.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 系统导航控制器对象的模拟类。用来作为依赖注入PersonalCenterNavigationService。
 争取做到测试不依赖于苹果系统代码的实现。
 */
@interface UINavigationControllerMock : UINavigationController

///用来通知外面什么方法被调用了，参数是被调用的方法名
@property (nonatomic, copy) void(^methodCalledHandler)(NSString *methodName, id info);

@end
