//
//  TopListApiServiceMock.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/5.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "TopListApiServiceProtocol.h"

/**
 1，没有网络环境；2，TopListApiService组件未开发完成。
 都不影响我们测试ViewModel的网络交互相关逻辑，我们只需要用Mock方式去测试。
 */
@interface TopListApiServiceMock : NSObject<TopListApiServiceProtocol>

@end