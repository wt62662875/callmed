//
//  BalanceController.m
//  callmed
//
//  Created by sam on 16/8/4.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BalanceController.h"
#import "BalanceTopCell.h"
#import "BalanceExtraCell.h"
#import "CMSearchManager.h"
@interface FeeTypeModel :NSObject
@property (nonatomic,copy) NSString *fee;
@property (nonatomic,copy) NSString *feeType;
@end

@interface BalanceController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIButton *buttonSubmit;
@property (nonatomic,strong) NSDictionary *data;
@property (nonatomic,strong) NSMutableDictionary *dataValue;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) CMLocation *locations;
@property (nonatomic,assign) NSInteger distance;
@property (nonatomic,assign) NSInteger times;
@end

@implementation BalanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void) initData
{
    _dataArray = [NSArray arrayWithObjects:@"",@"", nil];
    _dataValue = [NSMutableDictionary dictionary];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[GlobalData sharedInstance].coordinate.latitude longitude:[GlobalData sharedInstance].coordinate.longitude];
    
    [[CMSearchManager sharedInstance] searchLocation:location completionBlock:^(id request, CMLocation *location, NSError *error) {
        NSLog(@"CMSearchManager location%@",location);
        _locations = location;
    }];
    
    OrderDistance *orderDistance =[[GlobalData sharedInstance].dictDistance objectForKey:_model.ids];
    NSMutableArray *array = [orderDistance pickPoints];
    
    CLLocation *slocation= orderDistance.location;
    if (!slocation) {
        CLLocation *start =[[CLLocation alloc] initWithLatitude:[_model.slatitude floatValue] longitude:[_model.slongitude floatValue]];
        slocation =start;
    }
    [[CMSearchManager sharedInstance] searchRouteLine:slocation end:location points:array completionBlock:^(id request, id response, NSError *error) {
        AMapRouteSearchResponse *naviResponse = response;
        
        if (naviResponse.route == nil)
        {
            NSLog(@"获取路径失败");
            return;
        }
        
        AMapPath * path = [naviResponse.route.paths firstObject];
        _distance = path.distance;
        _times = path.duration/60.f;
        NSLog(@"AMapPath%@",[NSString stringWithFormat:@"预估费用%.2f元  距离%.1f km  时间%.1f分钟", naviResponse.route.taxiCost, path.distance / 1000.f, path.duration / 60.f, nil]);
        
        [self fetchOrderFee];
    }];
}

- (void) initView
{
    [self setTitle:@"行程账单"];
//    [self.leftButton setHidden:YES];
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [_mTableView setBackgroundColor:RGBHex(g_gray_cc)];
    [self.view addSubview:_mTableView];
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [_mTableView reloadData];
    
    _buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_buttonSubmit.layer setBorderColor:RGBHex(g_red).CGColor];
    [_buttonSubmit setTitle:@"确定车费" forState:UIControlStateNormal];
    
    [_buttonSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];            //RGBHex(g_green)
    [_buttonSubmit setTitleColor:RGBHex(g_green) forState:UIControlStateSelected];     //RGBHex(g_green)
    [_buttonSubmit setTitleColor:RGBHex(g_green) forState:UIControlStateHighlighted];  //RGBHex(g_green)
    
    [_buttonSubmit setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_red)] forState:UIControlStateNormal];
//    [_buttonSubmit setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
//    [_buttonSubmit setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [_buttonSubmit addTarget:self action:@selector(buttonSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonSubmit.layer setCornerRadius:5];
    [_buttonSubmit.layer setMasksToBounds:YES];
//    [_buttonSubmit.layer setBorderWidth:1];
    [_buttonSubmit setTag:1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *topcellId =@"topcellId";
        BalanceTopCell *cell = [tableView dequeueReusableCellWithIdentifier:topcellId];
        if (!cell) {
            cell =[[BalanceTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topcellId];
        }
        [cell setData:_data];
        [cell setDistance:_distance];
        [cell setTimes:_times];
        [cell setOrderId:_model.ids];
        return cell;
    }else if (indexPath.section==1)
    {
        static NSString *cellId =@"cellId";
        BalanceExtraCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell =[[BalanceExtraCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.dataValue = _dataValue;
        return cell;
    }else if(indexPath.section==2)
    {
        static NSString *cellIdbutton =@"cellIdbutton";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdbutton];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdbutton];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:_buttonSubmit];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_buttonSubmit mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(20);
            make.right.equalTo(cell).offset(-20);

//            make.centerX.equalTo(cell);
            make.centerY.equalTo(cell);
            make.height.mas_equalTo(40);
//            make.width.mas_equalTo(200);
        }];
        return cell;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (_data) {
            NSArray *da = _data[@"details"];
            if (da&&da.count>0) {
                return 130+da.count*35;
            }
        }
        return 200;
    }else if (indexPath.section==2) {
        return 100;
    }
    
    return 200;
}

- (void) fetchOrderFee
{
    if (!_model) {
        NSLog(@"OrderInfo is null");
        return;
    }
    OrderDistance *orderDistance =[[GlobalData sharedInstance].dictDistance objectForKey:_model.ids];
    NSString *distance =nil;
    if (orderDistance) {
        
        if (orderDistance.distancef>(float)_distance) {
            distance = orderDistance.distance;
        }else{
            distance = [NSString stringWithFormat:@"%ld",(long)_distance];
        }
    }else{
        distance = [NSString stringWithFormat:@"%ld",(long)_distance];
    }
    [OrderModel caculateOrderInfo:_model.ids withType:_model.type distance:distance==nil?@"0":distance succes:^(NSDictionary *resultDictionary) {
        NSLog(@"%@",resultDictionary);
        _data = resultDictionary[@"data"];
        [_mTableView reloadData];
    } failed:^(NSInteger errorCode, NSString *errorMessage) {
        NSLog(@"errorMessage %@",errorMessage);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) buttonSwitch:(UIButton*)button
{
    NSLog(@"dataValue:%@",_dataValue);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (_model) {
        [params setObject:_model.ids forKey:@"id"];
    }
    OrderDistance *orderDistance =[[GlobalData sharedInstance].dictDistance objectForKey:_model.ids];
    NSString *distance;
    if (orderDistance) {
        
        if (orderDistance.distancef>(float)_distance) {
            distance = orderDistance.distance;
        }else{
            distance = [NSString stringWithFormat:@"%ld",(long)_distance];
        }
    }else{
        distance = [NSString stringWithFormat:@"%ld",(long)_distance];
    }
    
    CLLocation *start =[[CLLocation alloc] initWithLatitude:[_model.slatitude floatValue] longitude:[_model.slongitude floatValue]];
    CLLocation *end  =[[CLLocation alloc] initWithLatitude:[_model.elatitude floatValue]longitude:[_model.elongitude floatValue]];
    CLLocation *current  =[[CLLocation alloc] initWithLatitude:[GlobalData sharedInstance].coordinate.latitude longitude:[GlobalData sharedInstance].coordinate.longitude];
    
    CLLocationDistance total_distance = [start distanceFromLocation:end];
    CLLocationDistance current_distance = [start distanceFromLocation:current];
    
    NSLog(@"%f",[_model.slatitude floatValue]);
    NSLog(@"%f",[_model.slongitude floatValue]);
    
    NSLog(@"%f",[_model.elatitude floatValue]);
    NSLog(@"%f",[_model.elongitude floatValue]);

    NSLog(@"%f",[GlobalData sharedInstance].coordinate.latitude );
    NSLog(@"%f",[GlobalData sharedInstance].coordinate.longitude);

    NSLog(@"%f",total_distance);
    NSLog(@"%f",current_distance);

    
    
    if ((current.coordinate.latitude!=0.0f&&current.coordinate.longitude!=0)&&(current_distance/total_distance)<0.15f) {
        [MBProgressHUD showAndHideWithMessage:@"还未到乘客下车点附近!" forHUD:nil];
        return;
    }else if((current.coordinate.latitude==0.0f&&current.coordinate.longitude==0)){
        [MBProgressHUD showAndHideWithMessage:@"还未获得定位信息!无法结束行程." forHUD:nil];
        return;
    }
    [params setObject:distance?distance:@"0" forKey:@"distance"];
    [params setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.longitude] forKey:@"eLongitude"];
    [params setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.latitude] forKey:@"eLatitude"];
    [params setObject:_locations?_locations.name:@"" forKey:@"eLocation"];
    if (_dataValue){
        NSString *value1 = _dataValue[@"fee1"];
        NSString *value2 = _dataValue[@"fee2"];
        NSString *value3 = _dataValue[@"fee3"];
        NSMutableArray *fees = [NSMutableArray array];
        if (value1 && ![@"0" isEqualToString:value1]) {
            
            NSMutableDictionary *fee1 = [NSMutableDictionary dictionary];
            [fee1 setObject:@"4" forKey:@"type"];
            [fee1 setObject:value1?value1:@"0" forKey:@"fee"];
            [fees addObject:fee1];
        }
       
        if (value2 && ![@"0" isEqualToString:value2]) {
            NSMutableDictionary *fee2 = [NSMutableDictionary dictionary];
            [fee2 setObject:@"5" forKey:@"type"];
            [fee2 setObject:value2?value2:@"0" forKey:@"fee"];
            [fees addObject:fee2];
        }
        
        if (value3 && ![@"0" isEqualToString:value3]) {
            NSMutableDictionary *fee3 = [NSMutableDictionary dictionary];
            [fee3 setObject:@"6" forKey:@"type"];
            [fee3 setObject:value3?value3:@"0" forKey:@"fee"];
            [fees addObject:fee3];
        }
        if (fees.count>0) {
            [params setObject:[fees lk_JSONString] forKey:@"fees"];
        }
    }
    NSLog(@"params:%@",params);
    [OrderModel driverOverTrip:params succes:^(NSDictionary *resultDictionary) {
        NSLog(@"result:%@",resultDictionary);
        [[GlobalData sharedInstance].dictDistance removeObjectForKey:_model.ids];
        [MBProgressHUD showAndHideWithMessage:@"行程已经结束" forHUD:nil];
        if (self.delegateCallback &&[self.delegateCallback respondsToSelector:@selector(callback:)]) {
            [self.delegateCallback callback:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
        NSLog(@"errorMessage:%@",errorMessage);
    }];
}

@end