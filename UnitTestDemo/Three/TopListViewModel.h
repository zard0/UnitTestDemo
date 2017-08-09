//
//  TopListViewModel.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/5.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "TopListApiServiceProtocol.h"
#import "NavigationServiceProtocol.h"

@interface TopListViewModel : NSObject

@property (nonatomic, readonly, copy) NSString *categoryId;
@property (nonatomic, readonly, weak) id<TopListApiServiceProtocol> apiService;
@property (nonatomic, readonly, weak) id<NavigationServiceProtocol> navigationService;


/**
 通过初始化方法，强制要求获得apiService和navigationService

 @param apiService <#apiService description#>
 @param navigationService <#navigationService description#>
 @return <#return value description#>
 */
- (instancetype)initWithApiService:(id<TopListApiServiceProtocol>)apiService
                 navigationService:(id<NavigationServiceProtocol>)navigationService;
- (instancetype)initWithCategoryId:(NSString *)categoryId
                        apiService:(id<TopListApiServiceProtocol>)apiService
                 navigationService:(id<NavigationServiceProtocol>)navigationService;

@end
