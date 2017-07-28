//
//  PersonalCenterViewController.m
//  ViewControllerUnitTestDemo
//
//  Created by linkunzhu on 2017/7/25.
//  Copyright © 2017年 易图资讯. All rights reserved.
//

#import "PersonalCenterViewController.h"

@interface PersonalCenterViewController (){
    PersonalCenterViewModel *_viewModel;
}

@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithViewModel:(PersonalCenterViewModel *)viewModel{
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}

- (PersonalCenterViewModel *)viewModel{
    return _viewModel;
}

@end
