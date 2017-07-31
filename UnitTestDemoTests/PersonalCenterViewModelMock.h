//
//  PersonalCenterViewModelMock.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/31.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "PersonalCenterViewModel.h"

/**
 模拟真实的PersonalCenterViewModel，在测试时作为依赖注入。
 */
@interface PersonalCenterViewModelMock : PersonalCenterViewModel

/**
 用来通知外面什么方法被调用了，参数是被调用的方法名

 @param handler <#handler description#>
 */
- (void)methodCalled:(void(^)(NSString *methodName))handler;

@end
