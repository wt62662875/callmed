//
//  GoodsCarListController.m
//  callmed
//
//  Created by sam on 16/8/15.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "GoodsCarListController.h"
#import "RouteMapController.h"

#import "OrderViewCell.h"

#import "OrderModel.h"

#import "GoodsCarListCell.h"
#import "OrderModel.h"
#import "GoodsCarPopView.h"

@interface GoodsCarListController()<UITableViewDataSource,UITableViewDelegate,TargetActionDelegate>

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) OrderModel *model;
@property (nonatomic,strong) dispatch_source_t timer;
@property (nonatomic,assign) BOOL isCanceled;
@property (nonatomic,assign) BOOL isShowTips;
@end

@implementation GoodsCarListController
{
    GoodsCarPopView *poolView;
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void) viewDidAppear:(BOOL)animated
{
    _isShowTips = NO;
    [self initTimer];
    [super viewDidDisappear:animated];
    
    NSLog(@"GoodsCarListController viewDidAppear");
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self cancelTimer];
    [super viewDidDisappear:animated];
    NSLog(@" GoodsCarListController viewDidDisappear");
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
    //[_mTableView.mj_header beginRefreshing];
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
    _isShowTips = NO;
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
    GoodsCarListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[GoodsCarListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    //    if (indexPath.section==0) {
    //        [cell setTopLineHidden:YES];
    //    }else if(indexPath.section==1)
    //    {
    //        [cell setBottomLineHidden:YES];
    //    }
    OrderModel *model = _dataArray[indexPath.section];
    [cell setModel:model];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _model = _dataArray[indexPath.section];
    poolView =[[GoodsCarPopView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [poolView setModel:_model];
    [poolView setDelegate:self];
    UIWindow *windows = AppDelegateInstance().window;
    [windows addSubview:poolView];
    
    [poolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(windows);
        make.left.equalTo(windows);
        make.right.equalTo(windows);
        make.bottom.equalTo(windows);
    }];
}

- (void) fetchData
{
    if (![GlobalData sharedInstance].user.isLogin) {
        [MBProgressHUD showAndHideWithMessage:@"您还没有登录或者登录已经失效！请重新登录." forHUD:nil];
        return;
    }
    if (![@"3" isEqualToString:[GlobalData sharedInstance].user.userInfo.type]) {
        if (_isShowTips) {
            [MBProgressHUD showAndHideWithMessage:@"当前出车类型不是货的." forHUD:nil];
        }
        [_dataArray removeAllObjects];
        [self.mTableView.mj_header endRefreshing];
        [self.mTableView reloadData];
        [self cancelTimer];
        return;
    }
    [OrderModel fetchOrderListById:[GlobalData sharedInstance].user.userInfo.ids types:@"3" page:1 succes:^(NSArray *result, int pageCount, int recordCount) {
       // NSLog(@"%@",result);
        
        if (result) {
            [_dataArray removeAllObjects];
            for (NSDictionary *dict in result) {
                OrderModel *model = [[OrderModel alloc] initWithDictionary:dict error:nil];
                if (model) {
                    [_dataArray addObject:model];
                }
            }
        }
        [self.mTableView.mj_header endRefreshing];
        [self.mTableView reloadData];
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
    
    if (![@"3" isEqualToString:[GlobalData sharedInstance].user.userInfo.type]) {
        
        [MBProgressHUD showAndHideWithMessage:@"当前出车类型不是货的." forHUD:nil];
        [self cancelTimer];
        [_dataArray removeAllObjects];
        [self.mTableView reloadData];
        [self.mTableView.mj_footer endRefreshing];
        return;
    }
    [OrderModel fetchOrderListById:[GlobalData sharedInstance].user.userInfo.ids types:@"3" page:_page succes:^(NSArray *result, int pageCount, int recordCount) {
        //NSLog(@"%@",result);
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

- (void) endRefreshData:(BOOL)reload
{
    [self.mTableView.mj_header endRefreshing];
    [self.mTableView.mj_footer endRefreshing];
    if (reload) {
        [self.mTableView reloadData];
    }
}


- (void) buttonTarget:(id)sender
{
    if (sender == self.leftButton) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender == self.rightButton) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if([sender isKindOfClass:[UIButton class]]){
        NSInteger tag = ((UIButton*)sender).tag;
        if (tag==0) {
            [CommonUtility callTelphone:_model.mPhoneNo];
            [poolView removeFromSuperview];
        }else if (tag==1) {
            [OrderModel driverAcceptOrder:_model.ids driverId:[GlobalData sharedInstance].user.userInfo.ids succes:^(NSDictionary *resultDictionary) {
                [MBProgressHUD showAndHideWithMessage:@"接单成功" forHUD:nil];
                // [SandBoxHelper saveConfig:(NSDictionary *)];
                
                [self reloadData];
                [poolView removeFromSuperview];
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
                [poolView removeFromSuperview];
            }];
        }else if (tag==2) {
            [poolView removeFromSuperview];
        }else if (tag==3) {
            [poolView removeFromSuperview];
            RouteMapController *route = [[RouteMapController alloc] init];
            CMLocation *start = [[CMLocation alloc] init];
            start.name = _model.slocation;
            start.coordinate = CLLocationCoordinate2DMake([_model.slatitude floatValue], [_model.slongitude floatValue]);
            CMLocation *end = [[CMLocation alloc] init];
            end.name = _model.elocation;
            end.coordinate = CLLocationCoordinate2DMake([_model.elatitude floatValue], [_model.elongitude floatValue]);
            
            route.startLocation = start;
            route.endLocation = end;
            [self.navigationController pushViewController:route animated:YES];
        }
    }
}

#pragma mark - CallBackDelegate

- (void) callback:(id)sender
{
    [self reloadData];
}
- (void) reloadData
{
    _isShowTips = YES;
    [self initTimer];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_NEED_REDBALL object:nil];
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
                              5.0*NSEC_PER_SEC,
                              0.0);
    
    dispatch_source_set_event_handler(_timer, ^{
        if (!_isCanceled) {
            if ([NSThread isMainThread]) {
                NSLog(@"isMainThread");
            }else{
                NSLog(@"Not isMainThread");
            }
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
