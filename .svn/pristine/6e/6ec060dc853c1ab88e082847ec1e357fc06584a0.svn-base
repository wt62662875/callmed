//
//  TripFourController.m
//  callmec
//
//  Created by sam on 16/7/7.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "TripFourController.h"
#import "OrderViewCell.h"
#import "OrderModel.h"

#import "GoodsCarListController.h"
#import "GoodsCarOrderController.h"

@interface TripFourController()<CallBackDelegate>

@property (nonatomic,strong) UIButton *buttonOrder;
@property (nonatomic,strong) UIButton *buttonList;
@property (nonatomic,strong) UIViewController *currentController;

@end

@implementation TripFourController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void) initView
{
    _buttonOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonOrder setTitle:@"我的订单" forState:UIControlStateNormal];
    [_buttonOrder setTitleColor:RGBHex(g_green) forState:UIControlStateNormal];
    [_buttonOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_buttonOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_buttonOrder setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_buttonOrder setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_green)] forState:UIControlStateSelected];
    [_buttonOrder setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_green)] forState:UIControlStateHighlighted];
    [_buttonOrder.layer setCornerRadius:5];
    [_buttonOrder.layer setMasksToBounds:YES];
    [_buttonOrder.layer setBorderWidth:1];
    [_buttonOrder.layer setBorderColor:RGBHex(g_green).CGColor];
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
    [_buttonList.layer setBorderColor:RGBHex(g_green).CGColor];
    [_buttonList setTitle:@"选择货源" forState:UIControlStateNormal];
    [_buttonList setTitleColor:RGBHex(g_green) forState:UIControlStateNormal];
    [_buttonList setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_buttonList setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_buttonList setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_buttonList setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_green)] forState:UIControlStateSelected];
    [_buttonList setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_green)] forState:UIControlStateHighlighted];
    [_buttonList addTarget:self action:@selector(buttonSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonList.layer setCornerRadius:5];
    [_buttonList.layer setMasksToBounds:YES];
    [_buttonList.layer setBorderWidth:1];
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
    [self addChildViewController:[[GoodsCarOrderController alloc] init]];
    [self addChildViewController:[[GoodsCarListController alloc] init]];
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
    if (_currentController) {
        if ([_currentController isKindOfClass:[BaseController class]]) {
            [((BaseController*)_currentController) removeViewFromParent];
        }
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
@end

