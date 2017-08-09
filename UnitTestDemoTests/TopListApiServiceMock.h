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

/// 方便测试确认上层拿到数据后是否做了正确的事情
@property (nonatomic, copy) void(^didLoadData)();
/// 被无回调异步方法执行后改变的属性
@property (nonatomic, assign) NSInteger count;

/// 无回调的异步方法
- (void)doSomethingAsynWithoutCallBack;

@end
