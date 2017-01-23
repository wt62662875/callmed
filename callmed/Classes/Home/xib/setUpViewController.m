//
//  setUpViewController.m
//  callmed
//
//  Created by wt on 2017/1/22.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "setUpViewController.h"
#import "SearchAddressController.h"
#import "BaseItemModel.h"
#import "LoginController.h"

@interface setUpViewController ()<SearchViewControllerDelegate>
@property (nonatomic,assign) NSInteger addressType;

@end

@implementation setUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设置"];
    self.view.backgroundColor = RGBHex(g_assit_gray);
    self.headerView.backgroundColor = [UIColor whiteColor];
    _logOutButton.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
    [_homeAddressButton setTitle:[NSString stringWithFormat:@"%@",[GlobalData sharedInstance].user.userInfo.slocation] forState:UIControlStateNormal];
    [_companyAddressButton setTitle:[NSString stringWithFormat:@"%@",[GlobalData sharedInstance].user.userInfo.elocation?[GlobalData sharedInstance].user.userInfo.elocation:@""] forState:UIControlStateNormal];
}

- (IBAction)addressClick:(UIButton *)sender {
    SearchAddressController *search = [[SearchAddressController alloc] init];
    search.city = [GlobalData sharedInstance].city;
    search.delegate =self;

    switch (sender.tag) {
        case 6:
            _addressType = 0;
            [self.navigationController pushViewController:search animated:YES];
            break;
        case 7:
            _addressType = 1;
            [self.navigationController pushViewController:search animated:YES];
            break;
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
//            CenterModel *address = _dataArray[3];
//            BaseItemModel *home = address.dataArray[0];
            [_homeAddressButton setTitle:[NSString stringWithFormat:@"%@",[GlobalData sharedInstance].user.userInfo.slocation] forState:UIControlStateNormal];
        }else{
            
//            CenterModel *address = _dataArray[3];
//            BaseItemModel *home = address.dataArray[1];
            [_companyAddressButton setTitle:[NSString stringWithFormat:@"%@",[GlobalData sharedInstance].user.userInfo.elocation?[GlobalData sharedInstance].user.userInfo.elocation:@""] forState:UIControlStateNormal];
        }
//        [self initData];
//        [self.mTableView reloadData];
        [MBProgressHUD showAndHideWithMessage:@"保存成功" forHUD:nil];
        //[];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
    }];
}
- (IBAction)logOut:(id)sender {
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
