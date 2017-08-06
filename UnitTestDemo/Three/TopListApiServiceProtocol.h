//
//  TopListApiServiceProtocol.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/5.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 ViewModel只需要跟TopListApiServiceProtocol的方法、属性打交道，协议只需要提供方便ViewModel设置请求参数和
 拿到返回值的方法。依赖TopListApiServiceProtocol协议，可以让我们在真正的TopListApiServiceProtocol组件
 还没准备好之前就可以测试ViewModel的逻辑，我们只需要根据协议，实现一个Mock组件去测试ViewModel就行了。
 */
@protocol TopListApiServiceProtocol <NSObject>

- (void)getTopListWithCategoryId:(NSString *)categoryId
                    success:(void(^)(NSDictionary *response))success
                    failure:(void(^)(NSString *errorMsg))failure;

@end
