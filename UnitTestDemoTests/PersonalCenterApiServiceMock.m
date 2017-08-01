//
//  PersonalCenterApiServiceMock.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/1.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "PersonalCenterApiServiceMock.h"

@implementation PersonalCenterApiServiceMock



- (void)loadData{
    // 两秒钟后，返回userId的本地测试数据
    dispatch_after(2, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self responseData:[self getLocalUserDataWithUserId:self.userId]];
    });
}

- (void)responseData:(NSDictionary *)data{
    if (self.getDataSuccess) {
        self.getDataSuccess(data);
    }
}

/**
 获取到所有本地测试用户的本地数据
 
 @param userId <#userId description#>
 @return <#return value description#>
 */
- (NSDictionary *)getLocalUserDataWithUserId:(NSString *)userId{
    NSDictionary *userData;
    NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
    NSString *plistPath = [thisBundle pathForResource:@"PersonalCenterApiTestData" ofType:@"plist"];
    NSDictionary *datasDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *allUserIds = [datasDic allKeys];
    for (NSString *key in allUserIds) {
        if ([key isEqualToString:userId]) {
            userData = datasDic[key];
        }
    }
    
    return userData;
}


@end
