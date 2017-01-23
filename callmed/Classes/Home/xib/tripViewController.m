//
//  tripViewController.m
//  callmed
//
//  Created by wt on 2017/1/23.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "tripViewController.h"
#import "UserCenterMidCell.h"
#import "OrderListController.h"

@interface tripViewController ()<TargetActionDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic,strong) NSDictionary *dictionary;
@property (nonatomic,copy) NSString *accountId;
@end

@implementation tripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"行程"];
    self.view.backgroundColor = RGBHex(g_assit_gray);
    self.headerView.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    [_mTableView setBackgroundColor:RGBHex(g_assit_gray)];
    _mTableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchData];
    }];
}
#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ static NSString *user_header_id = @"user_header_id_middle";
    UserCenterMidCell *cell = [tableView dequeueReusableCellWithIdentifier:user_header_id];
    if (!cell) {
        cell =[[UserCenterMidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:user_header_id];
    }
    [cell setData:_dictionary];
    [cell setDelegate:self];
    return cell;
}

- (void) fetchData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if([GlobalData sharedInstance].user.isLogin)
    {
        [params setObject:[GlobalData sharedInstance].user.userInfo.ids forKey:@"driverId"];
    }
    
    [HttpShareEngine callWithFormParams:params withMethod:@"dAccount" succ:^(NSDictionary *resultDictionary) {
        _dictionary = resultDictionary[@"data"];
        _accountId =_dictionary[@"accountId"];
        NSLog(@"resultDictionary:%@",resultDictionary);
        [self endRefreshData];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        NSLog(@"errorMessage:%@",errorMessage);
        [self endRefreshData];
    }];
    
}

- (void) endRefreshData
{
    [_mTableView.mj_header endRefreshing];
    [_mTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TargetActionDelegate

- (void) buttonSelectedIndex:(NSInteger)index
{
    OrderListController *orderlist = [[OrderListController alloc] init];
    orderlist.tripType = index;
    orderlist.accountId = _accountId;
    [self.navigationController pushViewController:orderlist animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
