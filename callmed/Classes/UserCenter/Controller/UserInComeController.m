//
//  UserCenterController.m
//  callmed
//
//  Created by sam on 16/7/19.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "UserInComeController.h"
#import "OrderListController.h"
#import "allOrderViewController.h"


#import "UserCenterHeaderCell.h"
#import "UserCenterMidCell.h"
#import "recommendPassengersViewController.h"

@interface UserInComeController ()<UITableViewDelegate,UITableViewDataSource,TargetActionDelegate>

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSDictionary *dictionary;
@property (nonatomic,copy) NSString *accountId;
@end

@implementation UserInComeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.mTableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) initView
{
    [self setTitle:@"我的"];
    [self setHiddenHeader:YES];
    
    _mTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [_mTableView setBackgroundColor:RGBHex(g_gray)];
    [self.view addSubview:_mTableView];
    _mTableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchData];
    }];
    [_mTableView.mj_header beginRefreshing];
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *user_header_id = @"user_header_id";
        UserCenterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:user_header_id];
        if (!cell) {
            cell =[[UserCenterHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:user_header_id];
        }
        [cell setData:_dictionary];
        return cell;
    }else if(indexPath.section == 1)
    {
        static NSString *user_header_id = @"user_header_id_middle";
        UserCenterMidCell *cell = [tableView dequeueReusableCellWithIdentifier:user_header_id];
        if (!cell) {
            cell =[[UserCenterMidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:user_header_id];
        }
        [cell setData:_dictionary];
        [cell setDelegate:self];
        return cell;
    }else if(indexPath.section == 2)
    {
        static NSString *user_header_id = @"user_header_id_line";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:user_header_id];
        if (!cell) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:user_header_id];
            
            UIButton *toPassengers = [UIButton buttonWithType:UIButtonTypeCustom];
            [toPassengers setTitle:@"查看推荐的乘客" forState:UIControlStateNormal];
            toPassengers.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [toPassengers.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [toPassengers setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [toPassengers addTarget:self action:@selector(toPassengersClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:toPassengers];
            [toPassengers mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell).offset(10);
                make.left.equalTo(cell).offset(10);
                make.right.equalTo(cell).offset(-10);
                make.height.mas_offset(30);
            }];
            
            UIImageView *jiantou = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"youshen"]];
            [cell addSubview:jiantou];
            [jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(toPassengers);
                make.rightMargin.equalTo(cell.mas_right).offset(-30);
            }];
            
            
            UIView *linewView = [[UIView alloc]init];
            [linewView setBackgroundColor:RGBHex(g_gray)];
            [cell addSubview:linewView];
            [linewView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(toPassengers.mas_bottom).offset(10);
                make.left.equalTo(cell);
                make.right.equalTo(cell);
                make.height.mas_offset(5);
            }];

            
            UILabel *contentV = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            contentV.tag = 1001;
            contentV.font = [UIFont systemFontOfSize:15];
            [contentV setText:[NSString stringWithFormat:@"客服电话   %@",[GlobalData sharedInstance].user.userInfo.serviceNo]];
            [contentV setTextColor:RGBHex(g_red)];
            [cell addSubview:contentV];
            [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(linewView.mas_bottom).offset(13);
                make.left.equalTo(cell).offset(10);
            }];
//            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone"]];
            UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dianhua1"]];
            [cell addSubview:image];
            [image mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(contentV);
                make.rightMargin.equalTo(cell.mas_right).offset(-30);
            }];
            
            UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [phoneButton addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:phoneButton];
            [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(linewView.mas_bottom);
                make.bottom.equalTo(cell);
                make.left.equalTo(contentV);
                make.right.equalTo(cell.mas_right);
            }];
            
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return 5;
    }
    
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 110;
    }else if (indexPath.section==1) {
        return 200;
    }else if (indexPath.section==2) {
        return 100;
    }
    return 40;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        allOrderViewController *allOrderVC = [[allOrderViewController alloc]initWithNibName:@"allOrderViewController" bundle:nil];
        [allOrderVC setAccountId:_accountId];
        [allOrderVC setBalance:[NSString stringWithFormat:@"%@",[_dictionary objectForKey:@"cmmoney"]]];
        [self.navigationController pushViewController:allOrderVC animated:YES];
    }
    if (indexPath.section==2) {
//        [CommonUtility callTelphone:[GlobalData sharedInstance].user.userInfo.serviceNo];
    }
}
-(void)phoneClick:(id)sender{
    [CommonUtility callTelphone:[GlobalData sharedInstance].user.userInfo.serviceNo];
}
-(void)toPassengersClick:(id)sender{
    recommendPassengersViewController *recommendPassengersVC = [[recommendPassengersViewController alloc]initWithNibName:@"recommendPassengersViewController" bundle:nil];
    [self.navigationController pushViewController:recommendPassengersVC animated:YES];

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
