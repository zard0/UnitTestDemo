//
//  PersonalCenterViewModel.m
//  ViewControllerUnitTestDemo
//
//  Created by linkunzhu on 2017/7/25.
//  Copyright © 2017年 易图资讯. All rights reserved.
//

#import "PersonalCenterViewModel.h"

@implementation PersonalCenterViewModel

- (instancetype)initWithUserId:(NSString *)userId navigationService:(PersonalCenterNavigationService *)service{
    if (self = [super init]) {
        _userId = userId;
        _navigationService = service;
    }
    return self;
}

- (void)toPersonalCenter{
    [self.navigationService toDestinationControllerWithInfo:self];
}

@end
