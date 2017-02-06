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
#import "HomeBackView.h"
#import "helpViewController.h"
#import "setUpViewController.h"
#import "carInformationViewController.h"
#import "accountInformationViewController.h"
#import "tripViewController.h"
#import "personalDataViewController.h"
#import <AVFoundation/AVFoundation.h>

#define OPENCENTERX 250.0
#define DIVIDWIDTH 70.0 //OPENCENTERX 对应确认是否打开或关闭的分界线。

@interface HomeController ()<TargetActionDelegate,UIGestureRecognizerDelegate>
{
    CarPoolingView *poolView;
    OrderModel *model;
    CGPoint openPointCenter;
    CGPoint closePointCenter;
    
    CGPoint leftOpenPointCenter;

}

@property (nonatomic,strong) TabBarView *bottomView;
@property (nonatomic,strong) BaseController *currentController;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) HomeBackView *leftView;

@property (nonatomic,strong) UIView *blackView;
@property(nonatomic,strong) AVAudioPlayer *movePlayer ;

/**
 * 动画是否进行e
 */
@property (nonatomic ,assign) BOOL animating;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackView];
    
//    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(outCarJump:) name:@"outCarJump" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openLoginController:) name:NOTICE_NEED_SIGN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderNotice:) name:NOTICE_ORDER_STATE_UPDATE object:nil];
    //[[NSNotificationCenter defaultCenter]  postNotificationName:NOTICE_ORDER_STATE_UPDATE object:payloadMsg];
    NSLog(@"CommonUtility compare:%ld",(long)[CommonUtility compareDateStringToNow:@"2016-09-03 10:00:00" withFormat:nil]);
    [self initData];
    [self initView];

//    [UIView animateWithDuration:3 animations:^{
//        [vvv setFrame:CGRectMake(200, 0, 300, 300)] ;
//    }];
    
    [MBProgressHUD showAndHideWithMessage:@"正在加载数据中....." forHUD:nil];
    
   
}
-(void)initBackView{


//    self.headerView.hidden = YES;
    
    _backView = [[UIView alloc]initWithFrame:self.view.frame];
    [_backView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_backView];
    
    _leftView = [[NSBundle mainBundle] loadNibNamed:@"HomeBackView" owner:self options:nil][0];
    _leftView.delegate = self;
    [_leftView setFrame:CGRectMake(-250, 0,250, kScreenSize.height)];
    _leftView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_leftView];

    [self.headerView removeFromSuperview];
    
    [_backView addSubview:self.headerView];
    [_backView addSubview:self.leftButton];
    [_backView addSubview:self.rightButton];
    [_backView addSubview:self.bottomHeaderLine];
    [_backView addSubview:self.titleLabel];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView);
        make.left.equalTo(_backView);
        make.width.equalTo(_backView);
        make.height.mas_equalTo(KTopbarH);
    }];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(20);
        make.left.equalTo(self.headerView).offset(10);
        make.width.height.mas_equalTo(44);
        make.bottom.equalTo(self.headerView).offset(0);
        
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(20);
        make.right.equalTo(self.headerView).offset(-10);
        make.width.height.mas_equalTo(44);
    }];
    [self.bottomHeaderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView);
        make.bottom.equalTo(self.headerView);
        make.height.mas_equalTo(1);
        make.width.equalTo(self.headerView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(20);
        make.height.mas_equalTo(44);
        make.centerX.equalTo(self.headerView);
    }];
    
    //KVO监听
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self;
    [self.backView addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handleTap:)];
    tapGestureRecognizer.delegate = self;
    [self.backView addGestureRecognizer:tapGestureRecognizer];
    openPointCenter = CGPointMake(self.backView.center.x + OPENCENTERX,
                                  self.backView.center.y);
    leftOpenPointCenter = CGPointMake(self.leftView.center.x + OPENCENTERX, self.leftView.center.y);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //Tip:我们可以通过打印touch.view来看看具体点击的view是具体是什么名称,像点击UITableViewCell时响应的View则是UITableViewCellContentView.
//    NSLog(@"%@",[touch.view class]);
    if ([NSStringFromClass([touch.view class])    isEqualToString:@"UITableViewCellContentView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}
-(void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    float x = self.backView.center.x + translation.x;
    float n = self.leftView.center.x + translation.x;
    
    if (x < self.view.center.x) {
        x = self.view.center.x;
    }
    if (n < -250) {
        n = -250;
    }


    NSLog(@"%f",_leftView.frame.origin.x);
    NSLog(@"%f",_backView.frame.origin.x);
    float alphaFloat = self.view.center.x/x;

    if (!_blackView) {
        _blackView = [[UIView alloc]initWithFrame:_backView.frame];
        _blackView.alpha = 0.0;
        _blackView.backgroundColor = [UIColor blackColor];
        [_backView addSubview:_blackView];
    }
    if (alphaFloat >= 0.5) {
        _blackView.alpha = 1-alphaFloat;
    }else{
        _blackView.alpha = 0.5;
    }
    
    self.backView.center = CGPointMake(x, openPointCenter.y);
    self.leftView.center = CGPointMake(n, leftOpenPointCenter.y);

    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.2
                              delay:0.01
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void)
         {
             if (x > openPointCenter.x -  DIVIDWIDTH) {
                 _blackView.alpha = 0.5;
                 self.backView.center = openPointCenter;
                 self.leftView.center = leftOpenPointCenter;
             }else{
                 _blackView.alpha = 0.0;
                 _blackView = nil;
                 [_blackView removeFromSuperview];
                 self.backView.center = CGPointMake(openPointCenter.x - OPENCENTERX,
                                                    openPointCenter.y);
                 self.leftView.center = CGPointMake(leftOpenPointCenter.x - OPENCENTERX,
                                                    leftOpenPointCenter.y);

             }
             
         }completion:^(BOOL isFinish){
             
         }];
    }
    
    [recognizer setTranslation:CGPointZero inView:self.backView];
}

-(void) handleTap:(UITapGestureRecognizer*) recognizer
{
    [UIView animateWithDuration:0.2
                          delay:0.01
                        options:UIViewAnimationOptionTransitionCurlUp animations:^(void){
                            _blackView.alpha = 0.0;
                            _blackView = nil;
                            [_blackView removeFromSuperview];
                            self.backView.center = CGPointMake(openPointCenter.x - OPENCENTERX,
                                                               openPointCenter.y);
                            self.leftView.center = CGPointMake(leftOpenPointCenter.x - OPENCENTERX,
                                                               leftOpenPointCenter.y);
                        }completion:nil];
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
    [self.headerView setBackgroundColor:[UIColor whiteColor]];
    [self.titleLabel setTextColor:RGBHex(g_red)];
    [self.leftButton setImage:[UIImage imageNamed:@"heiren"] forState:UIControlStateNormal];
//    [self setRightButtonText:@"注销" withFont:[UIFont systemFontOfSize:14]];
//    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.rightButton addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightButton setImage:[UIImage imageNamed:@"heixin"] forState:UIControlStateNormal];
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
    [_bottomView setBackgroundColor:RGBHex(g_red)];
    [_backView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backView);
        make.left.equalTo(_backView);
        make.width.equalTo(_backView);
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
    [_backView addSubview:_currentController.view];
    [_currentController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.left.equalTo(_backView);
        make.right.equalTo(_backView);
    }];
    [self setTitle:_currentController.title];
    if ([GlobalData sharedInstance].user.isLogin) {
        [self.rightButton setHidden:NO];
//        if (index==2) {
//            [self setRightButtonText:@"注销" withFont:[UIFont systemFontOfSize:14]];
//            [self.rightButton setImage:nil forState:UIControlStateNormal];
//        }else{
            [self setRightButtonText:nil withFont:[UIFont systemFontOfSize:14]];
            [self setRightButtonImage:@"heixin"];
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
        if (!_blackView) {
            _blackView = [[UIView alloc]initWithFrame:_backView.frame];
            _blackView.alpha = 0.0;
            _blackView.backgroundColor = [UIColor blackColor];
            [_backView addSubview:_blackView];
        }
        [UIView animateWithDuration:0.2
                              delay:0.01
                            options:UIViewAnimationOptionTransitionCurlUp animations:^(void){
                                _blackView.alpha = 0.5;
                                self.backView.center = openPointCenter;
                                self.leftView.center = leftOpenPointCenter;
                            }completion:nil];
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
            if (orderView.buttonType==6) {
                [orderView dismiss];
                return;
            }
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
        }else if (tag==2 || tag==6) {
            [poolView removeFromSuperview];
        }
        
        personalDataViewController *personalDataVC = [[personalDataViewController alloc]initWithNibName:@"personalDataViewController" bundle:nil];
        helpViewController *helpVC = [[helpViewController alloc]initWithNibName:@"helpViewController" bundle:nil];
        setUpViewController *setUpVC = [[setUpViewController alloc]initWithNibName:@"setUpViewController" bundle:nil];
        carInformationViewController *carInformationVC = [[carInformationViewController alloc]initWithNibName:@"carInformationViewController" bundle:nil];
        accountInformationViewController *accountInformationVC = [[accountInformationViewController alloc]initWithNibName:@"accountInformationViewController" bundle:nil];
        tripViewController *tripVC = [[tripViewController alloc]initWithNibName:@"tripViewController" bundle:nil];
        switch (tag) {
            case 10:             //头像
                [self.navigationController pushViewController:personalDataVC animated:YES];
                break;
            case 11:             //行程
                [self.navigationController pushViewController:tripVC animated:YES];
                break;
            case 12:             //账户信息
                [self.navigationController pushViewController:accountInformationVC animated:YES];
                break;
            case 13:             //车辆信息
                [self.navigationController pushViewController:carInformationVC animated:YES];
                break;
            case 14:             //设置
                [self.navigationController pushViewController:setUpVC animated:YES];
                break;
            case 15:             //帮助
                [self.navigationController pushViewController:helpVC animated:YES];
                break;
            default:
                break;
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
            [_backView addSubview:noticView];
            [noticView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_backView);
                make.left.equalTo(_backView);
                make.right.equalTo(_backView);
                make.bottom.equalTo(_backView);
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
                    NSString *tmp= [[NSBundle mainBundle] pathForResource:@"newOrder" ofType:@"mp3"];
                    NSURL *moveMP3=[NSURL fileURLWithPath:tmp];
                    NSError *err=nil;
                    self.movePlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:moveMP3 error:&err];
                    self.movePlayer.volume=1.0;
                    [self.movePlayer prepareToPlay];
                    [self.movePlayer play];
                    NoticeSpecialView *noticeView = [[NoticeSpecialView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];

                    noticeView.delegate = self;
                    noticeView.bizType=@"0";
                    [noticeView setModel:order];
                    [_backView addSubview:noticeView];
                    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_backView);
                        make.left.equalTo(_backView);
                        make.right.equalTo(_backView);
                        make.bottom.equalTo(_backView);
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
                    NSString *tmp= [[NSBundle mainBundle] pathForResource:@"cClose" ofType:@"wav"];
                    NSURL *moveMP3=[NSURL fileURLWithPath:tmp];
                    NSError *err=nil;
                    self.movePlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:moveMP3 error:&err];
                    self.movePlayer.volume=1.0;
                    [self.movePlayer prepareToPlay];
                    [self.movePlayer play];

                    NoticeViewCommon *noticeView = [[NoticeViewCommon alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                    noticeView.delegate = self;
                    [noticeView setModel:order];
                    [_backView addSubview:noticeView];
                    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(_backView);
                        make.left.equalTo(_backView);
                        make.right.equalTo(_backView);
                        make.bottom.equalTo(_backView);
                    }];
                    [_dataArray addObject:noticeView];
                }break;
                case 4:
                {
                    
                }break;
                case 20:
                {
                    NSString *tmp= [[NSBundle mainBundle] pathForResource:@"newMessage" ofType:@"m4r"];
                    NSURL *moveMP3=[NSURL fileURLWithPath:tmp];
                    NSError *err=nil;
                    self.movePlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:moveMP3 error:&err];
                    self.movePlayer.volume=1.0;
                    [self.movePlayer prepareToPlay];
                    [self.movePlayer play];

                    [self showAlertMessage:@"暂无业务处理!"];
                }break;
                default:
                    break;
            }
            if (_currentController) {
                [_currentController reloadData];
            }
        }else if([@"2" isEqualToString:order.oType]){
            NSString *tmp= [[NSBundle mainBundle] pathForResource:@"cClose" ofType:@"wav"];
            NSURL *moveMP3=[NSURL fileURLWithPath:tmp];
            NSError *err=nil;
            
            NSString *tmp2= [[NSBundle mainBundle] pathForResource:@"newMessage" ofType:@"m4r"];
            NSURL *moveMP32=[NSURL fileURLWithPath:tmp2];
            

            switch ([order.type integerValue])
            {
                case 7:
                    self.movePlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:moveMP3 error:&err];
                    self.movePlayer.volume=1.0;
                    [self.movePlayer prepareToPlay];
                    [self.movePlayer play];

                    [self showCommNotice:order];
                    break;
                case 20:
                {
                    self.movePlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:moveMP32 error:&err];
                    self.movePlayer.volume=1.0;
                    [self.movePlayer prepareToPlay];
                    [self.movePlayer play];
                    
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
                [_backView addSubview:noticView];
                [noticView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_backView);
                    make.left.equalTo(_backView);
                    make.right.equalTo(_backView);
                    make.bottom.equalTo(_backView);
                }];
            }else if ([@"17" isEqualToString:order.type]) {
                NoticeBusCommonView *noticeView = [[NoticeBusCommonView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                noticeView.delegate = self;
                [noticeView setModel:order];
                [_backView addSubview:noticeView];
                [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_backView);
                    make.left.equalTo(_backView);
                    make.right.equalTo(_backView);
                    make.bottom.equalTo(_backView);
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
    [_backView addSubview:noticeView];
    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView);
        make.left.equalTo(_backView);
        make.right.equalTo(_backView);
        make.bottom.equalTo(_backView);
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
-(void)outCarJump:(NSNotification*)aNotification{
    NSString *str = [aNotification object];
    NSLog(@"%@",str);
    [_bottomView setSelectIndex:0];
    [self buttonSelectedIndex:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"outCarJump2" object:str];

}

- (void) checkVersion
{
    [AppVersionModel checkAppVersionWithSucess:^(NSDictionary *resultDictionary) {
        NSLog(@"checkVersion resultDictionary:%@",resultDictionary);
        if ([[[resultDictionary objectForKey:@"data"] objectForKey:@"newVersion"] intValue] != 0) {
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
