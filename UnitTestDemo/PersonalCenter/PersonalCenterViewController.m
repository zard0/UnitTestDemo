//
//  PersonalCenterViewController.m
//  ViewControllerUnitTestDemo
//
//  Created by linkunzhu on 2017/7/25.
//  Copyright © 2017年 易图资讯. All rights reserved.
//

#import "PersonalCenterViewController.h"

@interface PersonalCenterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (weak, nonatomic) IBOutlet UILabel *userDescLb;


@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.viewModel.apiService.getDataSuccess = ^(id data) {
        self.userNameLb.text = data[@"Data"][@"UserName"];
        self.userDescLb.text = data[@"Data"][@"UserDesc"];
    };
    [self.viewModel.apiService loadData];
}

- (instancetype)initWithViewModel:(PersonalCenterViewModel *)viewModel{
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}

@end
