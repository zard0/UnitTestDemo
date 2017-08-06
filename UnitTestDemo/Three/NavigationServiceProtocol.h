//
//  NavigationServiceProtocol.h
//  UnitTestDemo
//
//  Created by linkunzhu on 2017/8/5.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigationServiceProtocol <NSObject>

@property (nonatomic, readonly) UIViewController *destinationController;
@property (nonatomic, readonly, weak) id destinatioViewModel;
@property (nonatomic, readonly, weak) UINavigationController *navigationController;

- (instancetype)initWithNavigationController:(UINavigationController *)navVC;
- (void)toControllerWithViewModel:(id)viewModel;

@end
