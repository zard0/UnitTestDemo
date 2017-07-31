//
//  FirstViewController.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/27.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.personalCenterNavService = [[PersonalCenterNavigationService alloc] initWithNavigationController:self.navigationController];
    self.personalCenterVM = [[PersonalCenterViewModel alloc] initWithUserId:@"123" navigationService:self.personalCenterNavService];
}

- (void)dealloc{
    self.personalCenterNavService = nil;
    self.personalCenterVM = nil;
}

- (IBAction)tapNextPageButton:(id)sender {
    [self.personalCenterVM toPersonalCenter];
}

@end
