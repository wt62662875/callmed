//
//  carInformationViewController.m
//  callmed
//
//  Created by wt on 2017/1/22.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "carInformationViewController.h"
#import "CataItemModel.h"
#import "EditContentCell.h"
#import "EditPhotoCell.h"
#import "EditCommiteCell.h"
#import "DriverTypeView.h"
#import "ASBirthSelectSheet.h"
#import "DriverRegisterController.h"

@interface carInformationViewController ()<TargetActionDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) BaseCellModel *select_model;

@end

@implementation carInformationViewController
{
    UserInfoModel *user_model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"车辆信息"];
    self.view.backgroundColor = RGBHex(g_assit_gray);
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self initData];

    // Do any additional setup after loading the view from its nib.
}
- (void) initData
{
    _dataArray = [NSMutableArray array];
    UserInfoModel *model = [GlobalData sharedInstance].user.userInfo;
    user_model = model;
    NSString *carNo = [NSString stringWithFormat:@"%@",model.car[@"no"]?model.car[@"no"]:@""];
    NSString *carType = [NSString stringWithFormat:@"%@",model.car[@"description"]?model.car[@"description"]:@""];
    NSString *carOwer = [NSString stringWithFormat:@"%@",model.car[@"owner"]?model.car[@"owner"]:@""];
    NSString *carDate = [NSString stringWithFormat:@"%@",model.car[@"regDate"]?model.car[@"regDate"]:@""];
    NSString *carRegistCity = [NSString stringWithFormat:@"%@",model.car[@"regCity"]?model.car[@"regCity"]:@""];
    NSString *carColor = [NSString stringWithFormat:@"%@",model.car[@"color"]?model.car[@"color"]:@""];
    
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
    [_dataArray addObject:model2];
    [_dataArray addObject:model3];
    [_dataArray addObject:model4];
    if ([@"1" isEqualToString:model.passed])
    {
        [_dataArray removeObject:model4];
        [self setDataEnable:NO];
    }else{
        [_dataArray removeObject:model3];
        [self setDataEnable:YES];
    }
    
}
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
     if([@"1" isEqualToString:model.type]){
        static NSString *contentid1 = @"contentid";
        EditContentCell *cell = [tableView dequeueReusableCellWithIdentifier:contentid1];
        if (!cell) {
            cell = [[EditContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentid1];
        }
        [cell setScaleTitle:0.35];
        [cell setContentHeight:0.6];
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
    }
    
}
#pragma mark - TargetDelegate

- (void) buttonTarget:(id)sender
{
    if (sender == self.leftButton) {
        [self.navigationController popViewControllerAnimated:YES];
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

- (void) showToast:(NSString*)message
{
    [MBProgressHUD showAndHideWithMessage:message forHUD:nil];
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
