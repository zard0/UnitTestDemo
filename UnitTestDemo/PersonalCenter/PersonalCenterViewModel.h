//
//  PersonalCenterViewModel.h
//  ViewControllerUnitTestDemo
//
//  Created by linkunzhu on 2017/7/25.
//  Copyright © 2017年 易图资讯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalCenterViewModel : NSObject

/**
 跳转到用户中心页面

 @param userId <#userId description#>
 */
- (void)toPersonalCenterWithUserId:(NSString *)userId;
- (void)toPersonalCenter;

@end
