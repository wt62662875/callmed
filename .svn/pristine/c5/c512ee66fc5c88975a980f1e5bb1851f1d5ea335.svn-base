//
//  SwitchButton.m
//  callmed
//
//  Created by sam on 16/8/25.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "SwitchButton.h"

@interface SwitchButton()

@property (nonatomic,strong) UIButton *buttonLeft;
@property (nonatomic,strong) UIButton *buttonMidle;
@property (nonatomic,strong) UIButton *buttonRight;

@end

@implementation SwitchButton

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super  initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView
{
    _buttonMidle = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonMidle.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_buttonMidle.layer setBorderColor:RGBHex(g_assit_f6).CGColor];
    
    [_buttonMidle.layer setBorderWidth:1];
    [_buttonMidle setTitle:@"时间早" forState:UIControlStateNormal];
    [_buttonMidle setTitleColor:RGBHex(g_gray_cc) forState:UIControlStateNormal];
    [_buttonMidle setTitleColor:RGBHex(g_m_c) forState:UIControlStateSelected];
    [_buttonMidle setTitleColor:RGBHex(g_m_c) forState:UIControlStateHighlighted];
    [_buttonMidle addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonMidle];
    
    _buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonLeft.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_buttonLeft setSelected:YES];
    [_buttonLeft.layer setBorderColor:RGBHex(g_assit_f6).CGColor];
    [_buttonLeft setBackgroundColor:[UIColor whiteColor]];
    [_buttonLeft.layer setBorderWidth:1];
    [_buttonLeft setTitle:@"默认排序" forState:UIControlStateNormal];
    [_buttonLeft setTitleColor:RGBHex(g_gray_cc) forState:UIControlStateNormal];
    [_buttonLeft setTitleColor:RGBHex(g_blue) forState:UIControlStateSelected];
    [_buttonLeft setTitleColor:RGBHex(g_m_c) forState:UIControlStateHighlighted];
    [_buttonLeft addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonLeft];
    
    [_buttonLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(-1);
        make.bottom.equalTo(self);
        make.width.equalTo(self).dividedBy(3);
    }];
    
    
    
    [_buttonMidle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.width.equalTo(self).dividedBy(2.5);
    }];
    
    _buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonRight setBackgroundColor:[UIColor whiteColor]];
    [_buttonRight.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_buttonRight.layer setBorderColor:RGBHex(g_assit_f6).CGColor];
    [_buttonRight.layer setBorderWidth:1];
    [_buttonRight setTitle:@"距离近" forState:UIControlStateNormal];
    [_buttonRight setTitleColor:RGBHex(g_gray_cc) forState:UIControlStateNormal];
    [_buttonRight setTitleColor:RGBHex(g_m_c) forState:UIControlStateSelected];
    [_buttonRight setTitleColor:RGBHex(g_m_c) forState:UIControlStateHighlighted];
    [_buttonRight addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonRight];
    
    [_buttonRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self).offset(1);
        make.bottom.equalTo(self);
        make.width.equalTo(self).dividedBy(3);
    }];
}

- (void) setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    if (_selectedIndex==0) {
        [_buttonLeft setSelected:YES];
        [_buttonMidle setSelected:NO];
        [_buttonRight setSelected:NO];
    }else if (_selectedIndex==1) {
        [_buttonLeft setSelected:NO];
        [_buttonMidle setSelected:YES];
        [_buttonRight setSelected:NO];
    }else if (_selectedIndex==2) {
        [_buttonLeft setSelected:NO];
        [_buttonMidle setSelected:NO];
        [_buttonRight setSelected:YES];
    }
}

- (void) buttonTarget:(UIButton*)button
{
    if (_buttonLeft == button) {
        _selectedIndex = 0;
    }else if (_buttonMidle == button){
        _selectedIndex = 1;
    }else if (_buttonRight == button){
        _selectedIndex = 2;
    }
    [self setSelectedIndex:_selectedIndex];
    if (_delegate &&[_delegate respondsToSelector:@selector(buttonSelectedIndex:)])
    {
        [_delegate buttonSelectedIndex:_selectedIndex];
    }
}

@end
