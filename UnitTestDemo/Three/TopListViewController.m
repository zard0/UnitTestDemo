//
//  TopListViewController.m
//  ViewControllerUnitTestDemo
//
//  Created by linkunzhu on 2017/7/21.
//  Copyright © 2017年 易图资讯. All rights reserved.
//

#import "TopListViewController.h"

@interface TopListViewController ()

@property (nonatomic, strong) id<TopListApiServiceProtocol> apiService;
@property (nonatomic, strong) id<NavigationServiceProtocol> navigationService;
@property (nonatomic, strong) UILabel *noDataMsgLb;

@end

@implementation TopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.viewModel && self.viewModel.apiService) {
        [self.apiService getTopListWithCategoryId:self.viewModel.categoryId success:^(NSDictionary *response) {
            
        } failure:^(NSString *errorMsg) {
            if (!self.noDataMsgLb) {
                self.noDataMsgLb = [[UILabel alloc] initWithFrame:CGRectZero];
            }
            [self.view addSubview:self.noDataMsgLb];
            self.noDataMsgLb.text = errorMsg;
            [self.noDataMsgLb sizeToFit];
            self.noDataMsgLb.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
        }];
    }
}

- (instancetype)initWithViewModel:(TopListViewModel *)viewModel{
    if (self = [super init]) {
        _viewModel = viewModel;
        _apiService = _viewModel.apiService;
        _navigationService = _viewModel.navigationService;
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
