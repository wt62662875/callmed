//
//  TripThreeController.m
//  callmec
//
//  Created by sam on 16/7/7.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "TripThreeController.h"

#import "BalanceController.h"
#import "MapNavController.h"

#import "OrderModel.h"
#import "CarBusCell.h"
#import "CarSpecialCell.h"


@interface TripThreeController()<UITableViewDataSource,UITableViewDelegate,TargetActionDelegate,CallBackDelegate>

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger page;
@end

@implementation TripThreeController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void) initView
{
    _page = 1;
    _mTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self fetchData];
    }];
    
    _mTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [self fetchMoreData];
    }];
    
    [_mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];//UITableViewCellSeparatorStyle
    [self.view addSubview:_mTableView];
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_mTableView reloadData];
}

- (void) initData
{
    _dataArray =[NSMutableArray array];
    [self fetchData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
//    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderModel *model = _dataArray[indexPath.section];
    if ([@"12" isEqualToString:model.type]) {
        static NSString *cellid = @"orderviewcell";
        CarBusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[CarBusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        if (indexPath.section==0) {
            //[cell setTopLineHidden:YES];
        }else if(indexPath.section==1)
        {
            //[cell setBottomLineHidden:YES];
        }
        [cell setDelegate:self];
        [cell setModel:model];
        return cell;
    }else{
        static NSString *cellid_cell = @"orderviewcell_cell";
        CarSpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid_cell];
        if (!cell) {
            cell = [[CarSpecialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid_cell];
        }
        if (indexPath.section==0) {
            //[cell setTopLineHidden:YES];
        }else if(indexPath.section==1)
        {
            //[cell setBottomLineHidden:YES];
        }
        [cell setDelegate:self];
        [cell setModel:model];
        return cell;
    
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel *model = _dataArray[indexPath.section];
    if ([@"12" isEqualToString:model.type]) {
        return 300;
    }else{
        return 210;
    }
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
//    if (![@"4" isEqualToString:[GlobalData sharedInstance].user.userInfo.type]) {
//        [MBProgressHUD showAndHideWithMessage:@"当前出车类型不是快巴." forHUD:nil];
//        [_dataArray removeAllObjects];
//        [self.mTableView reloadData];
//        return;
//    }
    
    [OrderModel fetchMyOrderListById:[GlobalData sharedInstance].user.userInfo.ids types:@"4" page:1 succes:^(NSArray *result, int pageCount, int recordCount) {
        NSLog(@"%@",result);
        if (result) {
            [_dataArray removeAllObjects];
            
            [[GlobalData sharedInstance].fastBusDict enumerateKeysAndObjectsUsingBlock:^(id  key, id  obj, BOOL *stop) {
                [_dataArray addObject:obj];
            }];
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
        [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
        NSLog(@"%@",errorMessage);
    }];
}

- (void) fetchMoreData
{
    if (![GlobalData sharedInstance].user.isLogin) {
        [MBProgressHUD showAndHideWithMessage:@"您还没有登录或者登录已经失效！请重新登录." forHUD:nil];
        return;
    }
    if (![@"4" isEqualToString:[GlobalData sharedInstance].user.userInfo.carType]) {
        [MBProgressHUD showAndHideWithMessage:@"当前出车类型不是快巴." forHUD:nil];
        [_dataArray removeAllObjects];
        [self.mTableView reloadData];
        return;
    }
    [OrderModel fetchMyOrderListById:[GlobalData sharedInstance].user.userInfo.ids types:@"4" page:_page succes:^(NSArray *result, int pageCount, int recordCount) {
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
        [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
        NSLog(@"%@",errorMessage);
    }];
}

#pragma mark - TargetActionDelegate
- (void) buttonTarget:(id)sender
{
    if ([sender isKindOfClass:[OrderModel class]]) {
        OrderModel *model = (OrderModel*)sender;
        if ([STATE_ORDER_EXECUTE_PENDING isEqualToString:model.state]) {
            [OrderModel driverArrival:model.ids succes:^(NSDictionary *resultDictionary) {
                ((OrderModel*)[_dataArray firstObject]).state=@"4";
                [_mTableView reloadData];
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
            }];
        }else if ([STATE_ORDER_EXECUTE isEqualToString:model.state]) {
            [OrderModel driverStartTrip:model.ids succes:^(NSDictionary *resultDictionary) {
                
                OrderDistance *order = [[OrderDistance alloc] init];
                order.date = [NSDate date];
                order.ids = model.ids;
                [[GlobalData sharedInstance].dictDistance setObject:order forKey:model.ids];
                ((OrderModel*)[_dataArray firstObject]).state=@"5";
                [_mTableView reloadData];
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
            }];
        }else if ([STATE_ORDER_PAY_PENDING isEqualToString:model.state]) {
            BalanceController *balance = [[BalanceController alloc] init];
            balance.model = model;
            balance.delegateCallback = self;
            [self.navigationController pushViewController:balance animated:YES];
        }
    }else if([sender isKindOfClass:[UIButton class]])
    {
        
    }
}

- (void) buttonTarget:(UIView *)view withObj:(NSObject *)obj
{
    NSInteger tag = view.tag;
    if (tag==1) {
        [[GlobalData sharedInstance].fastBusDict removeObjectForKey:((OrderModel*)obj).mPhoneNo];
        [_mTableView.mj_header beginRefreshing];
    }else if (tag==2) {
        MapNavController *nav_controller = [[MapNavController alloc] init];
        nav_controller.model = (OrderModel*)obj;
        [self.navigationController pushViewController:nav_controller animated:YES];
    }else if(tag==3)
    {
        [OrderModel dCancelPreByOrderId:((OrderModel*)obj).ids reason:@"司机原因取消！" succes:^(NSDictionary *resultDictionary) {
            [[GlobalData sharedInstance].fastBusDict removeObjectForKey:((OrderModel*)obj).mPhoneNo];
            [_mTableView.mj_header beginRefreshing];

        } failed:^(NSInteger errorCode, NSString *errorMessage) {
            
        }];
//        [OrderModel dDenyPreByOrderId:((OrderModel*)obj).ids driver:[GlobalData sharedInstance].user.userInfo.ids succes:^(NSDictionary *resultDictionary) {
//            [[GlobalData sharedInstance].fastBusDict removeObjectForKey:((OrderModel*)obj).mPhoneNo];
//            [_mTableView.mj_header beginRefreshing];
//        } failed:^(NSInteger errorCode, NSString *errorMessage) {
//            
//        }];
    }
    
}

#pragma mark -CallBackDelegate
- (void) callback:(id)sender
{
    [_mTableView.mj_header beginRefreshing];
}

- (void) reloadData
{
    [self fetchData];
}
@end
