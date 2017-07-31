//
//  PersonalCenterNavigationServiceMock.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/31.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "PersonalCenterNavigationService.h"

/**
 个人中心模块导航服务对象的模拟类。用来作为依赖注入PersonalCenterViewModelMock。
 */
@interface PersonalCenterNavigationServiceMock : PersonalCenterNavigationService

///用来通知外面什么方法被调用了，参数是被调用的方法名
@property (nonatomic, copy) void(^methodCalledHandler)(NSString *methodName, id info);

@end
