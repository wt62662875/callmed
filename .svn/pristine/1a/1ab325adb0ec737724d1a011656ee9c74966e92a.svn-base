//
//  UserCenterHeaderCell.m
//  callmed
//
//  Created by sam on 16/7/20.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "UserCenterHeaderCell.h"
#import "VerticalTitleLabel.h"

@interface UserCenterHeaderCell()
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *onlineTimeLabel;
@property (nonatomic,strong) UILabel *serviceTimesLabel;
@property (nonatomic,strong) VerticalTitleLabel *todayMoneyLabel;            //今天成交率
@end

@implementation UserCenterHeaderCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) initView
{
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wenli"]];
    [self addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self setBackgroundColor:RGBHex(g_green)];
    _moneyLabel = [[UILabel alloc] init];
    [_moneyLabel setText:@"99999.00"];
    [_moneyLabel setTextColor:[UIColor whiteColor]];
    [_moneyLabel setFont:[UIFont systemFontOfSize:25]];
    [self addSubview:_moneyLabel];
 
    
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setText:@"账户余额"];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setAlpha:1.0];
    [_titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.bottom.equalTo(_moneyLabel.mas_top).offset(-5);
        make.left.equalTo(self).offset(15);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.mas_centerY);
    }];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.height.mas_equalTo(20);
        make.top.equalTo(_titleLabel.mas_bottom);
    }];
    
    _onlineTimeLabel = [[UILabel alloc] init];
    [_onlineTimeLabel setText:@"在线时长:  300小时"];
    [_onlineTimeLabel setTextColor:[UIColor whiteColor]];
    [_onlineTimeLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:_onlineTimeLabel];
    [_onlineTimeLabel setHidden:YES];
    [_onlineTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyLabel.mas_bottom).offset(5);
        make.left.equalTo(self).offset(15);
        make.width.mas_equalTo(100);
    }];
    
    _serviceTimesLabel = [[UILabel alloc] init];
    [_serviceTimesLabel setText:@"接单数: 300"];
    [_serviceTimesLabel setHidden:YES];
    [_serviceTimesLabel setTextColor:[UIColor whiteColor]];
    [_serviceTimesLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:_serviceTimesLabel];
    [_serviceTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_moneyLabel.mas_bottom).offset(5);
        make.left.equalTo(_onlineTimeLabel.mas_right).offset(15);
        make.width.mas_equalTo(100);
    }];
    
    //onlineTimeLabel
    
    //今天收入
    _todayMoneyLabel =[[VerticalTitleLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_todayMoneyLabel setTitle:@"今日收入"];
    [_todayMoneyLabel setContent:@"+100.00"];
    [_todayMoneyLabel setTitleAlpha:0.8];
    [_todayMoneyLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_todayMoneyLabel setTitleColor:[UIColor whiteColor]];
    [_todayMoneyLabel setContentColor:[UIColor whiteColor]];
    [_todayMoneyLabel setContentFont:[UIFont systemFontOfSize:13]];
    [_todayMoneyLabel setPaddingTop:0];
    [_todayMoneyLabel setTitleAlignment:NSTextAlignmentLeft];
    [_todayMoneyLabel setContentAlignment:NSTextAlignmentLeft];
    [_todayMoneyLabel setHidden:YES];
    [self addSubview:_todayMoneyLabel];
    [_todayMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_moneyLabel.mas_right);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(40);
    }];
}

- (void) setData:(NSDictionary *)data
{
    if (!data) {
        return;
    }
    _data= data;
    [_moneyLabel setText:[NSString stringWithFormat:@"%@",_data[@"cmmoney"]]];
    [_onlineTimeLabel setText:[NSString stringWithFormat:@"在线时长:%@",_data[@"onlineTime"]]];//@"在线时长:  300小时"
    [_serviceTimesLabel setText:[NSString stringWithFormat:@"接单数:%@",_data[@"serviceNum"]]];
}
@end
