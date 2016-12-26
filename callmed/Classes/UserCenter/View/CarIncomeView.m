//
//  CarIncomeView.m
//  callmed
//
//  Created by sam on 16/8/18.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CarIncomeView.h"

@interface CarIncomeView()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *orderLabel;
@property (nonatomic,strong) UILabel *incomeLabel;

@end


@implementation CarIncomeView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView
{
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setFont:[UIFont systemFontOfSize:17]];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.layer.cornerRadius = 5;
    _titleLabel.layer.masksToBounds = YES;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(20);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(20);
        make.width.offset(50);
        make.height.offset(30);
    }];
    
    _orderLabel = [[UILabel alloc] init];
    [_orderLabel setText:@"订单:"];
    [_orderLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:_orderLabel];
    [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
    
    _incomeLabel = [[UILabel alloc] init];
    [_incomeLabel setText:@"收入:"];
    [_incomeLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:_incomeLabel];
    [_incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    if ([title isEqualToString:@"专车"]) {
        _titleLabel.backgroundColor = RGBHex(g_yellow);
    }else{
        _titleLabel.backgroundColor = RGBHex(g_blue);
    }
    [_titleLabel setText:_title];
}

- (void) setNumber:(NSString *)number
{
    _number = number;
    NSString *tvalue = [NSString stringWithFormat:@"订单:%@",_number];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:tvalue];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[tvalue rangeOfString:@"订单:"]];
    if ([_title isEqualToString:@"专车"]) {
        [text addAttribute:NSForegroundColorAttributeName value:RGBHex(g_yellow) range:[tvalue rangeOfString:_number]];
    }else{
        [text addAttribute:NSForegroundColorAttributeName value:RGBHex(g_blue) range:[tvalue rangeOfString:_number]];
    }
    [_orderLabel setAttributedText:text];
}

- (void) setMoney:(NSString *)money
{
    _money = money;
    NSString *tvalue = [NSString stringWithFormat:@"收入:%@",_money];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:tvalue];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[tvalue rangeOfString:@"收入:"]];
    if ([_title isEqualToString:@"专车"]) {
        [text addAttribute:NSForegroundColorAttributeName value:RGBHex(g_yellow) range:[tvalue rangeOfString:_money]];
    }else{
        [text addAttribute:NSForegroundColorAttributeName value:RGBHex(g_blue) range:[tvalue rangeOfString:_money]];
    }    [_incomeLabel setAttributedText:text];
}

@end
