//
//  IntegrationCell.m
//  callmec
//
//  Created by sam on 16/8/29.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "OrderListCell.h"
#import "OrderListModel.h"
@interface OrderListCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *moneyLabel;

@end

@implementation OrderListCell


- (void) initView
{
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setText:@""];
    [_titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_titleLabel setTextColor:RGBHex(g_black)];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(25);
        make.bottom.equalTo(self.mas_centerY);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    [_timeLabel setFont:[UIFont systemFontOfSize:15]];
    [_timeLabel setTextColor:RGBHex(g_black)];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.mas_centerY);
        make.height.mas_equalTo(25);
    }];
    
    _moneyLabel = [[UILabel alloc] init];
    [_moneyLabel setFont:[UIFont systemFontOfSize:15]];
    [_moneyLabel setTextColor:[UIColor redColor]];
    [self addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(25);
    }];
}

- (void) setModel:(BaseModel *)model
{
    [super setModel:model];
    
    if ([model isKindOfClass:[OrderListModel class]])
    {
        OrderListModel *models = (OrderListModel*)model;
        [_titleLabel setText:models.description?models.descriptions:@""];
        [_timeLabel setText:models.createDate?models.createDate:@""];
        [_moneyLabel setText:[NSString stringWithFormat:@"￥%@",models.incomeCmoney?models.incomeCmoney:@""]];
    }
}

@end
