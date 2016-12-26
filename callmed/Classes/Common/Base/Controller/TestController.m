//
//  TestController.m
//  callmed
//
//  Created by sam on 16/8/3.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "TestController.h"
#import "NoticeSpecialView.h"
#import "CarPoolingView.h"
#import "BalanceController.h"
#import "NoticeViewCommon.h"
#import "NoticeBusView.h"
#import "NoticeBusCommonView.h"

@interface TestController ()

@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void) initView
{
    NoticeViewCommon *view = [[NoticeViewCommon alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [view setDismissWhenTouchOutside:YES];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void) viewDidAppear:(BOOL)animated
{
//    BalanceController *balance = [[BalanceController alloc] init];
//    [self.navigationController pushViewController:balance animated:YES];
    
    [JCAlertView showOneButtonWithTitle:@"温馨提示" Message:@"暂无业务处理!" ButtonType:JCAlertViewButtonTypeWarn ButtonTitle:@"知道了" Click:^{
        
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
