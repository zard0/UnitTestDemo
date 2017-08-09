//
//  TopListApiServiceMock.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/5.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "TopListApiServiceMock.h"

@interface TopListApiServiceMock()

@property (nonatomic, copy) void(^successHandler)(NSDictionary *response);
@property (nonatomic, copy) void(^failureHandler)(NSString *response);

@end

@implementation TopListApiServiceMock

- (void)getTopListWithCategoryId:(NSString *)categoryId success:(void (^)(NSDictionary *))success failure:(void (^)(NSString *))failure{
    self.successHandler = success;
    self.failureHandler = failure;
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//    });
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        /*
         虽然很容易想到这里构造一个本地文件来存储假数据，然后让mock读取假数据，这样写会不会更好一些呢？
         我觉得读文件的方式会存在以下缺点，而这些缺点正式写出好的测试用例要避免的。
         缺点：
         1，让测试用例去依赖外部配置文件，由于外部配置文件不稳定性，比如会被删除、修改等，
         会导致测试用例每次运行的结果无法保证一致性。
         2，外部依赖文件除了问题，依赖它的多个测试用例都会被影响，可能通不过，这时候我们要检查失败原因
         会比较困难，徒增了不少工作量。
         */
        sleep(2);//主线程子线程都可以用的延时方法
        if ([categoryId isEqualToString:@"100"]) {
            [self callBlocksWithResponse:nil errorMsg:@"网络出问题了"];
        }
        if (self.didLoadData) {
            self.didLoadData();
        }
    });
}

- (void)callBlocksWithResponse:(NSDictionary *)response errorMsg:(NSString *)errorMsg{
    if (response && self.successHandler) {
        self.successHandler(response);
    }
    if (errorMsg && self.failureHandler) {
        self.failureHandler(errorMsg);
    }
}

@end













