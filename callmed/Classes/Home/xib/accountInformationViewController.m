//
//  accountInformationViewController.m
//  callmed
//
//  Created by wt on 2017/1/22.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "accountInformationViewController.h"
#import "BaseItemModel.h"
#import "CenterModel.h"
#import "CenterInputCell.h"
#import "UserInfoCell.h"
#import "allOrderViewController.h"
#import "WalletModel.h"

@interface accountInformationViewController ()<TargetActionDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (weak, nonatomic) IBOutlet UILabel *money;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) InputModel *md_bank_no;
@property (nonatomic,strong) InputModel *md_bank_name;
@property (nonatomic,strong) InputModel *md_bank_account;
@property (nonatomic,strong) InputModel *md_commend_people;
@property (nonatomic,strong) InputModel *md_bank_Prov;
@property (nonatomic,strong) InputModel *md_bank_City;
@property (nonatomic,strong) NSDictionary *dictionary;

@end

@implementation accountInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"账户信息"];
    self.view.backgroundColor = RGBHex(g_assit_gray);
    self.headerView.backgroundColor = [UIColor clearColor];
    self.bottomHeaderLine.hidden = YES;
    [self.leftButton setImage:[UIImage imageNamed:@"top_back"] forState:UIControlStateNormal];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    [self fetchWalletInfo];
    [self initData];

    // Do any additional setup after loading the view from its nib.
}
- (void) initData
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }else{
        [_dataArray removeAllObjects];
    }
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
    }else if([sender isKindOfClass:[InputModel class]]){
        InputModel *temp = (InputModel *)sender;
        [self checkBankAccount:temp.index];
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
   if (model.type==1) {
        static NSString *cellid1 = @"cellids1";
        CenterInputCell *cell= [tableView dequeueReusableCellWithIdentifier:cellid1];
        if (!cell) {
            cell = [[CenterInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid1];
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
        UIView *view = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 100, 50)];
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
            make.top.equalTo(container).offset(0);
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
            make.bottom.equalTo(container).offset(-1);
            make.right.equalTo(container);
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
- (IBAction)click:(id)sender {
    allOrderViewController *allOrderVC = [[allOrderViewController alloc]initWithNibName:@"allOrderViewController" bundle:nil];
    [allOrderVC setAccountId:_dictionary[@"accountId"]];
    [allOrderVC setBalance:[NSString stringWithFormat:@"%@",[_dictionary objectForKey:@"cmmoney"]]];
    [self.navigationController pushViewController:allOrderVC animated:YES];

}
- (void) fetchWalletInfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if([GlobalData sharedInstance].user.isLogin)
    {
        [params setObject:[GlobalData sharedInstance].user.userInfo.ids forKey:@"driverId"];
    }
    
    [HttpShareEngine callWithFormParams:params withMethod:@"dAccount" succ:^(NSDictionary *resultDictionary) {
        NSLog(@"%@",resultDictionary);
        _dictionary = resultDictionary[@"data"];
//        _accountId =_dictionary[@"accountId"];
        _money.text = [_dictionary objectForKey:@"cmmoney"];
        NSLog(@"resultDictionary:%@",resultDictionary);
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        NSLog(@"errorMessage:%@",errorMessage);
    }];

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
