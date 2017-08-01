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

- (instancetype)initWithApiService:(id<ApiServiceProtocol>)apiService navigationService:(PersonalCenterNavigationService *)navService{
    if (self = [super init]) {
        _apiService = apiService;
        _navigationService = navService;
    }
    return self;
}

- (void)toPersonalCenter{
    [self.navigationService toDestinationControllerWithInfo:self];
}

@end
