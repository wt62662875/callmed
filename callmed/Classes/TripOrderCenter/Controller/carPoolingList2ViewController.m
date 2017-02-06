//
//  carPoolingList2ViewController.m
//  callmed
//
//  Created by wt on 2017/1/24.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "carPoolingList2ViewController.h"
#import "CarPoolingCell.h"
#import "OrderModel.h"
#import "CarpoolingView.h"
#import "RouteMapController.h"
#import "HttpShareEngine.h"
//#import "chooseCompanyViewController.h"

@interface carPoolingList2ViewController ()<UITableViewDataSource,UITableViewDelegate,TargetActionDelegate>
{
    NSInteger selectTag;

}
@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) OrderModel *model;
@end

@implementation carPoolingList2ViewController
{
    CarPoolingView *poolView;
    NSString *_firstType;

}
- (void)viewDidLoad {
    [super viewDidLoad];
//    chooseCompanyViewController *chooseCompanyVC = [[chooseCompanyViewController alloc]initWithNibName:@"chooseCompanyViewController" bundle:nil];
//    [self.navigationController pushViewController:chooseCompanyVC animated:YES];
    
    _firstType = @"1";
    [self setTitle:_lineName];
    [self initData];
    [self initView];
    // Do any additional setup after loading the view.
}
- (void) initView
{
    _mTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [_mTableView setBackgroundColor:RGBHex(g_assit_gray)];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchData];
    }];
    [_mTableView.mj_header beginRefreshing];
    
    [_mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];//UITableViewCellSeparatorStyle
    [self.view addSubview:_mTableView];
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomHeaderLine.mas_bottom);
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
    cell.moreOrder.hidden = YES;
    OrderModel *model = _dataArray[indexPath.section];
    NSLog(@"%@",model);
    [cell setModel:model];
    
    cell.getOrder.tag = indexPath.section;
    [cell.getOrder addTarget:self action:@selector(getOrder:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
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
    return 160;
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
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:[GlobalData sharedInstance].user.userInfo.ids forKey:@"driverId"];
    [param setObject:@"2" forKey:@"type"];
    [param setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.longitude] forKey:@"longitude"];
    [param setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.latitude] forKey:@"latitude"];
    [param setObject:@"1" forKey:@"state"];
    
    if (_firstType) {
        [param setObject:_firstType forKey:@"latest"];
    }
    [param setObject:@"-1" forKey:@"carType"];
    [param setObject:_lineID forKey:@"lineId"];

    [HttpShareEngine callWithFormParams:param withMethod:@"listOrder" succList:^(NSArray *result, int pageCount, int recordCount) {
        NSLog(@"%@",result);
        
        if (result) {
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
        
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
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
    [self fetchData];
    //[_mTableView.mj_header beginRefreshing];
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
        }
    }
}

- (void) buttonSelectedIndex:(NSInteger)index
{
    _firstType = [NSString stringWithFormat:@"%ld",index+1];
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
