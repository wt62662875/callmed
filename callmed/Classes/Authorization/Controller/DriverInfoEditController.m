//
//  DriverInfoEditController.m
//  callmed
//
//  Created by sam on 16/8/8.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "DriverInfoEditController.h"
#import "DriverRegisterController.h"

#import "EditHeaderCell.h"
#import "EditContentCell.h"
#import "EditPhotoCell.h"
#import "EditCommiteCell.h"
#import "SexyCell.h"
#import "ASBirthSelectSheet.h"
#import "DriverTypeView.h"

#import "CataItemModel.h"
#import "AuthItemModel.h"

#import "CMSearchManager.h"
#import "chooseCompanyViewController.h"


@interface DriverInfoEditController ()<UITableViewDataSource,UITableViewDelegate,TargetActionDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,getCompanyDelegate,AMapLocationManagerDelegate>
{
    NSDictionary *companyDatas;
}
@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIImage *headerImage;
@property (nonatomic,strong) NSString *iconData;
@property (nonatomic,strong) CMLocation *location;
@property (nonatomic,strong) BaseCellModel *select_model;
@property (nonatomic,strong) AMapLocationManager *locationManager;

@end

@implementation DriverInfoEditController
{
    UserInfoModel *user_model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocateAction];

}
-(void)startLocateAction{
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager setLocationTimeout:6];
    [_locationManager setReGeocodeTimeout:3];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];//kCLLocationAccuracyBest
    [self startLocation];

}
- (void) startLocation
{
    NSLog(@"startLocation");
    [_locationManager startUpdatingLocation];
}

- (void)stopLocation
{
    NSLog(@"stopLocation");
    [_locationManager stopUpdatingLocation];
}
- (void) amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    [self initData];
    [self initView];
    NSLog(@"amapLocationManager error:%@",error);
}

- (void) amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    if ([GlobalData sharedInstance].coordinate.latitude!=0) {
        [GlobalData sharedInstance].coordinate = location.coordinate;
    }else{
        [GlobalData sharedInstance].coordinate = location.coordinate;
    }
    [[CMSearchManager sharedInstance] searchLocation:location completionBlock:^(id request,
                                                                                CMLocation *clocation,
                                                                                NSError *error)
     {
         NSLog(@"clocation:%@",clocation.pcd);
//         [self getStartCity:clocation.city district:clocation.district];
         [GlobalData sharedInstance].user.userInfo.regCity = clocation.pcd;
         [[GlobalData sharedInstance].user save];

         [self initData];
         [self initView];
         
         [self stopLocation];
     }];
    
}


- (void) initData
{
    _dataArray = [NSMutableArray array];
    UserInfoModel *model = [GlobalData sharedInstance].user.userInfo;
    
    CMLocation *location = [GlobalData sharedInstance].location;
    [[CMSearchManager sharedInstance] searchLocation:[CMLocation covertFromCMLoaction:location] completionBlock:^(id request, CMLocation *locations, NSError *error) {
        
        _location = locations;
    }];
    if (_location) {
        _location = [GlobalData sharedInstance].location;
    }
    user_model = model;
    NSLog(@"%@",model);
    CataItemModel *model0 = [[CataItemModel alloc] initWithDictionary:@{@"title":@"用户信息",
                                                                        @"hasHeader":@(0),
                                                                        @"headerH":@(30),
                                                                        @"id":@(0),
                                                                        @"value":@"",
                                                                        @"hasMore":@(0),
                                                                        @"isEnable":@(1),
                                                                        @"dataArray":@[@{@"title":@"姓名",
                                                                                         @"value":[CommonUtility driverHeaderImageUrl:model.ids],
                                                                                         @"id":@(0),
                                                                                         @"isEnable":@(1),
                                                                                         @"type":@"0",
                                                                                         @"hasMore":@(0)}]} error:nil];
    CataItemModel *model1 = [[CataItemModel alloc] initWithDictionary:@{@"title":@"用户信息",
                                                                        @"hasHeader":@(1),
                                                                        @"headerH":@(30),
                                                                        @"id":@(1),
                                                                        @"value":@"",
                                                                        @"hasMore":@(1),
                                                                        @"isEnable":@(0),
                                                                        @"dataArray":@[@{@"title":@"姓名",
                                                                                         @"value":model.realName,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(0),
                                                                                         @"type":@"1",
                                                                                         @"id":@(1)},
                                                                                       @{@"title":@"性别",
                                                                                         @"value":model.gender?model.gender:@"0",
                                                                                         @"hasMore":@(1),
                                                                                         @"type":@"2",
                                                                                         @"isEnable":@(1),
                                                                                         @"id":@(2)},
                                                                                       @{@"title":@"城市",
                                                                                         @"value":model.regCity?model.regCity:[NSString stringWithFormat:@"%@ %@",
                                                                                                                                _location.city,_location.district],
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(1),
                                                                                         @"type":@"1",
                                                                                         @"id":@(3)},
                                                                                       /*@{@"title":@"驾驶证档案编号",
                                                                                         @"value":model.licenseNo,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(1),
                                                                                         @"type":@"1",
                                                                                         @"id":@(4)},*/
                                                                                       @{@"title":@"初次领驾照日期",
                                                                                         @"value":model.licenseDate,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(0),
                                                                                         @"type":@"1",
                                                                                         @"id":@(5)},
                                                                                       @{@"title":@"驾驶证类型",
                                                                                         @"value":model.licenseType,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(0),
                                                                                         @"type":@"1",
                                                                                         @"id":@(6)},
                                                                                       @{@"title":@"所属公司",
                                                                                         @"value":model.departmentName?model.departmentName:@"",
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(0),
                                                                                         @"type":@"1",
                                                                                         @"id":@(22)},
                                                                                       /*@{@"title":@"职业类型",
                                                                                         @"value":[@"1" isEqualToString:model.fullJob]?@"0":@"1",
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(0),
                                                                                         @"type":@"2",
                                                                                         @"id":@(7)},*/
                                                                                       @{@"title":@"身份证号码",
                                                                                         @"value":model.identifierNo,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(1),
                                                                                         @"type":@"1",
                                                                                         @"id":@(8)},
                                                                                       @{@"title":@"户籍所在地",
                                                                                         @"value":model.nativePlace,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(1),
                                                                                         @"type":@"1",
                                                                                         @"id":@(51)},
                                                                                       ]} error:nil];
//
//    @{@"title":@"备注",
//      @"value":model.descriptions?model.descriptions:@"",
//      @"hasMore":@(1),
//      @"isEnable":@(1),
//      @"type":@"1",
//      @"id":@(9)}
    
    NSString *carNo = [NSString stringWithFormat:@"%@",model.car[@"no"]?model.car[@"no"]:@""];
    NSString *carType = [NSString stringWithFormat:@"%@",model.car[@"description"]?model.car[@"description"]:@""];
    NSString *carOwer = [NSString stringWithFormat:@"%@",model.car[@"owner"]?model.car[@"owner"]:@""];
    NSString *carDate = [NSString stringWithFormat:@"%@",model.car[@"regDate"]?model.car[@"regDate"]:@""];
    NSString *carRegistCity = [NSString stringWithFormat:@"%@",model.car[@"regCity"]?model.car[@"regCity"]:@""];
    NSString *carColor = [NSString stringWithFormat:@"%@",model.car[@"color"]?model.car[@"color"]:@""];
    NSString *referees = [NSString stringWithFormat:@"%@",model.attribute1?model.attribute1:@""];

    CataItemModel *model2 = [[CataItemModel alloc] initWithDictionary:@{@"title":@"车辆信息",
                                                                        @"hasHeader":@(1),
                                                                        @"headerH":@(30),
                                                                        @"id":@(2),
                                                                        @"value":@"",
                                                                        @"hasMore":@(1),
                                                                        @"isEnable":@(0),
                                                                        @"dataArray":@[@{@"title":@"车牌号",
                                                                                         @"value":carNo,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(1),
                                                                                         @"type":@"1",
                                                                                         @"id":@(10)},
                                                                                       @{@"title":@"车型",
                                                                                         @"value":carType,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(1),
                                                                                         @"type":@"1",
                                                                                         @"id":@(11)},
                                                                                       @{@"title":@"车辆颜色",
                                                                                         @"value":carColor,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(1),
                                                                                         @"type":@"1",
                                                                                         @"id":@(21)}
                                                                        ,
                                                                                       @{@"title":@"车辆所有人",
                                                                                         @"value":carOwer,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(1),
                                                                                         @"type":@"1",
                                                                                         @"id":@(12)},
                                                                                       @{@"title":@"车辆落户日期",
                                                                                         @"value":carDate,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(0),
                                                                                         @"type":@"1",
                                                                                         @"id":@(13)},
                                                                                       @{@"title":@"车辆落户城市",
                                                                                         @"value":carRegistCity,
                                                                                         @"type":@"1",
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(1),
                                                                                         @"id":@(14)}]} error:nil];
    CataItemModel *model3 = [[CataItemModel alloc] initWithDictionary:@{@"title":@"照片信息",
                                                                        @"hasHeader":@(1),
                                                                        @"headerH":@(30),
                                                                        @"value":@"",
                                                                        @"id":@(3),
                                                                        @"hasMore":@(0),
                                                                        @"isEnable":@(0),
                                                                        @"dataArray":@[@{@"title":@"",
                                                                                         @"value":@"",
                                                                                         @"hasMore":@(1),
                                                                                         @"type":@"3",
                                                                                         @"isEnable":@(1),
                                                                                         @"id":@(15)}]} error:nil];
    CataItemModel *model4 = [[CataItemModel alloc] initWithDictionary:@{@"title":@"照片信息",
                                                                        @"hasHeader":@(0),
                                                                        @"headerH":@(30),
                                                                        @"value":@"",
                                                                        @"id":@(3),
                                                                        @"hasMore":@(0),
                                                                        @"isEnable":@(0),
                                                                        @"dataArray":@[@{@"title":@"",
                                                                                         @"value":@"",
                                                                                         @"hasMore":@(0),
                                                                                         @"type":@"4",
                                                                                         @"isEnable":@(1),
                                                                                         @"id":@(16)}]} error:nil];
    
    CataItemModel *model5 = [[CataItemModel alloc] initWithDictionary:@{@"title":@"推荐人",
                                                                        @"hasHeader":@(1),
                                                                        @"headerH":@(30),
                                                                        @"id":@(5),
                                                                        @"value":@"",
                                                                        @"hasMore":@(1),
                                                                        @"isEnable":@(0),
                                                                        @"dataArray":@[@{@"title":@"推荐人",
                                                                                         @"value":referees,
                                                                                         @"hasMore":@(1),
                                                                                         @"isEnable":@(1),
                                                                                         @"type":@"1",
                                                                                         @"id":@(30)}]} error:nil];
    
    [_dataArray addObject:model0];
    [_dataArray addObject:model1];
    [_dataArray addObject:model2];
    [_dataArray addObject:model5];
    [_dataArray addObject:model3];
    [_dataArray addObject:model4];
    
    if ([@"1" isEqualToString:model.passed])
    {
        [_dataArray removeObject:model4];
        [_dataArray removeObject:model5];
        [self setDataEnable:NO];
    }else{
        [_dataArray removeObject:model3];
        [self setDataEnable:YES];
    }
    
}

- (void) initView
{
    [self setTitle:@"个人资料"];
    [self.leftButton setImage:[UIImage imageNamed:@"icon_topback"] forState:UIControlStateNormal];//icon_topback top_back
    [self.leftButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.leftButton setContentMode:UIViewContentModeCenter];
    [self.leftButton addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setHidden:YES];
    [self.rightButton setTitleColor:RGBHex(g_m_c) forState:UIControlStateNormal];
    UIView *topHeaderView = [[UIView alloc] init];
    [topHeaderView setBackgroundColor:RGBHex(g_m_c)];
    [self.view addSubview:topHeaderView];
    [topHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    [tipLabel setTextColor:[UIColor whiteColor]];
    [tipLabel setText:@"请认真准确填写以下信息"];
    [tipLabel setFont:[UIFont systemFontOfSize:15]];
    [topHeaderView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topHeaderView);
        make.left.equalTo(topHeaderView).offset(10);
        make.right.equalTo(topHeaderView);
    }];
    
    _mTableView = [[UITableView alloc] init];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [self.view addSubview:_mTableView];
    [_mTableView reloadData];
    if (user_model && [@"0" isEqualToString:user_model.passed]){
        [topHeaderView setHidden:NO];
        [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topHeaderView.mas_bottom);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }else{
        [topHeaderView setHidden:YES];
        [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView.mas_bottom);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((CataItemModel*)_dataArray[section]).dataArray.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCellModel *model = ((CataItemModel*)_dataArray[indexPath.section]).dataArray[indexPath.row];
    if ([@"0" isEqualToString:model.type]) {
        static NSString *headercellid = @"headercellid";
        EditHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headercellid];
        if (!cell) {
            cell = [[EditHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headercellid];
        }
        
        AuthItemModel *mode = ((CataItemModel*)_dataArray[indexPath.section]).dataArray[indexPath.row];
        [cell setModel:mode];
        if (_headerImage) {
            cell.imageData =_headerImage;
        }
        [cell setDelegate:self];
        return cell;
    } else if([@"1" isEqualToString:model.type]){
        static NSString *contentid1 = @"contentid";
        EditContentCell *cell = [tableView dequeueReusableCellWithIdentifier:contentid1];
        if (!cell) {
            cell = [[EditContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentid1];
        }
        [cell setScaleTitle:0.35];
        [cell setContentHeight:0.6];
        [cell setModel:model];
        return cell;
    }else if([@"2" isEqualToString:model.type]){
        static NSString *contentid2 = @"contentid_sexy";
        SexyCell *cell = [tableView dequeueReusableCellWithIdentifier:contentid2];
        if (!cell) {
            cell = [[SexyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentid2];
        }
        [cell setModel:model];
        return cell;
        
    }else if([@"3" isEqualToString:model.type]){
        
        static NSString *contentid3 = @"content_photo_id";
        EditPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:contentid3];
        if (!cell) {
            cell = [[EditPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentid3];
        }
        [cell setModel:model];
        return cell;
        
    }else if ([@"4" isEqualToString:model.type])
    {
        static NSString *contentid4 = @"content_commit_id";
        EditCommiteCell *cell = [tableView dequeueReusableCellWithIdentifier:contentid4];
        if (!cell) {
            cell = [[EditCommiteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentid4];
        }
        [cell setDelegate:self];
        [cell setModel:model];
        return cell;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CataItemModel *model = _dataArray[section];
    if (model.hasHeader) {
        return 40;
    }
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CataItemModel *model = _dataArray[section];
    UIView *view =[[UIView alloc] init];
    [view setBackgroundColor:RGBHex(g_assit_gray_eee)];
    UILabel *title = [[UILabel alloc] init];
    [title setText:model.title];
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.right.equalTo(view);
        make.top.equalTo(view);
        make.bottom.equalTo(view);
    }];
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCellModel *model = ((CataItemModel*)_dataArray[indexPath.section]).dataArray[indexPath.row];
    if ([@"0" isEqualToString:model.type]) {
        return 100;
    }else if ([@"3" isEqualToString:model.type]) {
        return 250;
    }else if ([@"4" isEqualToString:model.type]) {
        return 100;
    }
    return 50;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _select_model = ((CataItemModel*)_dataArray[indexPath.section]).dataArray[indexPath.row];
    if ([@"6" isEqualToString:_select_model.ids]) {
        if (user_model && [@"0" isEqualToString:user_model.passed]) {
            [self showDriverType:_select_model];
        }
    }else if([@"5" isEqualToString:_select_model.ids]||[@"13" isEqualToString:_select_model.ids]){
        if (user_model && [@"0" isEqualToString:user_model.passed]) {
            [self showDatePicker:_select_model];
        }
    }else if ([@"22" isEqualToString:_select_model.ids]) {
        if (user_model && [@"0" isEqualToString:user_model.passed]) {
            chooseCompanyViewController *chooseView = [[chooseCompanyViewController alloc]initWithNibName:@"chooseCompanyViewController" bundle:nil];
            chooseView.delegate = self;
            [self.navigationController pushViewController:chooseView animated:YES];
        }
    }
    
}
-(void)getCompanyDatas:(NSDictionary *)datas{
    _select_model = ((CataItemModel*)_dataArray[1]).dataArray[5];
    companyDatas = datas;
    [GlobalData sharedInstance].user.userInfo.departmentId = [datas objectForKey:@"id"];
    [[GlobalData sharedInstance].user save];

    _select_model.value = [datas objectForKey:@"name"];
    _select_model.hasChanged=@"1";
    [_mTableView reloadData];
}

#pragma mark - TargetDelegate

- (void) buttonTarget:(id)sender
{
    if (sender == self.leftButton) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(sender == self.rightButton)
    {
        [self saveUserIcon];
    }else if([sender isKindOfClass:[UIImageView class]])
    {
        [self openPhotoChoiceDialog];
    }else if ([sender isKindOfClass:[UIButton class]])
    {
        NSLog(@"UIButton");
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSMutableDictionary *cars = [NSMutableDictionary dictionary];
        for (CataItemModel *cat_model in _dataArray) {
            if (cat_model &&cat_model.dataArray.count>0) {
                for (BaseCellModel *cell_model in cat_model.dataArray) {
                    NSLog(@"cell_model:%@",cell_model);
                    if ([@"1" isEqualToString:cell_model.ids])
                    {//姓名
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请输入姓名!"];
                            return;
                        }
                        [params setObject:cell_model.value forKey:@"realName"];
                    }else if ([@"2" isEqualToString:cell_model.ids])
                    {//城市
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请输入城市!"];
                            return;
                        }
                        [params setObject:cell_model.value forKey:@"gender"];
                    }else if ([@"3" isEqualToString:cell_model.ids])
                    {//城市
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请输入城市!"];
                            return;
                        }
                        [params setObject:cell_model.value forKey:@"regCity"];
                    }else if ([@"4" isEqualToString:cell_model.ids])
                    {//驾驶证档案编号
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请输入驾驶证档案编号!"];
                            return;
                        }
                        [params setObject:cell_model.value forKey:@"licenseNo"];
                    }else if ([@"5" isEqualToString:cell_model.ids])
                    {//驾驶证注册日期
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请选择初次领驾照日期!"];
                            return;
                        }
                        [params setObject:cell_model.value forKey:@"licenseDate"];
                    }else if ([@"6" isEqualToString:cell_model.ids])
                    {//驾驶证类型
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请选择驾驶证类型!"];
                            return;
                        }
                        [params setObject:cell_model.value forKey:@"licenseType"];
                    }else if ([@"22" isEqualToString:cell_model.ids])
                    {//驾驶证类型
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请选择所属公司!"];
                            return;
                        }
                        [params setObject:[GlobalData sharedInstance].user.userInfo.departmentId forKey:@"departmentId"];
                    }else if ([@"7" isEqualToString:cell_model.ids])
                    {//职业类型
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请选择职业类型!"];
                            return;
                        }
                        [params setObject:[@"0" isEqualToString:cell_model.value]?@"true":@"false" forKey:@"fullJob"];
                    }else if ([@"8" isEqualToString:cell_model.ids])
                    {//身份证ID
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请选输入身份证号码!"];
                            return;
                        }
                        [params setObject:cell_model.value forKey:@"identifierNo"];
                    }else if ([@"51" isEqualToString:cell_model.ids])
                    {//籍贯
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请选输入户籍所在地!"];
                            return;
                        }
                        [params setObject:cell_model.value forKey:@"nativePlace"];
                    }else if ([@"9" isEqualToString:cell_model.ids])
                    {//备注
                        [params setObject:cell_model.value forKey:@"description"];
                    }else if ([@"10" isEqualToString:cell_model.ids])
                    {//车牌号
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请选输入车牌号!"];
                            return;
                        }
                        [cars setObject:cell_model.value forKey:@"no"];
                    }else if ([@"11" isEqualToString:cell_model.ids])
                    {//车牌号
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请选输入车信息如：白色轩逸!"];
                            return;
                        }
                        [cars setObject:cell_model.value forKey:@"description"];
                    }else if ([@"21" isEqualToString:cell_model.ids])
                    {//车牌号
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请选输入车颜色如：白色!"];
                            return;
                        }
                        [cars setObject:cell_model.value forKey:@"color"];
                    }
                    else if ([@"12" isEqualToString:cell_model.ids])
                    {//车牌号
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请输入车辆拥有者!"];
                            return;
                        }
                        [cars setObject:cell_model.value forKey:@"owner"];
                    }else if ([@"13" isEqualToString:cell_model.ids])
                    {//车牌号
                        if (!cell_model.value || [cell_model.value length]==0) {
                            [self showToast:@"请选择车辆注册日期!"];
                            return;
                        }
                        [cars setObject:cell_model.value forKey:@"regDate"];
                    }else if ([@"30" isEqualToString:cell_model.ids])
                    {//车牌号
                        [params setObject:cell_model.value forKey:@"wintroducer"];
                    }
                    else if ([@"14" isEqualToString:cell_model.ids])
                    {//车牌号
                        [cars setObject:cell_model.value forKey:@"regCity"];
                    }
                }
            }
        }
        [params setObject:[cars lk_JSONString] forKey:@"car"];
        if ([GlobalData sharedInstance].user.isLogin) {
            [params setObject:[GlobalData sharedInstance].user.userInfo.ids forKey:@"id"];
            NSLog(@"%@",params);
            [UserInfoModel uploadImageData:params succ:^(NSDictionary *resultDictionary) {
                
                NSLog(@"%@",resultDictionary);
                UserInfoModel *userInfo = [[UserInfoModel alloc] initWithDictionary:[resultDictionary objectForKey:@"data"] error:nil];
                if (userInfo) {
                    NSString *token = [resultDictionary objectForKey:@"token"];
                    [GlobalData sharedInstance].user.session = token;
                    [GlobalData sharedInstance].user.isLogin = YES;
                    [GlobalData sharedInstance].user.userInfo = userInfo;
                    [[GlobalData sharedInstance].user save];

                    DriverRegisterController *photo = [[DriverRegisterController alloc] init];
                    [self.navigationController pushViewController:photo animated:YES];
                }else{
                    [self showToast:@"解析失败"];
                }
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                [self showToast:errorMessage];
            }];
        }
    }
}

#pragma mark - Open Photo Choice
- (void) openPhotoChoiceDialog
{
    if (iOS8Later){
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self takePhoto];
        }];
        UIAlertAction *selectPhotoAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self photoLibrary];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:takePhotoAction];
        [alertController addAction:selectPhotoAction];
        if (alertController) {
            [self presentViewController:alertController animated:YES completion:nil];
        }}else if(iOS7Later)
        {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                 destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
            [sheet showInView:self.view];
        }
    
}

#pragma  mark - Photo Choice

#pragma mark - 从相册中选择
- (void)photoLibrary
{
    //从相册选择
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES  completion:^(){}];
    
}

#pragma mark 拍照
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^(){}];
    }else {
        [MBProgressHUD showTextHUBWithText:@"相机不可用" inView:nil];
    }
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self takePhoto];
    }else if(buttonIndex==1){
        [self photoLibrary];
    }
}
// 对图片尺寸进行压缩 和 转格式
- (void)imagechange
{
    // 对图片尺寸进行压缩
    UIImage * hehehe = nil;
    UIImage * imageNew = [self imageWithImage:hehehe scaledToSize:CGSizeMake(300, 40)];
    NSData *data;
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(imageNew)) {
        //返回为png图像。
        data =   UIImagePNGRepresentation(imageNew);
    }else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(imageNew,0);
    }
    
}

//对图片尺寸进行压缩
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


// 从相册选择完成调用的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    self.headerImage=image;
    
    NSData *data = UIImagePNGRepresentation(image);
    _iconData = [data base64EncodedStringWithOptions:0];
    
    CataItemModel *d = _dataArray[0];
    BaseCellModel *md = d.dataArray[0];
    md.value = _iconData;
    //md.hasChanged = @"1";
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.mTableView reloadData];
    
    if (image) {
        [self setRightButtonText:@"保存头像" withFont:[UIFont systemFontOfSize:14]];
        [self.rightButton setHidden:NO];
    }else{
        [self.rightButton setHidden:YES];
    }
}

#pragma mark 取消 imagePickerController
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];//隐藏相机图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image) {
        [self imagePickerController:picker didFinishPickingImage:image editingInfo:[NSDictionary dictionary]];
    }
}


- (void) saveInfo:(NSMutableDictionary*)params
{
    MBProgressHUD *hud = [MBProgressHUD showProgressView:@"正在提交数据！请稍候..." inView:nil];
    [hud show:YES];
    [AuthItemModel saveAuthVerifyedInfo:params success:^(NSDictionary *resultDictionary) {
        NSLog(@"resultDictionary:%@",resultDictionary);
        [MBProgressHUD showAndHideWithMessage:@"头像保存成功!" forHUD:nil];
        [self.rightButton setHidden:YES];
        [hud hide:YES];
        
        UserInfoModel *userInfo = [[UserInfoModel alloc] initWithDictionary:[resultDictionary objectForKey:@"data"] error:nil];
        if (userInfo) {
            [GlobalData sharedInstance].user.userInfo = userInfo;
            [[GlobalData sharedInstance].user save];
            [CommonUtility sd_removeImageCacheWithURL:[CommonUtility driverHeaderImageUrl:userInfo.ids]];
        }else{
            [MBProgressHUD showAndHideWithMessage:@"解析失败" forHUD:nil];
        }
        [self.mTableView reloadData];
    } failed:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
        [self.rightButton setHidden:YES];
        [hud hide:YES];
    }];
}

#pragma  mark -pick DatePicker
- (void) showDatePicker:(BaseCellModel*)model;
{
    ASBirthSelectSheet *birthPicker= [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    birthPicker.selectDate =[CommonUtility convertDateToString:[NSDate date] withFormat:@"yyyy-MM-dd"];
    birthPicker.GetSelectDate = ^(NSString *date){
        NSLog(@"date:%@",date);
        model.value = date;
        model.hasChanged=@"1";
        [_mTableView reloadData];
    };
    [self.view.window addSubview:birthPicker];
}

- (void) showDriverType:(BaseCellModel*)model
{

    DriverTypeView *view = [[DriverTypeView alloc] initWithFrame:self.view.bounds];
    view.title = @"请选择驾驶证类型";
    view.block = ^(NSInteger index,NSString *name){
        model.value = name;
        model.hasChanged=@"1";
        [_mTableView reloadData];
    };
    [self.view.window addSubview:view];
}

- (void) showToast:(NSString*)message
{
    [MBProgressHUD showAndHideWithMessage:message forHUD:nil];
}

- (void) setDataEnable:(BOOL)status
{
    for (CataItemModel *model in _dataArray) {
        for (AuthItemModel *itemModel in model.dataArray) {
            itemModel.isEnable = status;
            if ([@"5" isEqualToString:itemModel.ids]||[@"6" isEqualToString:itemModel.ids]||[@"13" isEqualToString:itemModel.ids] || [@"22" isEqualToString:itemModel.ids]){
                itemModel.isEnable = NO;
            }
        }
    }
}

- (void) saveUserIcon
{
    
    if (_iconData) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:_iconData forKey:@"icon"];
        [param setObject:[GlobalData sharedInstance].user.userInfo.ids forKey:@"id"];
        [self saveInfo:param];
    }
    
}
@end