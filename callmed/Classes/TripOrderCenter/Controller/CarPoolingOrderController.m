//
//  CarPoolingOrderController.m
//  callmed
//
//  Created by sam on 16/7/28.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CarPoolingOrderController.h"
#import "BalanceController.h"

#import "CarPoolingOrderCell.h"
#import "OrderModel.h"
#import "MapNavController.h"
#import "UIAlertView+Blocks.h"

@interface CarPoolingOrderController ()<UITableViewDataSource,UITableViewDelegate,TargetActionDelegate,CallBackDelegate>

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger page;

@end

@implementation CarPoolingOrderController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void) viewDidAppear:(BOOL)animated
{
    
}

- (void) initView
{
    [self.headerView setHidden:YES];
    _page = 1;
    _mTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchData];
    }];
    [_mTableView.mj_header beginRefreshing];
    _mTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [self fetchMoreData];
    }];
    
    [_mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];//UITableViewCellSeparatorStyle
    [self.view addSubview:_mTableView];
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void) initData
{
    _dataArray =[NSMutableArray array];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"orderviewcell";
    CarPoolingOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[CarPoolingOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.backgroundColor = RGBHex(g_assit_gray_eee);
    if (indexPath.section==0) {
        //[cell setTopLineHidden:YES];
    }else if(indexPath.section==1)
    {
        //[cell setBottomLineHidden:YES];
    }
    OrderModel *model = _dataArray[indexPath.section];
    [cell setDelegate:self];
    [cell setModel:model];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) fetchData
{
    if (![GlobalData sharedInstance].user.isLogin) {
        [MBProgressHUD showAndHideWithMessage:@"您还没有登录或者登录已经失效！请重新登录." forHUD:nil];
        return;
    }
    [OrderModel fetchMyOrderListById:[GlobalData sharedInstance].user.userInfo.ids types:@"2" page:1 succes:^(NSArray *result, int pageCount, int recordCount) {
        NSLog(@"%@",result);
        
        if (result) {
            [_dataArray removeAllObjects];
            for (NSDictionary *dict in result) {
                OrderModel *model = [[OrderModel alloc] initWithDictionary:dict error:nil];
                if (model) {
                    [_dataArray addObject:model];
                }
            }
            [self.mTableView.mj_header endRefreshing];
            [self.mTableView reloadData];
        }
        
    } failed:^(NSInteger errorCode, NSString *errorMessage) {
        [self.mTableView.mj_header endRefreshing];
        NSLog(@"%@",errorMessage);
    }];
}

- (void) fetchMoreData
{
    if (![GlobalData sharedInstance].user.isLogin) {
        [MBProgressHUD showAndHideWithMessage:@"您还没有登录或者登录已经失效！请重新登录." forHUD:nil];
        return;
    }
    [OrderModel fetchMyOrderListById:[GlobalData sharedInstance].user.userInfo.ids types:@"2" page:_page succes:^(NSArray *result, int pageCount, int recordCount) {
        NSLog(@"%@",result);
        if (result) {
            for (NSDictionary *dict in result) {
                OrderModel *model = [[OrderModel alloc] initWithDictionary:dict error:nil];
                if (model) {
                    [_dataArray addObject:model];
                }
            }
            [self.mTableView reloadData];
        }
        [self.mTableView.mj_footer endRefreshing];
        
    } failed:^(NSInteger errorCode, NSString *errorMessage) {
        [self.mTableView.mj_footer endRefreshing];
        NSLog(@"%@",errorMessage);
    }];
}

- (void) reloadData
{
    [_mTableView.mj_header beginRefreshing];
}


- (void) buttonTarget:(id)sender
{
    if ([sender isKindOfClass:[OrderModel class]]) {
        OrderModel *model = (OrderModel*)sender;
        if ([@"3" isEqualToString:model.state]) {
            [OrderModel driverArrival:model.ids succes:^(NSDictionary *resultDictionary) {
                
                [_mTableView.mj_header beginRefreshing];
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
            }];
        }else if ([@"4" isEqualToString:model.state]) {
            [OrderModel driverStartTrip:model.ids succes:^(NSDictionary *resultDictionary) {
                
                OrderDistance *order = [[OrderDistance alloc] init];
                order.date = [NSDate date];
                order.ids = model.ids;
                [[GlobalData sharedInstance].dictDistance setObject:order forKey:model.ids];
                
//                NSMutableDictionary *param = [NSMutableDictionary dictionary];
//                [GlobalData sharedInstance].recordEnable = YES;
//                [param setObject:[NSDate date] forKey:@"nowtime"];
//                [param setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.latitude] forKey:@"latitude"];
//                [param setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.longitude] forKey:@"longitude"];
//                [SandBoxHelper saveStartLocation:param];
                
                [_mTableView.mj_header beginRefreshing];
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
            }];
        }else if ([@"5" isEqualToString:model.state]) {
            
            BalanceController *balance = [[BalanceController alloc] init];
            balance.model = model;
            balance.delegateCallback = self;
            [self.navigationController pushViewController:balance animated:YES];
            /*[OrderModel driverOverTrip:model.ids succes:^(NSDictionary *resultDictionary) {
                [_mTableView.mj_header beginRefreshing];
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
            }];*/
        }
    }
}

- (void) buttonTarget:(UIView*)view withObj:(NSObject*)obj
{
    if([view isKindOfClass:[UIButton class]])
    {
        NSInteger tag = ((UIButton*)view).tag;
        if (tag == 2) {
            MapNavController *nav_controller = [[MapNavController alloc] init];
            nav_controller.model = obj;
            [self.navigationController pushViewController:nav_controller animated:YES];
        }
    }
}
-(void)valueChanged:(id)sender{
    OrderModel *model = (OrderModel*)sender;
    [UIAlertView showWithTitle:@"温馨提示" message:@"是否取消订单" style:UIAlertViewStyleDefault cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
        if (buttonIndex) {
            NSLog(@"%@",model);
            NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:model.ids,@"id",model.driverId,@"driverId",@"司机取消",@"cancelReason", nil];
            [HttpShareEngine callWithFormParams:params withMethod:@"cancelOrder" succ:^(NSDictionary *resultDictionary) {
                NSLog(@"resultDictionary:%@",resultDictionary);
                [_mTableView.mj_header beginRefreshing];

            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                NSLog(@"errorMessage:%@",errorMessage);
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];

            }];
        }
    }];
}

- (void) callback:(id)sender
{
    [self reloadData];
}

@end
