//
//  TopListNavigationService.m
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/5.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "TopListNavigationService.h"
#import "TopListViewController.h"
#import "TopListViewModel.h"

@implementation TopListNavigationService

@synthesize navigationController = _navigationController, destinationController = _destinationController, destinatioViewModel = _destinationViewModel;

#pragma mark - Navigation Service Protocol

- (instancetype)initWithNavigationController:(UINavigationController *)navVC{
    if (self = [super init]) {
        _navigationController = navVC;
    }
    return self;
}

- (void)toControllerWithViewModel:(id)viewModel{
    if (!self.navigationController) {
        return;
    }
    if (viewModel && ![viewModel isKindOfClass:[TopListViewModel class]]) {
        return;
    }
    _destinationViewModel = viewModel;
    _destinationController = [[TopListViewController alloc] initWithViewModel:self.destinatioViewModel];
    [self.navigationController pushViewController:self.destinationController animated:YES];
}


@end
