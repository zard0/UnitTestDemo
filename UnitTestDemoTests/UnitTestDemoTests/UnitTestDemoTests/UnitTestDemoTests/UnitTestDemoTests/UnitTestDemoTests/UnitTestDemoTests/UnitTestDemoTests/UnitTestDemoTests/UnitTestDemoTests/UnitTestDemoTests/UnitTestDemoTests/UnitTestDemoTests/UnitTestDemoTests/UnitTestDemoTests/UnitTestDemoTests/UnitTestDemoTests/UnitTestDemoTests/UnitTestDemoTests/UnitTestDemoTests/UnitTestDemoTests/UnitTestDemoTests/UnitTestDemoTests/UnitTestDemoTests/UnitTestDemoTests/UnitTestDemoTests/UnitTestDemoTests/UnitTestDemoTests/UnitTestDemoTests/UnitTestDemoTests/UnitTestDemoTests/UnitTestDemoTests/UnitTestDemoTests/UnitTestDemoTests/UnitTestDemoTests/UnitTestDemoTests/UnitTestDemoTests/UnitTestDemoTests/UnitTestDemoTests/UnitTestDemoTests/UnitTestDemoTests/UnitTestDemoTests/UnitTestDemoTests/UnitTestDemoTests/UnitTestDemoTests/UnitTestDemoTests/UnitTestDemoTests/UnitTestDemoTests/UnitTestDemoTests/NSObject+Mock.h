//
//  NSObject+Mock.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/1.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Mock)

///用来通知外面什么方法被调用了，参数是被调用的方法名
@property (nonatomic, copy) void(^methodCalledHandler)(NSString *methodName, id info);


/**
 在继承自被测类的Mock类里的重写的方法里面，在调用super方法之前或之后调用，用来唤起methodCalledHandler。

 @param method <#method description#>
 @param info <#info description#>
 */
- (void)callMethod:(NSString *)method withInfo:(id)info;

@end
