//
//  FirstViewController.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/27.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "FirstViewController.h"
#import "PersonalCenterViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (PersonalCenterViewModel *)personalCenterVM{
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}
- (IBAction)tapNextPageButton:(id)sender {
    PersonalCenterViewController *vc = [[PersonalCenterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
