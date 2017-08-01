//
//  ApiServiceProtocol.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/1.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 成为一个ApiService类要遵循的协议
 */
@protocol ApiServiceProtocol <NSObject>

@property (nonatomic, copy) void(^getDataSuccess)(id data);

- (void)loadData;

@end
