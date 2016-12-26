//
//  ViewController.m
//  callmed
//
//  Created by sam on 16/7/10.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "HomeController.h"
#import "TabBarView.h"
#import "DriverCarController.h"
#import "UserInComeController.h"
#import "TripCataController.h"
#import "MessageController.h"

//#import "RegisterController.h"
#import "LoginController.h"
#import "UserCenterController.h"
#import "DriverRegisterController.h"
#import "DriverInfoEditController.h"
#import "TestController.h" //test
#import "DriverRegisterController.h"

#import "NoticeSpecialView.h"
#import "NoticeViewCommon.h"
#import "NoticeBusView.h"
#import "NoticeBusCommonView.h"

#import "NotificationModel.h"
#import "AppVersionModel.h"
#import "OrderModel.h"
#import "CarPoolingView.h"

@interface HomeController ()<TargetActionDelegate>
{
    CarPoolingView *poolView;
    OrderModel *model;
}

@property (nonatomic,strong) TabBarView *bottomView;
@property (nonatomic,strong) BaseController *currentController;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openLoginController:) name:NOTICE_NEED_SIGN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderNotice:) name:NOTICE_ORDER_STATE_UPDATE object:nil];
    //[[NSNotificationCenter defaultCenter]  postNotificationName:NOTICE_ORDER_STATE_UPDATE object:payloadMsg];
    NSLog(@"CommonUtility compare:%ld",(long)[CommonUtility compareDateStringToNow:@"2016-09-03 10:00:00" withFormat:nil]);
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) initData
{
    [self addChildViewController:[[TripCataController alloc] init]];
    [self addChildViewController:[[DriverCarController alloc] init]];//DriverRegisterController.h DriverCarController
    [self addChildViewController:[[UserInComeController alloc] init]];
    _dataArray =[NSMutableArray array];
    
    
    NSMutableArray *da  =[NSMutableArray array];
    [da addObject:@"1"];
    [da addObject:@"2"];
    [da addObject:@"3"];
    [da removeLastObject];
    [da enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL * stop) {
        NSLog(@"left objet:%@ %ld",obj,(long)idx);
    }];
    
    [self checkVersion];
}

- (void) viewDidAppear:(BOOL)animated
{
//    [UserInfoModel login:[SandBoxHelper fetchLoginNumber] withPwd:[SandBoxHelper fetchLoginRandomCode] succ:^(NSDictionary *resultDictionary) {
//        NSLog(@"succes:%@",resultDictionary);
//        UserInfoModel *userInfo = [[UserInfoModel alloc] initWithDictionary:[resultDictionary objectForKey:@"data"] error:nil];
//        if (userInfo) {
//            NSString *token = [resultDictionary objectForKey:@"token"];
//            [GlobalData sharedInstance].user.session = token;
//            [GlobalData sharedInstance].user.isLogin = YES;
//            [GlobalData sharedInstance].user.userInfo = userInfo;
//            [[GlobalData sharedInstance].user save];
//        }else{
//            [MBProgressHUD showAndHideWithMessage:@"解析失败" forHUD:nil];
//        }
//        
//    } fail:^(NSInteger errorCode, NSString *errorMessage) {
//        [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
//    }];
    if(![GlobalData sharedInstance].user.isLogin)
    {
        [self openLoginController:nil];
    }else if(![GlobalData sharedInstance].user.userInfo.identifierNo||
             [[GlobalData sharedInstance].user.userInfo.identifierNo length]==0)
    {
        DriverInfoEditController *registers = [[DriverInfoEditController alloc] init];
        [self.navigationController pushViewController:registers animated:YES];
    }else{
        if ([@"1" isEqualToString:[GlobalData sharedInstance].user.userInfo.passed]) {
            
        }else{
            [UserInfoModel login:[SandBoxHelper fetchLoginNumber] withPwd:[SandBoxHelper fetchLoginRandomCode] succ:^(NSDictionary *resultDictionary) {
                NSLog(@"succes:%@",resultDictionary);
                UserInfoModel *userInfo = [[UserInfoModel alloc] initWithDictionary:[resultDictionary objectForKey:@"data"] error:nil];
                if (userInfo) {
                    NSString *token = [resultDictionary objectForKey:@"token"];
                    [GlobalData sharedInstance].user.session = token;
                    [GlobalData sharedInstance].user.isLogin = YES;
                    [GlobalData sharedInstance].user.userInfo = userInfo;
                    [[GlobalData sharedInstance].user save];
                    
                    if ([GlobalData sharedInstance].user.isLogin && [@"1" isEqualToString:[GlobalData sharedInstance].user.userInfo.passed ]) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                                        message:[NSString stringWithFormat:@"您的注册信息已审核通过"]
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                        [alert show];
                        [USERDEFAULTS setObject:@"1" forKey:@"firstLaunch"];
                    }
                    
                    if([GlobalData sharedInstance].user.isLogin && [@"0" isEqualToString:[GlobalData sharedInstance].user.userInfo.passed ] && [[GlobalData sharedInstance].user.userInfo.identifierNo length]!=0)
                    {
                        NSString *upReason = [GlobalData sharedInstance].user.userInfo.upReason;
                        if(upReason)
                        {
                            //            [self showAlertMessage:[NSString stringWithFormat:@"审批未通过: %@",upReason]];
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                                            message:[NSString stringWithFormat:@"审批未通过: %@",upReason]
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"确定"
                                                                  otherButtonTitles:nil];
                            [alert show];
                        }else{
                            //            [self showAlertMessage:@"您的信息已经提交，等待审核通过。"];
                            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                                            message:@"您的信息已经提交，等待审核通过。"
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"确定"
                                                                  otherButtonTitles:nil];
                            [alert show];
                        }
                        
                    }else{
                        
                    }
                }else{
                    [MBProgressHUD showAndHideWithMessage:@"解析失败" forHUD:nil];
                }
                
            } fail:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
            }];
        }
    }
//    DriverRegisterController *ps = [[DriverRegisterController alloc] init];
//    [self.navigationController pushViewController:ps animated:YES];


}

- (void) initView
{
    [self.headerView setBackgroundColor:RGBHex(g_red)];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.leftButton setImage:[UIImage imageNamed:@"xingzhuang"] forState:UIControlStateNormal];
//    [self setRightButtonText:@"注销" withFont:[UIFont systemFontOfSize:14]];
//    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.rightButton addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightButton setImage:[UIImage imageNamed:@"xinfeng"] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    
//    if([GlobalData sharedInstance].user.isLogin && [@"0" isEqualToString:[GlobalData sharedInstance].user.userInfo.passed ])
//    {
////        [self.rightButton setHidden:NO];
//        [self showAlertMessage:@"您的信息已经提交，等待审核通过。"];
//    }else{
////        [self.rightButton setHidden:YES];
//    }
    
    _bottomView =[[TabBarView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    [_bottomView setDelegate:self];
    [_bottomView setSelectIndex:0];
    [self buttonSelectedIndex:0];
}

- (void) buttonSelectedIndex:(NSInteger)index
{
    if (_currentController) {
        [_currentController.view removeFromSuperview];
    }
    _currentController = self.childViewControllers[index];
    [_currentController reloadData];
    [self.view addSubview:_currentController.view];
    [_currentController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    [self setTitle:_currentController.title];
    if ([GlobalData sharedInstance].user.isLogin) {
        [self.rightButton setHidden:NO];
//        if (index==2) {
//            [self setRightButtonText:@"注销" withFont:[UIFont systemFontOfSize:14]];
//            [self.rightButton setImage:nil forState:UIControlStateNormal];
//        }else{
            [self setRightButtonText:nil withFont:[UIFont systemFontOfSize:14]];
            [self setRightButtonImage:@"xinfeng"];
//        }
    }else{
        [self.rightButton setHidden:YES];
    }
    [self fetchOrderNumber];
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

- (void) buttonTarget:(id)sender
{
    if (sender== self.leftButton) {
        UserCenterController *mUserCenter = [[UserCenterController alloc] init];
        [self.navigationController pushViewController:mUserCenter animated:YES];
    }else if(sender == self.rightButton)
    {
        NSLog(@"%@",self.rightButton.titleLabel.text);
        if (self.rightButton.titleLabel.text==nil) {
            MessageController *message = [[MessageController alloc] init];
            [self.navigationController pushViewController:message animated:YES];
        }else{
            [self.rightButton setHidden:YES];
            [[GlobalData sharedInstance].user logout];
            [self openLoginController:nil];
        }
    }else if([sender isKindOfClass:[NoticeSpecialView class]])
    {
        NoticeSpecialView *orderView = (NoticeSpecialView*)sender;
        NotificationModel *order = orderView.model;
        if ([order.oType integerValue]==1) {
            
            if(_currentController &&[_currentController isKindOfClass:[TripCataController class]])
            {
                ((TripCataController*)_currentController).notice_model = order;
            }
            [_bottomView setSelectIndex:0];
            [self buttonSelectedIndex:0];
            if ([@"1" isEqualToString:order.type]) {
                [orderView dismiss];
                [OrderModel driverRobOrderId:order.ids driver:[GlobalData sharedInstance].user.userInfo.ids succes:^(NSDictionary *resultDictionary) {
                    [MBProgressHUD showAndHideWithMessage:@"您已获取到当前订单！" forHUD:nil];
                    [self buttonSelectedIndex:0];
                } failed:^(NSInteger errorCode, NSString *errorMessage) {
                    [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
                }];
                
            }else if ([@"7" isEqualToString:order.type])
            {   [orderView dismiss];
                [MBProgressHUD showAndHideWithMessage:@"订单已被取消!" forHUD:nil];
                [self buttonSelectedIndex:0];
            }else if([@"2" isEqualToString:order.type]){
                [orderView dismiss];
                if (orderView.buttonType==1) {
                    [OrderModel driverDenyOrderById:order.ids driver:[GlobalData sharedInstance].user.userInfo.ids succes:^(NSDictionary *resultDictionary) {
                        [MBProgressHUD showAndHideWithMessage:@"您已拒绝请求！" forHUD:nil];
                    } failed:^(NSInteger errorCode, NSString *errorMessage) {
                        [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
                    }];
                }
            }else{
                [orderView dismiss];
            }
            
        }else if([order.oType integerValue]==2){
            NotificationModel *order = orderView.model;
            if ([order.oType integerValue]==1) {
            
            }
        }
        [orderView dismiss];
        [_dataArray removeObject:orderView];
        NSLog(@"_dataArray:%ld",(long)_dataArray.count);
    }else if([sender isKindOfClass:[NoticeViewCommon class]]){
        NoticeViewCommon *orderView = (NoticeViewCommon*)sender;
        NotificationModel *order = orderView.model;
        if ([order.oType integerValue]==1) {
            
        }
        [orderView dismiss];
        [_dataArray removeObject:orderView];
         NSLog(@"_dataArray:%ld",(long)_dataArray.count);
    }else if([sender isKindOfClass:[NoticeBusView class]]){
//        NoticeBusView *orderView = (NoticeBusView*)sender;
//        NotificationModel *order = orderView.model;
//        if ([order.oType integerValue]==1) {
//            
//        }
//        [orderView dismiss];
    }else if([sender isKindOfClass:[UIButton class]]){
        NSInteger tag = ((UIButton*)sender).tag;
        if (tag==1) {
            [poolView removeFromSuperview];
            [OrderModel driverAcceptOrder:model.ids driverId:[GlobalData sharedInstance].user.userInfo.ids succes:^(NSDictionary *resultDictionary) {
                [MBProgressHUD showAndHideWithMessage:@"接单成功" forHUD:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTICE_NEED_CHANGE_MYORDER" object:nil];
                [self reloadData];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_NEED_REDBALL object:nil];
                
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
            }];
        }else if (tag==2) {
            [poolView removeFromSuperview];
        }
    }
}

- (void) orderNotice:(NSNotification*)notification
{
    NotificationModel *order = [[NotificationModel alloc] initWithDictionary:notification.userInfo error:nil];
    NSLog(@"NotificationModel:%@",notification.userInfo);
    NSLog(@"%@",order.type);
    if (order && ![order isTimeout]) {
        if ([@"12" isEqualToString:order.type]) {
            NoticeBusView *noticView = [[NoticeBusView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            noticView.delegate = self;
            [noticView setModel:order];
            [self.view addSubview:noticView];
            [noticView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view);
                make.left.equalTo(self.view);
                make.right.equalTo(self.view);
                make.bottom.equalTo(self.view);
            }];
        }else if ([@"18" isEqualToString:order.type]) {
            [OrderModel fetchOrderListByUserId:[GlobalData sharedInstance].user.userInfo.ids fristId:@"1" types:@"2" page:1 succes:^(NSArray *result,int pageCount,int recordCount) {
                NSLog(@"%@",result);
                if (result) {
                    model= [[OrderModel alloc]initWithDictionary:result[0] error:nil];
                    poolView =[[CarPoolingView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                    [poolView setModel:model];
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
                
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                NSLog(@"errorMessage:%@",errorMessage);
            }];
//            CarPoolingView *poolView =[[CarPoolingView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//            OrderModel *orderMod = [[OrderModel alloc]init];
//            orderMod.elocation = [notification.userInfo objectForKey:@"eLocation"];
//            orderMod.lineElat = [notification.userInfo objectForKey:@"eLatitude"];
//            orderMod.ids = [notification.userInfo objectForKey:@"id"];
//            orderMod.state = [notification.userInfo objectForKey:@"state"];
//            orderMod.lineElong = [notification.userInfo objectForKey:@"eLongitude"];
//            orderMod.slongitude = [notification.userInfo objectForKey:@"sLongitude"];
//            orderMod.slocation = [notification.userInfo objectForKey:@"sLocation"];
//            orderMod.elatitude = [notification.userInfo objectForKey:@"eLatitude"];
//            orderMod.type = [notification.userInfo objectForKey:@"type"];
//            orderMod.otherFee = [notification.userInfo objectForKey:@"otherFee"];
//            orderMod.otherFee = [notification.userInfo objectForKey:@"otherFee"];
//
//            
//            
//            [poolView setModel:orderMod];
//            [poolView setDelegate:self];
//            UIWindow *windows = AppDelegateInstance().window;
//            [windows addSubview:poolView];
//            
//            [poolView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(windows);
//                make.left.equalTo(windows);
//                make.right.equalTo(windows);
//                make.bottom.equalTo(windows);
//            }];
            
            
        }else if ([@"1" isEqualToString:order.oType]) {
            switch ([order.type integerValue]) {
                case 1:
                {
                    NoticeSpecialView *noticeView = [[NoticeSpecialView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                    noticeView.delegate = self;
                    noticeView.bizType=@"0";
                    [noticeView setModel:order];
                    [self.view addSubview:noticeView];
                    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(self.view);
                        make.left.equalTo(self.view);
                        make.right.equalTo(self.view);
                        make.bottom.equalTo(self.view);
                    }];
                    [_dataArray addObject:noticeView];
                }
                    break;
                case 2:
                {
                    [_currentController reloadData];
                }break;
                case 7:
                {
                    NoticeViewCommon *noticeView = [[NoticeViewCommon alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                    noticeView.delegate = self;
                    [noticeView setModel:order];
                    [self.view addSubview:noticeView];
                    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(self.view);
                        make.left.equalTo(self.view);
                        make.right.equalTo(self.view);
                        make.bottom.equalTo(self.view);
                    }];
                    [_dataArray addObject:noticeView];
                }break;
                case 4:
                {
                    
                }break;
                case 20:
                {
                    [self showAlertMessage:@"暂无业务处理!"];
                }break;
                default:
                    break;
            }
            if (_currentController) {
                [_currentController reloadData];
            }
        }else if([@"2" isEqualToString:order.oType]){
            switch ([order.type integerValue])
            {
                case 7:
                    [self showCommNotice:order];
                    break;
                case 20:
                {
                    [self showAlertMessage:@"暂无业务处理!"];
                }break;
                    default:
                    break;
            }
            
            if (_currentController) {
                [_currentController reloadData];
            }
        }else if([@"3" isEqualToString:order.oType]){
            switch ([order.type integerValue])
            {
                case 7:
                    [self showCommNotice:order];
                    break;
                case 20:
                {
                    [self showAlertMessage:@"暂无业务处理!"];
                }break;
                default:
                    break;
            }
            if (_currentController) {
                [_currentController reloadData];
            }
        }else if([@"4" isEqualToString:order.oType]){
            if ([@"12" isEqualToString:order.type]) {
                NoticeBusView *noticView = [[NoticeBusView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                noticView.delegate = self;
                [noticView setModel:order];
                [self.view addSubview:noticView];
                [noticView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view);
                    make.left.equalTo(self.view);
                    make.right.equalTo(self.view);
                    make.bottom.equalTo(self.view);
                }];
            }else if ([@"17" isEqualToString:order.type]) {
                NoticeBusCommonView *noticeView = [[NoticeBusCommonView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                noticeView.delegate = self;
                [noticeView setModel:order];
                [self.view addSubview:noticeView];
                [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view);
                    make.left.equalTo(self.view);
                    make.right.equalTo(self.view);
                    make.bottom.equalTo(self.view);
                }];
            }else if([@"20" isEqualToString:order.type]){
            
                    [self showAlertMessage:@"暂无业务处理!"];
            
            }
            if (_currentController) {
                [_currentController reloadData];
            }
        }
    }
}

- (void) fetchOrderNumber
{
   
}

- (void) buttonSelected:(UIView*)view Index:(NSInteger)index
{
    if([view isKindOfClass:[NoticeBusView class]]){
        NoticeBusView *orderView = (NoticeBusView*)view;
        NotificationModel *order = orderView.model;
        if (index==1) {
            [[GlobalData sharedInstance].fastBusDict setObject:[OrderModel convertFrom:order] forKey:order.phoneNo];
            [orderView dismiss];
            [OrderModel dConfirmPreByOrderId:order.ids driver:[GlobalData sharedInstance].user.userInfo.ids succes:^(NSDictionary *resultDictionary) {
                [MBProgressHUD showAndHideWithMessage:@"您接受请求！" forHUD:nil];
            } failed:^(NSInteger errorCode, NSString *errorMessage) {
                [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
            }];
            if ([_currentController isKindOfClass:[TripCataController class]]) {
                order.oType = @"4";
                ((TripCataController*)_currentController).notice_model = order;
            }
            [self buttonSelectedIndex:0];
        }else if(index ==2){
            [orderView dismiss];
            if (orderView.buttonType==0) {
                [OrderModel dDenyPreByOrderId:order.ids driver:[GlobalData sharedInstance].user.userInfo.ids succes:^(NSDictionary *resultDictionary) {
                    [MBProgressHUD showAndHideWithMessage:@"您已拒绝请求！" forHUD:nil];
                } failed:^(NSInteger errorCode, NSString *errorMessage) {
                    [MBProgressHUD showAndHideWithMessage:errorMessage forHUD:nil];
                }];
            }
        }
        [orderView dismiss];
    }else if([view isKindOfClass:[NoticeBusCommonView class]]){
        NoticeBusCommonView *orderView = (NoticeBusCommonView*)view;
        if (index==1 && orderView.model.ids) {
            
//            __weak __typeof(&*self) weakSelf = self;
            NSMutableArray *temp = [NSMutableArray array];
            [[GlobalData sharedInstance].fastBusDict enumerateKeysAndObjectsUsingBlock:^(id key, OrderModel *obj, BOOL *stop) {
                NSLog(@"%@ %@",key,obj);
                if ([obj.ids isEqualToString:orderView.model.ids]) {
                    [temp addObject:key];
                }
            }];
            
            if ([temp count]>0) {
                [[GlobalData sharedInstance].fastBusDict removeObjectForKey:[temp lastObject]];
            }
            [self buttonSelectedIndex:0];
        }
        [orderView dismiss];
    }
}

- (void) showCommNotice:(NotificationModel*)order
{
    NoticeViewCommon *noticeView = [[NoticeViewCommon alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    noticeView.delegate = self;
    [noticeView setModel:order];
    [self.view addSubview:noticeView];
    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [_dataArray addObject:noticeView];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void) showAlertMessage:(NSString*)msg
{
    [self showAlertMessage:msg withTitle:@"温馨提示"];
}

- (void) showAlertMessage:(NSString*)msg withTitle:(NSString*)title
{
    [self showAlertMessage:msg withTitle:title bOne:@"知道了" bTwo:nil withHandler:nil];
}

- (void)showAlertMessage:(NSString*)msg withTitle:(NSString*)title bOne:(NSString*)btn_one bTwo:(NSString*)btn_two withHandler:(clickHandle)handler
{
    if ((btn_one==nil && btn_two ==nil)||(btn_one&& btn_two ==nil)) {
        if (handler) {
            [JCAlertView showOneButtonWithTitle:title Message:msg ButtonType:JCAlertViewButtonTypeWarn ButtonTitle:btn_one Click:handler];
        }else{
            [JCAlertView showOneButtonWithTitle:title Message:msg ButtonType:JCAlertViewButtonTypeWarn ButtonTitle:btn_two Click:^{
                
            }];
        }
    }else if(btn_one && btn_two){
        [JCAlertView showTwoButtonsWithTitle:title Message:msg ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:btn_one Click:nil ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:btn_two Click:handler];
    }
    
}

- (void) checkVersion
{
    [AppVersionModel checkAppVersionWithSucess:^(NSDictionary *resultDictionary) {
        NSLog(@"checkVersion resultDictionary:%@",resultDictionary);
        if ([[[resultDictionary objectForKey:@"data"] objectForKey:@"newVersoin"] intValue] != 0) {
            AppVersionModel *model = [[AppVersionModel alloc] initWithDictionary:resultDictionary[@"data"] error:nil];
            [self showAlertMessage:@"升级提示" withTitle:model.descriptions bOne:@"稍后升级" bTwo:@"马上升级" withHandler:^{
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1155985024"]];
            }];
        }
    } withFail:^(NSInteger errorCode, NSString *errorMessage) {
        NSLog(@"errorMessage:%@",errorMessage);
    }];
}
@end
