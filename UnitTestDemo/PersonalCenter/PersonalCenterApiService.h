//
//  PersonalCenterApiService.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/1.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiServiceProtocol.h"

/**
 负责个人中心页的数据获取服务
 */
@interface PersonalCenterApiService : NSObject<ApiServiceProtocol>

@property (nonatomic, readonly, weak) NSString *userId;

- (instancetype)initWithUserId:(NSString *)userId;

@end
