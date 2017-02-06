//
//  CarPoolingListController.m
//  callmed
//
//  Created by sam on 16/7/28.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CarPoolingListController.h"
#import "RouteMapController.h"

#import "CarPoolingCell.h"
#import "OrderModel.h"
#import "CarpoolingView.h"
#import "SwitchButton.h"
#import <AVFoundation/AVFoundation.h>
#import "carPoolingList2ViewController.h"

@interface CarPoolingListController () <UITableViewDataSource,UITableViewDelegate,TargetActionDelegate>
{
    NSInteger selectTag;
    dispatch_source_t _timer;
}
@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) OrderModel *model;
@property (nonatomic,strong) SwitchButton *top_container;
@property(nonatomic,strong) AVAudioPlayer *movePlayer ;

@end

@implementation CarPoolingListController
{
    CarPoolingView *poolView;
    NSString *_firstType;
    
    NSString *lastTime;
}
- (void) viewDidLoad
{
    [super viewDidLoad];
    _firstType = @"1";
    [self initData];
    [self initView];
}

- (void) viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear%s",__func__);
}

- (void) viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
}
- (void) initView
{
    [self.headerView setHidden:YES];
    _page = 1;
    
    _top_container = [[SwitchButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _top_container.delegate = self;
    [self.view addSubview:_top_container];
    [_top_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(320);
    }];
    
    _mTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [_mTableView setBackgroundColor:RGBHex(g_assit_gray)];
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
        make.top.equalTo(_top_container.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_mTableView reloadData];
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
    CarPoolingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[CarPoolingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
//    if (indexPath.section==0) {
//        [cell setTopLineHidden:YES];
//    }else if(indexPath.section==1)
//    {
//        [cell setBottomLineHidden:YES];
//    }
    cell.moreOrder.tag = indexPath.section;
    [cell.moreOrder addTarget:self action:@selector(moreOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    OrderModel *model = _dataArray[indexPath.section];
    NSLog(@"%@",model);
    [cell setModel:model];
    
    cell.getOrder.tag = indexPath.section;
    [cell.getOrder addTarget:self action:@selector(getOrder:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)moreOrderClick:(UIButton *)sender{
    OrderModel *model = _dataArray[sender.tag];
    carPoolingList2ViewController *carPoolingList2VC = [[carPoolingList2ViewController alloc]init];
    [carPoolingList2VC setLineID:model.lineId];
    [carPoolingList2VC setLineName:model.lineName];

    [self.navigationController pushViewController:carPoolingList2VC animated:YES];
    NSLog(@"%@",model);

}
-(void)getOrder:(UIButton *)sender{
    _model = _dataArray[sender.tag];

    [OrderModel driverAcceptOrder:_model.ids driverId:[GlobalData sharedInstance].user.userInfo.ids succes:^(NSDictionary *resultDictionary) {
        [MBProgressHUD showAndHideWithMessage:@"接单成功" forHUD:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTICE_NEED_CHANGE_MYORDER" object:nil];
        [self reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_NEED_REDBALL object:nil];
        
    } failed:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
    }];
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
    poolView =[[CarPoolingView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    selectTag = indexPath.section;

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

#pragma mark 倒计时
-(void)startTime{
    __block int timeout=14; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
   _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置 特别注明：UI的改变一定要在主线程中进行
                [self fetchData];
                if ([@"2" isEqualToString:[GlobalData sharedInstance].user.userInfo.type] && ![[GlobalData sharedInstance].user.userInfo.ready isEqualToString:@"0"]) {
                    [self startTime];
                }
            });
        }else{
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
-(void)viewWillAppear:(BOOL)animated{
    if ([@"2" isEqualToString:[GlobalData sharedInstance].user.userInfo.type] && ![[GlobalData sharedInstance].user.userInfo.ready isEqualToString:@"0"]) {
        [self startTime];
    }
}


- (void) fetchData
{

    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_NEED_REDBALL object:nil];
    if (![GlobalData sharedInstance].user.isLogin) {
        [self endRefreshData:YES];
        [MBProgressHUD showAndHideWithMessage:@"您还没有登录或者登录已经失效！请重新登录." forHUD:nil];
        return;
    }
    
    if (![@"2" isEqualToString:[GlobalData sharedInstance].user.userInfo.type]) {
        [MBProgressHUD showAndHideWithMessage:@"当前出车类型不是快车." forHUD:nil];
        [self endRefreshData:YES];
        [_dataArray removeAllObjects];
        [self.mTableView reloadData];
        return;
    }
    if ([[GlobalData sharedInstance].user.userInfo.ready isEqualToString:@"0"]) {
        [MBProgressHUD showAndHideWithMessage:@"请出车后再选择订单." forHUD:nil];
        [self endRefreshData:YES];
        [_dataArray removeAllObjects];
        [self.mTableView reloadData];
        return;
    }
    
    
    [OrderModel fetchOrderListByUserId:[GlobalData sharedInstance].user.userInfo.ids fristId:_firstType types:@"2" page:1 succes:^(NSArray *result,int pageCount,int recordCount) {
        NSLog(@"%@",result);
        
        if (result) {
            if (!lastTime && result.count > 0) {
                lastTime = [result[0] objectForKey:@"createDateMills"];
                NSString *tmp= [[NSBundle mainBundle] pathForResource:@"newOrder" ofType:@"mp3"];
                NSLog(@"%@",tmp);
                NSURL *moveMP3=[NSURL fileURLWithPath:tmp];
                NSError *err=nil;
                self.movePlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:moveMP3 error:&err];
                self.movePlayer.volume=1.0;
                [self.movePlayer prepareToPlay];
                if (err!=nil) {
                    NSLog(@"move player init error:%@",err);
                }else {
                    [self.movePlayer play];
                }
            }else if(lastTime && result.count > 0 && [[result[0] objectForKey:@"createDateMills"]intValue] > [lastTime intValue]){
                lastTime = [result[0] objectForKey:@"createDateMills"];
                NSString *tmp= [[NSBundle mainBundle] pathForResource:@"newOrder" ofType:@"mp3"];
                NSLog(@"%@",tmp);
                NSURL *moveMP3=[NSURL fileURLWithPath:tmp];
                NSError *err=nil;
                self.movePlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:moveMP3 error:&err];
                self.movePlayer.volume=1.0;
                [self.movePlayer prepareToPlay];
                if (err!=nil) {
                    NSLog(@"move player init error:%@",err);
                }else {
                    [self.movePlayer play];
                }
            }
            
            [_dataArray removeAllObjects];
            for (NSDictionary *dict in result) {
                OrderModel *model = [[OrderModel alloc] initWithDictionary:dict error:nil];
                if (model) {
                    [_dataArray addObject:model];
                }
            }
            [self endRefreshData:YES];
            [self.mTableView reloadData];
        }
        [self endRefreshData:YES];
        
    } failed:^(NSInteger errorCode, NSString *errorMessage) {
        [self endRefreshData:NO];
        NSLog(@"errorMessage:%@",errorMessage);
    }];
}

- (void) fetchMoreData
{
    if (![GlobalData sharedInstance].user.isLogin) {
        [MBProgressHUD showAndHideWithMessage:@"您还没有登录或者登录已经失效！请重新登录." forHUD:nil];
        [self endRefreshData:YES];
        return;
    }
    if (![@"2" isEqualToString:[GlobalData sharedInstance].user.userInfo.type]) {
        [self endRefreshData:YES];
        [MBProgressHUD showAndHideWithMessage:@"当前出车类型不是快车." forHUD:nil];
        [_dataArray removeAllObjects];
        [self.mTableView reloadData];
        return;
    }
    [OrderModel fetchOrderListByUserId:[GlobalData sharedInstance].user.userInfo.ids fristId:_firstType types:@"2" page:_page succes:^(NSArray *result, int pageCount, int recordCount) {
        NSLog(@"%@",result);
        if (result) {
            for (NSDictionary *dict in result) {
                OrderModel *model = [[OrderModel alloc] initWithDictionary:dict error:nil];
                if (model) {
                    [_dataArray addObject:model];
                }
            }
        }
        [self endRefreshData:YES];
    } failed:^(NSInteger errorCode, NSString *errorMessage) {
        [self endRefreshData:NO];
        NSLog(@"errorMessage:%@",errorMessage);
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

- (void) reloadData
{
//    [self fetchData];】
    [_mTableView.mj_header beginRefreshing];
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
            [poolView removeFromSuperview];
            [OrderModel driverAcceptOrder:_model.ids driverId:[GlobalData sharedInstance].user.userInfo.ids succes:^(NSDictionary *resultDictionary) {
                [MBProgressHUD showAndHideWithMessage:@"接单成功" forHUD:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTICE_NEED_CHANGE_MYORDER" object:nil];
                [self reloadData];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_NEED_REDBALL object:nil];
                
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
            }];
        }else if (tag==2) {
            [_dataArray removeObjectAtIndex:selectTag];
            [_mTableView reloadData];
            [poolView removeFromSuperview];
        }else if(tag==3)
        {
            [poolView removeFromSuperview];
            RouteMapController *route = [[RouteMapController alloc] init];
            CMLocation *start = [[CMLocation alloc] init];
            
            start.name = _model.slocation;
            start.coordinate = CLLocationCoordinate2DMake([_model.lineSlat floatValue], [_model.lineSlong floatValue]);
            
            CMLocation *end = [[CMLocation alloc] init];
            end.name = _model.elocation;
            end.coordinate = CLLocationCoordinate2DMake([_model.lineElat floatValue], [_model.lineElong floatValue]);
            route.startLocation = start;
            route.endLocation = end;
            [self.navigationController pushViewController:route animated:YES];
        }else if(tag == 41){
            [CommonUtility callMessage:_model.mPhoneNo];
            [poolView removeFromSuperview];
        }else if(tag==6)
        {
            [poolView removeFromSuperview];
        }
    }
}

- (void) buttonSelectedIndex:(NSInteger)index
{
    _firstType = [NSString stringWithFormat:@"%ld",index+1];
    [self fetchData];
}
@end
