//
//  GoodsCarOrderController.m
//  callmed
//
//  Created by sam on 16/8/15.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "GoodsCarOrderController.h"
#import "BalanceController.h"

#import "BottomDialogView.h"
#import "GoodsCarOrderCell.h"
#import "MapNavController.h"

#import "OrderModel.h"

@interface GoodsCarOrderController ()<UITableViewDataSource,UITableViewDelegate,TargetActionDelegate,CallBackDelegate>

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,strong) dispatch_source_t timer;
@property (nonatomic,assign) BOOL isCanceled;
@end

@implementation GoodsCarOrderController
- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self initTimer];
    [super viewDidDisappear:animated];
    
    NSLog(@"GoodsCarOrderController viewDidAppear");
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self cancelTimer];
    [super viewDidDisappear:animated];
    NSLog(@" GoodsCarOrderController viewDidDisappear");
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
    GoodsCarOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[GoodsCarOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
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
    return 300;
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
    [OrderModel fetchMyOrderListById:[GlobalData sharedInstance].user.userInfo.ids types:@"3" page:1 succes:^(NSArray *result, int pageCount, int recordCount) {
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
        NSLog(@"errorMessage:%@",errorMessage);
    }];
}

- (void) fetchMoreData
{
    if (![GlobalData sharedInstance].user.isLogin) {
        [MBProgressHUD showAndHideWithMessage:@"您还没有登录或者登录已经失效！请重新登录." forHUD:nil];
        return;
    }
    [OrderModel fetchMyOrderListById:[GlobalData sharedInstance].user.userInfo.ids types:@"3" page:_page succes:^(NSArray *result, int pageCount, int recordCount) {
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
        if ([@"3" isEqualToString:model.state]) {
            [OrderModel driverArrival:model.ids succes:^(NSDictionary *resultDictionary) {
                
                [_mTableView.mj_header beginRefreshing];
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
            }];
        }else if ([@"4" isEqualToString:model.state]) {
            _orderId = model.ids;
            BottomDialogView *dialog = [[BottomDialogView alloc] init];
            [dialog setColumnNumber:6];
            [dialog setTitle:@"使用货位设置"];
            [dialog setDesc:@"单击下面数字选择使用货位数量"];
            [dialog setDelegate:self];
            [self.view.window addSubview:dialog];
            [dialog mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.window);
                make.left.equalTo(self.view.window);
                make.bottom.equalTo(self.view.window);
                make.right.equalTo(self.view.window);
            }];
            
            for (int i=0;i<6;i++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                //[btn addTarget:self action:@selector(buttonTagetPeople:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [btn setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
                btn.tag = i;
                [dialog addContainerView:btn];
            }
            
            [dialog updateContainerHeight:150];
            
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

- (void) buttonTarget:(UIView *)view withObj:(NSObject *)obj
{
    if([view isKindOfClass:[UIButton class]])
    {
        NSInteger tag = ((UIButton*)view).tag;
        if (tag == 2) {
            MapNavController *nav_controller = [[MapNavController alloc] init];
            nav_controller.model = (OrderModel*)obj;
            [self.navigationController pushViewController:nav_controller animated:YES];
        }
    }

}

- (void) buttonSelected:(UIView *)view Index:(NSInteger)index
{
    
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton*)view;
        NSInteger index = btn.tag+1;
        
        if (!_orderId) {
            return;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_orderId forKey:@"id"];
        [params setObject:[NSString stringWithFormat:@"%ld",(long)index] forKey:@"goodsNum"];
        [OrderModel driverStartPackageTrip:params succes:^(NSDictionary *resultDictionary) {
            [self startTrip:_orderId];
         } failed:^(NSInteger errorCode, NSString *errorMessage) {
             [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
         }];
    }
}

- (void) startTrip:(NSString*)orderId
{
    [OrderModel driverStartTrip:orderId succes:^(NSDictionary *resultDictionary) {
        
        OrderDistance *order = [[OrderDistance alloc] init];
        order.date = [NSDate date];
        order.ids = orderId;
        [[GlobalData sharedInstance].dictDistance setObject:order forKey:orderId];
        
//        NSMutableDictionary *param = [NSMutableDictionary dictionary];
//        [GlobalData sharedInstance].recordEnable = YES;
//        [param setObject:[NSDate date] forKey:@"nowtime"];
//        [param setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.latitude] forKey:@"latitude"];
//        [param setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.longitude] forKey:@"longitude"];
//        [SandBoxHelper saveStartLocation:param];
        [_mTableView.mj_header beginRefreshing];
        
    } failed:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
    }];
}

#pragma mark - CallBackDelegate

- (void) callback:(id)sender
{
    [self reloadData];
}
- (void) reloadData
{
    [self initTimer];
    //[_mTableView.mj_header beginRefreshing];
}

- (void) removeViewFromParent
{
    [self cancelTimer];
    [self.view removeFromSuperview];
}

#pragma mark - timer interval

- (void) initTimer
{
    
    if (_timer) {
        [self cancelTimer];
    }
    _isCanceled = NO;
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,dispatch_get_main_queue());
    dispatch_source_set_timer(_timer,
                              DISPATCH_TIME_NOW,
                              20.0*NSEC_PER_SEC,
                              0.0);
    
    dispatch_source_set_event_handler(_timer, ^{
        if (!_isCanceled) {
            [self fetchData];
        }else{
            [self cancelTimer];
        }
    });
    dispatch_resume(_timer);
}
- (void) cancelTimer
{
    _isCanceled = YES;
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    NSLog(@"release inteval");
}

@end
