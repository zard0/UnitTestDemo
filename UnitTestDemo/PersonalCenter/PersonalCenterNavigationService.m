//
//  PersonalCenterNavigationService.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/7/31.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "PersonalCenterNavigationService.h"
#import "PersonalCenterViewController.h"
#import "PersonalCenterViewModel.h"

@implementation PersonalCenterNavigationService

- (instancetype)initWithNavigationController:(UINavigationController *)navVC{
    if (self = [super init]) {
        _navigationController = navVC;
    }
    return self;
}

- (void)toDestinationControllerWithInfo:(id)info{
    if ([info isKindOfClass:[PersonalCenterViewModel class]]) {
        PersonalCenterViewModel *viewModel = (PersonalCenterViewModel *)info;
        _destinationController = [[PersonalCenterViewController alloc] initWithViewModel:viewModel];
        _transferInfo = viewModel;
        [self.navigationController pushViewController:self.destinationController animated:YES];
    }
}

@end
