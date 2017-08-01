//
//  PersonalCenterApiService.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/1.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "PersonalCenterApiService.h"

@implementation PersonalCenterApiService

@synthesize getDataSuccess;

- (instancetype)initWithUserId:(NSString *)userId{
    if (self = [super init]) {
        _userId = userId;
    }
    return self;
}

- (void)loadData{

}



@end
