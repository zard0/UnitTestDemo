//
//  TopListViewModel.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/5.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "TopListViewModel.h"

@implementation TopListViewModel

- (instancetype)initWithApiService:(id<ApiServiceProtocol>)apiService navigationService:(id<NavigationServiceProtocol>)navigationService{
    if (self = [super init]) {
        _apiService = apiService;
        _navigationService = navigationService;
    }
    return self;
}

@end
