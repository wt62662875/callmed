//
//  TripTwoController.m
//  callmec
//
//  Created by sam on 16/7/7.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "TripTwoController.h"
#import "CarPoolingListController.h"
#import "CarPoolingOrderController.h"

@interface TripTwoController()<CallBackDelegate>

@property (nonatomic,strong) UIButton *buttonOrder;
@property (nonatomic,strong) UIButton *buttonList;
@property (nonatomic,strong) UIViewController *currentController;
@end

@implementation TripTwoController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initData];
    //NOTICE_NEED_CHANGE_MYORDER
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOrderList:) name:@"NOTICE_NEED_CHANGE_MYORDER" object:nil];
}

- (void) initView
{
    _buttonOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonOrder setTitle:@"我的订单" forState:UIControlStateNormal];
    [_buttonOrder setTitleColor:RGB(129, 129, 129) forState:UIControlStateNormal];
    [_buttonOrder setTitleColor:RGBHex(g_blue) forState:UIControlStateSelected];
    [_buttonOrder setTitleColor:RGBHex(g_blue) forState:UIControlStateHighlighted];
    [_buttonOrder setImage:[UIImage imageNamed:@"xingzhuang21"] forState:UIControlStateNormal];
    [_buttonOrder setImage:[UIImage imageNamed:@"xingzhuang12"] forState:UIControlStateSelected];
    [_buttonOrder setSelected:YES];
    [_buttonOrder setTag:0];
    [_buttonOrder addTarget:self action:@selector(buttonSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_buttonOrder];
    [_buttonOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view.mas_centerX).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    _buttonList = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonList setTitle:@"选择快车" forState:UIControlStateNormal];
    [_buttonList setTitleColor:RGB(129, 129, 129) forState:UIControlStateNormal];
    [_buttonList setTitleColor:RGBHex(g_blue) forState:UIControlStateSelected];
    [_buttonList setTitleColor:RGBHex(g_blue) forState:UIControlStateHighlighted];
    [_buttonList setImage:[UIImage imageNamed:@"hei10"] forState:UIControlStateNormal];
    [_buttonList setImage:[UIImage imageNamed:@"lan10"] forState:UIControlStateSelected];
    [_buttonList addTarget:self action:@selector(buttonSwitch:) forControlEvents:UIControlEventTouchUpInside];

    [_buttonList setTag:1];
    [self.view addSubview:_buttonList];
    [_buttonList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(-10);
        make.left.equalTo(self.view.mas_centerX).offset(10);
        make.height.mas_equalTo(40);
    }];
    
}

- (void) initData
{
    [self addChildViewController:[[CarPoolingOrderController alloc] init]];
    [self addChildViewController:[[CarPoolingListController alloc] init]];
    [self changeIndexView:0];
}

- (void)buttonSwitch:(UIButton*)button
{
    NSInteger tag = button.tag;
    if (tag==0) {
        [_buttonOrder setSelected:YES];
        [_buttonList setSelected:NO];
    }else{
        [_buttonOrder setSelected:NO];
        [_buttonList setSelected:YES];
    }
    [self changeIndexView:tag];
    
}

- (void) changeIndexView:(NSInteger)tag
{
    if (!_currentController) {
        [_currentController.view removeFromSuperview];
    }
    _currentController = self.childViewControllers[tag];
    
    [self.view addSubview:_currentController.view];
    
    [_currentController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buttonOrder.mas_bottom).offset(5);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    if ([_currentController isKindOfClass:[BaseController class]]) {
        [((BaseController*)_currentController) reloadData];
    }
}

#pragma mark -CallBackDelegate

- (void) callback:(id)sender
{

}

- (void) reloadData
{
    if (_currentController && [_currentController isKindOfClass:[BaseController class]]) {
        [((BaseController*)_currentController) reloadData];
    }
}

- (void) changeOrderList:(NSNotification*)notice
{
    [self buttonSwitch:self.buttonOrder];
}
@end
