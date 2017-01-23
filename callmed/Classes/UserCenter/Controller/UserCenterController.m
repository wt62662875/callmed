//
//  UserCenterController.m
//  callmec
//
//  Created by sam on 16/6/25.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "UserCenterController.h"
#import "CenterModel.h"
#import "BaseItemModel.h"

#import "UserInfoCell.h"
#import "CenterInputCell.h"
#import "CenterRadioCell.h"
#import "CenterHeaderCell.h"

#import "VerticalView.h"
#import "DriverInfoEditController.h"
#import "SearchAddressController.h"
#import "BrowerController.h"
#import "CMLocation.h"
#import "LoginController.h"

@class VerticalView;

@interface UserCenterController()<UITableViewDataSource,UITableViewDelegate,TargetActionDelegate,SearchViewControllerDelegate>

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger addressType;
@property (nonatomic,strong) InputModel *md_bank_no;
@property (nonatomic,strong) InputModel *md_bank_name;
@property (nonatomic,strong) InputModel *md_bank_account;
@property (nonatomic,strong) InputModel *md_commend_people;
@property (nonatomic,strong) InputModel *md_bank_Prov;
@property (nonatomic,strong) InputModel *md_bank_City;

@end

@implementation UserCenterController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initData];
    
}

- (void) initView
{
    
    [self setTitle:@"个人中心"];
//    [self.leftButton setImage:[UIImage imageNamed:@"top_back"] forState:UIControlStateNormal];
    [self.leftButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.leftButton setContentMode:UIViewContentModeCenter];
    [self.leftButton addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    NSString *rightTitle = @"注销";
//    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
//    [self.rightButton setTitleColor:RGBHex(g_red) forState:UIControlStateNormal];
//    [self.rightButton addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setHidden:YES];
    [self.rightButton setEnabled:NO];
    _mTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.backgroundColor =RGBHex(g_gray);
    [_mTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:_mTableView];
    
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UIView *bottonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 60)];
    bottonView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 1)];
    lineView.backgroundColor = RGBHex(g_gray);
    [bottonView addSubview:lineView];
    
    UIButton *loginOut = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOut setFrame:CGRectMake(10, 11, kScreenSize.width-20, 40)];
    [loginOut setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginOut setBackgroundColor:RGBHex(g_red)];
    [loginOut addTarget:self action:@selector(loginOut:) forControlEvents:UIControlEventTouchUpInside];
    loginOut.layer.cornerRadius = 5;
    loginOut.layer.masksToBounds = YES;
    [bottonView addSubview:loginOut];

    
    _mTableView.tableFooterView = bottonView;
}

- (void) initData
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }else{
        [_dataArray removeAllObjects];
    }
    
    
    //个人资料管理
    CenterModel *header =[[CenterModel alloc] init];
    header.isShowHeader = NO;
    header.type = 0;
    UserItemModel *user = [[UserItemModel alloc] init];
    user.title =@"个人资料>";
    
    user.icons =[NSString stringWithFormat:@"%@getDHeadIcon?id=%@&token=%@",kserviceURL,
                 [GlobalData sharedInstance].user.userInfo.ids,
                 [GlobalData sharedInstance].user.session];
    user.hasMore = YES;
    user.index = 0;
    user.height = 100.0f;
    
    header.dataArray = [NSArray arrayWithObjects:user, nil];
    [_dataArray addObject:header];
    
    /*
    //订单管理
    CenterModel *header2 =[[CenterModel alloc] init];
    header2.isShowHeader = NO;
    FunctionModel *mdl = [[FunctionModel alloc] init];
    FunctionItemModel *model1 = [[FunctionItemModel alloc] init];
    model1.title = @"我的订单";
    model1.icons = @"user_icon_1";
    model1.hasMore = NO;
    model1.index = 1;
    
    FunctionItemModel *model2 = [[FunctionItemModel alloc] init];
    model2.title = @"我的钱包";
    model2.icons = @"user_icon_2";
    model2.hasMore = NO;
    model2.index = 2;
    
    FunctionItemModel *model3 = [[FunctionItemModel alloc] init];
    model3.title = @"我的消息";
    model3.icons = @"user_icon_3";
    model3.hasMore = NO;
    model3.index = 3;
    
    FunctionItemModel *model4 = [[FunctionItemModel alloc] init];
    model4.title = @"客服电话";
    model4.icons = @"user_icon_4";
    model4.hasMore = NO;
    model4.index = 4;
    mdl.dataArray = [NSArray arrayWithObjects:model1,model2,model3,model4,nil];
    header2.dataArray = [NSArray arrayWithObjects:mdl,nil];
    mdl.height = 70;
    [_dataArray addObject:header2];*/
    CenterModel *header2 = [[CenterModel alloc] init];
    header2.cata_title = @"账户信息";
    header2.icons = @"qianbao";
    header2.isShowHeader = YES;
    header2.type = 1;
    _md_bank_name = [[InputModel alloc] init];
    _md_bank_name.index = 12;
    _md_bank_name.title = @"开户银行名称";
    _md_bank_name.placeHolder=@"例如：中国农业银行";
    _md_bank_name.value = [GlobalData sharedInstance].user.userInfo.bankName;
    _md_bank_name.hasMore = (([GlobalData sharedInstance].user.userInfo.bankName&&[[GlobalData sharedInstance].user.userInfo.bankName length]>0))?NO:YES;
    
    _md_bank_account = [[InputModel alloc] init];
    _md_bank_account.index = 13;
    _md_bank_account.title = @"银行户名";
    _md_bank_account.placeHolder=@"请输入银行开户名";
    _md_bank_account.value = [GlobalData sharedInstance].user.userInfo.realName;
    _md_bank_account.hasMore = (([GlobalData sharedInstance].user.userInfo.bankAccount&&[[GlobalData sharedInstance].user.userInfo.bankAccount length]>0))?NO:YES;
    
    _md_bank_no = [[InputModel alloc] init];
    _md_bank_no.index = 14;
    _md_bank_no.title = @"银行卡号";
    _md_bank_no.placeHolder=@"请输入银行卡号";
    _md_bank_no.hasButton = YES;
    _md_bank_no.value = [GlobalData sharedInstance].user.userInfo.bankNo;
    _md_bank_no.hasMore = (([GlobalData sharedInstance].user.userInfo.bankNo&&[[GlobalData sharedInstance].user.userInfo.bankNo length]>0))?NO:YES;
    
    _md_bank_Prov = [[InputModel alloc] init];
    _md_bank_Prov.index = 21;
    _md_bank_Prov.title = @"开户行所在省";
    _md_bank_Prov.placeHolder=@"请输入开户行所在省";
    _md_bank_Prov.value = [GlobalData sharedInstance].user.userInfo.bankProv;
    _md_bank_Prov.hasMore = (([GlobalData sharedInstance].user.userInfo.bankProv&&[[GlobalData sharedInstance].user.userInfo.bankProv length]>0))?NO:YES;
    
    _md_bank_City = [[InputModel alloc] init];
    _md_bank_City.index = 22;
    _md_bank_City.title = @"开户行所在市";
    _md_bank_City.placeHolder=@"请输入开户行所在市";
    _md_bank_City.value = [GlobalData sharedInstance].user.userInfo.bankCity;
    _md_bank_City.hasMore = (([GlobalData sharedInstance].user.userInfo.bankCity&&[[GlobalData sharedInstance].user.userInfo.bankCity length]>0))?NO:YES;
    
    
    _md_commend_people = [[InputModel alloc] init];
    _md_commend_people.index = 15;
    _md_commend_people.title = @"推荐人";
    _md_commend_people.hasButton = YES;
    _md_commend_people.placeHolder = @"请输入推荐人手机号";
    _md_commend_people.value = [GlobalData sharedInstance].user.userInfo.attribute1;
    _md_commend_people.hasMore = (([GlobalData sharedInstance].user.userInfo.attribute1&& [[GlobalData sharedInstance].user.userInfo.attribute1 length]>0))?NO:YES;
//    ||[[GlobalData sharedInstance].user.userInfo.passed isEqualToString:@"0"]
    header2.dataArray =[NSArray arrayWithObjects:_md_bank_account,_md_bank_name,_md_bank_Prov,_md_bank_City,_md_bank_no,_md_commend_people,nil];
    [_dataArray addObject:header2];
    //账号安全
    CenterModel *header3 = [[CenterModel alloc] init];
    header3.cata_title = @"账号与安全";
    header3.icons = @"icon_userss";
    header3.isShowHeader = YES;
    header3.type = 2;
    BaseItemModel *md_account = [[BaseItemModel alloc] init];
    md_account.index = 5;
    md_account.title = @"绑定社交账号";
    md_account.hasMore = YES;
    header3.dataArray =[NSArray arrayWithObjects:md_account, nil];
//    [_dataArray addObject:header3];
    
    //地址管理
    CenterModel *header4 = [[CenterModel alloc] init];
    header4.cata_title = @"编辑常用地址";
    header4.icons = @"dingweijia";
    header4.isShowHeader = YES;
    header4.type = 3;
    BaseItemModel *f_address = [[BaseItemModel alloc] init];
    f_address.index = 6;
    f_address.title = [NSString stringWithFormat:@"家庭地址:%@",[GlobalData sharedInstance].user.userInfo.slocation];
    f_address.hasMore = YES;
    BaseItemModel *c_address = [[BaseItemModel alloc] init];
    c_address.index = 7;
    c_address.title = [NSString stringWithFormat:@"单位地址:%@",[GlobalData sharedInstance].user.userInfo.elocation?[GlobalData sharedInstance].user.userInfo.elocation:@""];
    c_address.hasMore = YES;
    
    
    header4.dataArray =[NSArray arrayWithObjects:f_address,c_address, nil];
    [_dataArray addObject:header4];

    
    //设置音效开关
    CenterModel *header5 = [[CenterModel alloc] init];
    header5.cata_title = @"音效开关";
    header5.icons = @"shenyin";
    header5.isShowHeader = YES;
    header5.type = 4;
    SpeakerModel *speeker = [[SpeakerModel alloc] init];
    speeker.index = 8;
    speeker.title = @"设置音效开关";
    speeker.hasMore = [SandBoxHelper getVoiceStatus];
    header5.dataArray =[NSArray arrayWithObjects:speeker, nil];
    [_dataArray addObject:header5];
    
    //帮助信息
    CenterModel *header6 = [[CenterModel alloc] init];
    header6.cata_title = @"帮助信息";
    header6.icons = @"tishi";
    header6.isShowHeader = YES;
    header6.type = 5;
    BaseItemModel *item1 = [[BaseItemModel alloc] init];
    item1.index = 9;
    item1.title = @"使用指南";
    item1.hasMore = YES;
    
    BaseItemModel *item2 = [[BaseItemModel alloc] init];
    item2.index = 10;
    item2.title = @"法律条款";
    item2.hasMore = YES;
    
    BaseItemModel *item3 = [[BaseItemModel alloc] init];
    item3.index = 11;
    item3.title = [NSString stringWithFormat:@"当前版本：%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    item3.hasMore = YES;
    
//    BaseItemModel *item4 = [[BaseItemModel alloc] init];
//    item3.index = 12;
//    item3.title = @"乘客专车使用指南";
//    item3.hasMore = YES;
//    
//    BaseItemModel *item5 = [[BaseItemModel alloc] init];
//    item3.index = 13;
//    item3.title = @"版本信息";
//    item3.hasMore = YES;
//    
//    BaseItemModel *item6 = [[BaseItemModel alloc] init];
//    item3.index = 14;
//    item3.title = @"版本信息";
//    item3.hasMore = YES;
    
    header6.dataArray =[NSArray arrayWithObjects:item1,item2,item3,nil];
    [_dataArray addObject:header6];
    
    [_mTableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated
{
    if (_mTableView) {
        [_mTableView reloadData];
    }
}

- (void) buttonTarget:(id)sender
{
    if (sender ==self.leftButton) {
        if (![GlobalData sharedInstance].user.userInfo.bankNo || [@"" isEqualToString:[GlobalData sharedInstance].user.userInfo.bankNo]) {
            [MBProgressHUD showAndHideWithMessage:@"请在个人中心中完善银行账户信息" forHUD:nil];
        }

        [self.navigationController popViewControllerAnimated:YES];
    }else if(sender ==self.rightButton){
//        [[GlobalData sharedInstance].user logout];
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if([sender isKindOfClass:[VerticalView class]]){
        
        NSInteger tag =((VerticalView*)sender).tag;
        NSLog(@"tag:%ld",(long)((VerticalView*)sender).tag);
        if (tag==0) {
//            OrderListController *order = [[OrderListController alloc] init];
//            [self.navigationController pushViewController:order animated:YES];
        }else if(tag==1)
        {
//            WalletController *wallet =[[WalletController alloc] init];
//            [self.navigationController pushViewController:wallet animated:YES];
        }else if(tag==2)
        {
//            MessageController *message = [[MessageController alloc] init];
//            [self.navigationController pushViewController:message animated:YES];
        }else if(tag==3)
        {
            [JCAlertView showOneButtonWithTitle:@"温馨提示" Message:@"客服电话:010-3389021" ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"呼叫" Click:^{
                
            }];
        }
//        UserCenterController *userctrl = [[UserCenterController alloc] init];
//        [self.navigationController pushViewController:userctrl animated:YES];
    }else if([sender isKindOfClass:[InputModel class]]){
        InputModel *temp = (InputModel *)sender;
        [self checkBankAccount:temp.index];
    }else{
        UIButton *btn =(UIButton*)sender;
        NSString *msg = btn.titleLabel.text;
        if ([@"个人资料>" isEqualToString:msg]) {
            DriverInfoEditController *editDriverInfo = [[DriverInfoEditController alloc] init];
            [self.navigationController pushViewController:editDriverInfo animated:YES];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CenterModel *model = _dataArray[section];
    return model.dataArray.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CenterModel *model = _dataArray[indexPath.section];
    BaseItemModel *item = model.dataArray[indexPath.row];
    if (model.type==0) {
        static NSString *cellid0 = @"cellids0";
        CenterHeaderCell *cell= [tableView dequeueReusableCellWithIdentifier:cellid0];
        if (!cell) {
            cell = [[CenterHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid0];
        }
        cell.delegate = self;
        [cell setModel:model.dataArray[indexPath.row]];
        return cell;
    }else if (model.type==1) {
        static NSString *cellid1 = @"cellids1";
        CenterInputCell *cell= [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[CenterInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
        }
        cell.delegate = self;
        [cell setModel:model.dataArray[indexPath.row]];
        return cell;
    }else if (model.type==4) {
        static NSString *cellid4 = @"cellids4";
        CenterRadioCell *cell= [tableView dequeueReusableCellWithIdentifier:cellid4];
        if (!cell) {
            cell = [[CenterRadioCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid4];
        }
        cell.delegate = self;
        [cell setModel:model.dataArray[indexPath.row]];
        return cell;
    }else{
        static NSString *cellid = @"cellids";
        UserInfoCell *cell= [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.delegate = self;
        [cell setModel:model.dataArray[indexPath.row]];
        return cell;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CenterModel *model = _dataArray[indexPath.section];
    BaseItemModel *mods = model.dataArray[0];
    return mods.height;//model;
}


- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CenterModel *model = _dataArray[section];
    if (model.isShowHeader) {
        
        UIView *container = [[UIView alloc] init];
//        [container setBackgroundColor:RGBHex(g_assit_green)];
        UIView *view = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 100, 40)];
        [view setBackgroundColor:[UIColor whiteColor]];
        UIImageView *leftIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.icons]];
        [view addSubview:leftIcon];
        [leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view).offset(10);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setText:model.cata_title];
        UIFont *font = [UIFont systemFontOfSize:16];
        CGSize size = [model.cata_title sizeWithFont:font maxSize:CGSizeMake(200, 1000)];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftIcon.mas_right).offset(10);
            make.width.mas_equalTo(size.width);
            make.centerY.equalTo(view);
        }];
        
        [container addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(container).offset(5);
            make.left.equalTo(container);
            make.bottom.equalTo(container).offset(-1);
            make.width.equalTo(container);
        }];
        
        UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 0, 1)];
        [grayLine setBackgroundColor:[UIColor whiteColor]];
        [container addSubview:grayLine];
        [grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(container);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(container);
            make.width.mas_equalTo(10);
        }];
        return container;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CenterModel *model = _dataArray[section];
    if (model.isShowHeader) {
        return 50;
    }
    return 0;
}


#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%ld  %ld",indexPath.section,indexPath.row);
    CenterModel *model = _dataArray[indexPath.section];
    [self jumpControllerChange:model.dataArray[indexPath.row]];
}

- (void)jumpControllerChange:(BaseItemModel*)model;
{
    switch (model.index) {
        case 6:
        {
            SearchAddressController *search = [[SearchAddressController alloc] init];
            search.city = [GlobalData sharedInstance].city;
            search.delegate =self;
            _addressType = 0;
            [self.navigationController pushViewController:search animated:YES];
            
        }
            break;
        case 7:
        {
            SearchAddressController *search = [[SearchAddressController alloc] init];
            search.delegate =self;
            search.city = [GlobalData sharedInstance].city;
            _addressType = 1;
            [self.navigationController pushViewController:search animated:YES];
        }
            break;
        case 8:
        {
//            SearchAddressController *search = [[SearchAddressController alloc] init];
//            search.city = [GlobalData sharedInstance].city;
//            search.delegate =self;
//            [self.navigationController pushViewController:search animated:YES];
        }break;
        case 9:
        {
            BrowerController *brower = [[BrowerController alloc] init];
            [brower setTitleStr:@"使用指南"];
            brower.urlStr =[NSString stringWithFormat:@"%@getArticle?id=100&token=%@",
                            kserviceURL,
                            [GlobalData sharedInstance].user.session];
            [self.navigationController pushViewController:brower animated:YES];
        }break;
        case 10:
        {
            BrowerController *brower = [[BrowerController alloc] init];
            [brower setTitleStr:@"法律条款"];
            brower.urlStr =[NSString stringWithFormat:@"%@getArticle?id=2&token=%@",
                            kserviceURL,
                            [GlobalData sharedInstance].user.session];
            [self.navigationController pushViewController:brower animated:YES];
        }break;
        case 11:
        {
            BrowerController *brower = [[BrowerController alloc] init];
            [brower setTitleStr:@"版本信息"];
            brower.urlStr =[NSString stringWithFormat:@"%@getArticle?id=3&token=%@&version=%@",
                            kserviceURL,
                            [GlobalData sharedInstance].user.session,
                            [CommonUtility versions]];
            [self.navigationController pushViewController:brower animated:YES];
        }break;
//        case 12:
//        {
//            BrowerController *brower = [[BrowerController alloc] init];
//            [brower setTitleStr:@"版本信息"];
//            brower.urlStr =[NSString stringWithFormat:@"%@getArticle?id=3&token=%@&version=%@",
//                            kserviceURL,
//                            [GlobalData sharedInstance].user.session,
//                            [CommonUtility versions]];
//            [self.navigationController pushViewController:brower animated:YES];
//        }break;
//        case 13:
//        {
//            BrowerController *brower = [[BrowerController alloc] init];
//            [brower setTitleStr:@"版本信息"];
//            brower.urlStr =[NSString stringWithFormat:@"%@getArticle?id=3&token=%@&version=%@",
//                            kserviceURL,
//                            [GlobalData sharedInstance].user.session,
//                            [CommonUtility versions]];
//            [self.navigationController pushViewController:brower animated:YES];
//        }break;
        default:
            break;
    }
}

- (void)searchViewController:(SearchAddressController*)searchViewController didSelectLocation:(CMLocation *)locations
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSLog(@"%@",[GlobalData sharedInstance].user.userInfo.ids);
    if ([GlobalData sharedInstance].user.isLogin) {
        [params setObject:[GlobalData sharedInstance].user.userInfo.ids forKey:@"id"];
    }
    
    if (_addressType==0) {
        [params setObject:locations.name forKey:@"usualStart"];
        [params setObject:locations.address forKey:@"address"];
        [params setObject:[NSString stringWithFormat:@"%f",locations.coordinate.latitude] forKey:@"sLatitude"];
        [params setObject:[NSString stringWithFormat:@"%f",locations.coordinate.longitude] forKey:@"sLongitude"];
        [params setObject:locations.name forKey:@"sLocation"];

    }else if(_addressType==1)
    {
        NSLog(@"%@",locations);
        [params setObject:locations.name forKey:@"usualEnd"];
//        [params setObject:locations.address forKey:@"elocation"];
        [params setObject:[NSString stringWithFormat:@"%f",locations.coordinate.latitude] forKey:@"eLatitude"];
        [params setObject:[NSString stringWithFormat:@"%f",locations.coordinate.longitude] forKey:@"eLongitude"];
        [params setObject:locations.name forKey:@"eLocation"];
        
    }else{
        [params setObject:locations.name forKey:@"usualStart"];
        [params setObject:locations.address forKey:@"address"];
        [params setObject:[NSString stringWithFormat:@"%f",locations.coordinate.latitude] forKey:@"sLatitude"];
        [params setObject:[NSString stringWithFormat:@"%f",locations.coordinate.longitude] forKey:@"sLongitude"];
        [params setObject:locations.name forKey:@"sLocation"];
    }
    
    [UserInfoModel commitEditUserInfo:params succ:^(NSDictionary *resultDictionary) {
        NSLog(@"result:%@",resultDictionary);
        NSDictionary *data = resultDictionary[@"data"];
        UserInfoModel *user = [[UserInfoModel alloc] initWithDictionary:data error:nil];
        [GlobalData sharedInstance].user.userInfo = user;
        [[GlobalData sharedInstance].user save];
        
        
        if (_addressType==0) {
            CenterModel *address = _dataArray[3];
            BaseItemModel *home = address.dataArray[0];
            home.title = [NSString stringWithFormat:@"家庭地址:%@",[GlobalData sharedInstance].user.userInfo.slocation];
            
        }else{
        
            CenterModel *address = _dataArray[3];
            BaseItemModel *home = address.dataArray[1];
            home.title = [NSString stringWithFormat:@"单位地址:%@",[GlobalData sharedInstance].user.userInfo.company?[GlobalData sharedInstance].user.userInfo.elocation:@""];
        }
        [self initData];
        [self.mTableView reloadData];
        [MBProgressHUD showAndHideWithMessage:@"保存成功" forHUD:nil];
        //[];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
    }];
}

- (void) checkBankAccount:(NSInteger)tag
{
    if ([GlobalData sharedInstance].user.isLogin) {
        NSMutableDictionary *param =[NSMutableDictionary dictionary];
        if (tag == 14) {
            //银行信息    提示没有输入的
            if (![[GlobalData sharedInstance].user.userInfo.bankAccount isEqualToString:_md_bank_account.value]
                &&_md_bank_account.value
                &&[_md_bank_account.value length]>0) {
                [param setObject:_md_bank_account.value forKey:@"bankAccount"];
            }else{
                [MBProgressHUD showAndHideWithMessage:@"请填写银行户名" forHUD:nil];
                return;
            }
            if (![[GlobalData sharedInstance].user.userInfo.bankName isEqualToString:_md_bank_name.value]
                &&_md_bank_name.value
                &&[_md_bank_name.value length]>0) {
                [param setObject:_md_bank_name.value forKey:@"bankName"];
            }else{
                [MBProgressHUD showAndHideWithMessage:@"请填写开户行名称" forHUD:nil];
                return;
            }
            if (![[GlobalData sharedInstance].user.userInfo.bankNo isEqualToString:_md_bank_no.value]
                &&_md_bank_no.value
                &&[_md_bank_no.value length]>0) {
                [param setObject:_md_bank_no.value forKey:@"bankNo"];
            }else{
                [MBProgressHUD showAndHideWithMessage:@"请填写银行卡号" forHUD:nil];
                return;
            }
            if (![[GlobalData sharedInstance].user.userInfo.bankProv isEqualToString:_md_bank_Prov.value]
                &&_md_bank_Prov.value
                &&[_md_bank_Prov.value length]>0) {
                [param setObject:_md_bank_Prov.value forKey:@"bankProv"];
            }else{
                [MBProgressHUD showAndHideWithMessage:@"请填写开户行所在省" forHUD:nil];
                return;
            }
            if (![[GlobalData sharedInstance].user.userInfo.bankCity isEqualToString:_md_bank_City.value]
                &&_md_bank_City.value
                &&[_md_bank_City.value length]>0) {
                [param setObject:_md_bank_City.value forKey:@"bankCity"];
            }else{
                [MBProgressHUD showAndHideWithMessage:@"请填写开户行所在市" forHUD:nil];
                return;
            }
            [self saveUserInfo:param canback:YES];

        }else{
            //推荐人    提示没有输入
            if(_md_commend_people.hasMore && _md_commend_people.value && [_md_commend_people.value length]>0){
                [param setObject:_md_commend_people.value forKey:@"introducer"];
            }else{
                [MBProgressHUD showAndHideWithMessage:@"请填写推荐人再点击保存" forHUD:nil];
                return;
            }
            [self saveUserInfo:param canback:YES];

        }
        
        //introducer

    }

}

- (void) saveUserInfo:(NSMutableDictionary*)params canback:(BOOL)isBack
{
    if ([GlobalData sharedInstance].user.isLogin) {
        [params setObject:[GlobalData sharedInstance].user.userInfo.ids forKey:@"id"];
    }
    if ([GlobalData sharedInstance].user.userInfo.attribute1) {
        [params setObject:[GlobalData sharedInstance].user.userInfo.attribute1 forKey:@"wintroducer"];
    }
    [UserInfoModel commitEditUserInfo:params succ:^(NSDictionary *resultDictionary) {
        NSLog(@"result:%@",resultDictionary);
        NSDictionary *data = resultDictionary[@"data"];
        UserInfoModel *user = [[UserInfoModel alloc] initWithDictionary:data error:nil];
        [GlobalData sharedInstance].user.userInfo = user;
        [[GlobalData sharedInstance].user save];
        [self initData];
        [self.mTableView reloadData];
        [MBProgressHUD showAndHideWithMessage:@"保存成功" forHUD:nil onCompletion:^{
            if (isBack) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
    }];
}

-(void)loginOut:(id)sender{
    [[GlobalData sharedInstance].user logout];
    [self openLoginController:nil];
}
- (void) openLoginController:(id)sender
{
    if (![LoginController hasVisiabled]) {
        LoginController *registers = [[LoginController alloc] init];
        [self.navigationController pushViewController:registers animated:YES];
    }else{
        NSLog(@"LoginController has prensent");
    }
}
@end
