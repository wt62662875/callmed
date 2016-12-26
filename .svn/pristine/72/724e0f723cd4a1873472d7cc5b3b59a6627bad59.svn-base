//
//  OrderViewCell.m
//  callmec
//
//  Created by sam on 16/7/7.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "OrderViewCell.h"
#import "OrderModel.h"

@interface OrderViewCell()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIView *grayLine;
@property (nonatomic,strong) UIView *upLine;
@property (nonatomic,strong) UIView *container;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UIButton *buttonStart;
@property (nonatomic,strong) UIButton *buttonEnd;
@property (nonatomic,strong) UIButton *buttonSubmit;

@end

@implementation OrderViewCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_timelines_1"]];
    [self addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.height.mas_equalTo(30);
    }];
    
    _upLine = [[UIView alloc] init];
    _upLine.backgroundColor =RGBHex(g_gray);
    [self addSubview:_upLine];
    [_upLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.equalTo(self);
        make.centerX.equalTo(_iconView);
        make.bottom.equalTo(_iconView.mas_top);
    }];
    
    _grayLine= [[UIView alloc] init];
    _grayLine.backgroundColor =RGBHex(g_gray);
    
    [self addSubview:_grayLine];
    [_grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.equalTo(_iconView.mas_bottom);
        make.centerX.equalTo(_iconView);
        make.bottom.equalTo(self);
    }];
    _timeLabel = [[UILabel alloc] init];
    [self addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(_iconView.mas_right).offset(10);
        make.width.mas_equalTo(160);
        make.height.equalTo(_iconView);
    }];
    [_timeLabel setText:@"06月03日 23:00"];
    [_timeLabel setFont:[UIFont systemFontOfSize:15]];
    _container = [[UIView alloc] init];
    _container.backgroundColor= RGBHex(g_gray);
    _container.layer.masksToBounds= YES;
    _container.layer.cornerRadius = 5.0;
    
    [self addSubview:_container];
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(10);
        make.left.equalTo(_iconView.mas_right).offset(10);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self);
    }];
    
    _moneyLabel =[[UILabel alloc] init];
    [_container addSubview:_moneyLabel];
    [_moneyLabel setText:@"15元"];
    [_moneyLabel setTextAlignment:NSTextAlignmentCenter];
    [_moneyLabel setTextColor:RGBHex(g_red)];
    [_moneyLabel setFont:[UIFont systemFontOfSize:15]];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_container).offset(10);
        make.centerY.equalTo(_container);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    _buttonStart =[UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonStart setTitle:@"起始地点" forState:UIControlStateNormal];
    [_buttonStart.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_buttonStart setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [_buttonStart setImage:[UIImage imageNamed:@"icon_qidian2_dot_2"] forState:UIControlStateNormal];
    [_container addSubview:_buttonStart];
    [_buttonStart setBackgroundColor:[UIColor redColor]];
    [_buttonStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_moneyLabel.mas_right).offset(5);
        make.top.equalTo(_container).offset(15);
    }];
    
    _buttonEnd =[UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonEnd setTitle:@"终点地点" forState:UIControlStateNormal];
    [_buttonEnd.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_buttonEnd setImage:[UIImage imageNamed:@"icon_qidian_dot_1"] forState:UIControlStateNormal];
    [_buttonEnd setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [_container addSubview:_buttonEnd];
    
    [_buttonEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_moneyLabel.mas_right).offset(5);
        make.top.equalTo(_buttonStart.mas_bottom).offset(10);
    }];
    
    _buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonSubmit.layer.cornerRadius = 5.0;
    _buttonSubmit.layer.masksToBounds = YES;
    [_buttonSubmit setTitle:@"评价司机" forState:UIControlStateNormal];
    [_buttonSubmit setBackgroundColor:RGBHex(g_red)];
    [_buttonSubmit setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_red)] forState:UIControlStateNormal];
    [_buttonSubmit.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_container addSubview:_buttonSubmit];
    
    [_buttonSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_container).offset(-20);
        make.centerY.equalTo(_container);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
    }];
}
- (void) setTopLineHidden:(BOOL)state
{
    [_upLine setHidden:state];
}

- (void) setBottomLineHidden:(BOOL)state
{
    [_grayLine setHidden:state];
}

- (void) setModel:(BaseModel*)model
{
    _model = model;
    
    [_buttonStart setTitle:((OrderModel*)_model).slocation forState:UIControlStateNormal];
    [_buttonEnd setTitle:((OrderModel*)_model).elocation forState:UIControlStateNormal];
    [_moneyLabel setText:((OrderModel*)_model).actFee];
}

@end
