//
//  DriverOrderCell.m
//  callmed
//
//  Created by sam on 16/7/28.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CarPoolingOrderCell.h"
#import "LeftIconLabel.h"

@interface CarPoolingOrderCell()

@property (nonatomic,strong) LeftIconLabel *timeLabel;
@property (nonatomic,strong) LeftIconLabel *routeLabel;
@property (nonatomic,strong) LeftIconLabel *upLocationLabel;
@property (nonatomic,strong) LeftIconLabel *endLabel;
@property (nonatomic,strong) LeftIconLabel *peopleLabel;
@property (nonatomic,strong) LeftIconLabel *bakLabel;
@property (nonatomic,strong) LeftIconLabel *fee;


@property (nonatomic,strong) UIButton *buttonStatus;
@property (nonatomic,strong) UIButton *buttonNav;
@property (nonatomic,strong) UIButton *buttonCall;
@property (nonatomic,strong) UIImageView *leftIcon;
@property (nonatomic,strong) UIView *containerView;

@end

@implementation CarPoolingOrderCell

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
    _buttonStatus = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonStatus.layer setCornerRadius:5];
    [_buttonStatus.layer setMasksToBounds:YES];
    [_buttonStatus.layer setBorderWidth:1];
    [_buttonStatus.layer setBorderColor:RGBHex(g_blue).CGColor];
    [_buttonStatus.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_buttonStatus setTitleColor:RGBHex(g_blue) forState:UIControlStateNormal];
    [_buttonStatus setUserInteractionEnabled:NO];
    [_buttonStatus addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonStatus];
    [_buttonStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(5);
    }];
    _buttonNav = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonNav setTag:2];
    [_buttonNav.layer setCornerRadius:5];
    [_buttonNav.layer setMasksToBounds:YES];
    [_buttonNav.layer setBorderWidth:1];
    [_buttonNav.layer setBorderColor:RGBHex(g_blue).CGColor];
    [_buttonNav.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_buttonNav setTitleColor:RGBHex(g_blue) forState:UIControlStateNormal];
    [_buttonNav setTitle:@"导航" forState:UIControlStateNormal];
    [_buttonNav addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonNav];
    [_buttonNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
        make.right.equalTo(_buttonStatus.mas_left).offset(-10);
        make.top.equalTo(self).offset(5);
    }];
    
    _timeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_timeLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_timeLabel setTitleColor:RGBHex(g_black)];
    [_timeLabel setImageUrl:@"lanyuan-1"];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.height.mas_equalTo(30);
        make.right.equalTo(_buttonNav.mas_left);
        make.centerY.equalTo(_buttonNav);
    }];
    
    _containerView = [[UIView alloc] init];
    [_containerView.layer setCornerRadius:5];
    [_containerView.layer setMasksToBounds:YES];
    [_containerView.layer setBorderWidth:1];
    [_containerView.layer setBorderColor:[UIColor clearColor].CGColor];
    [_containerView setBackgroundColor:RGBHex(g_assit_gray_eee)];
    
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buttonStatus.mas_bottom).offset(10);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self);
    }];
    
    _leftIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"landianhua"]];
    [_containerView addSubview:_leftIcon];
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView).offset(10);
        make.left.equalTo(_containerView).offset(10);
    }];
    
    _buttonCall = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCall.layer setCornerRadius:12.5];
    [_buttonCall.layer setMasksToBounds:YES];
    [_buttonCall setTitle:@"" forState:UIControlStateNormal];
    [_buttonCall.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_buttonCall setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10) ];
    [_buttonCall addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonCall setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_blue)] forState:UIControlStateNormal];
    
    [_containerView addSubview:_buttonCall];
    [_buttonCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftIcon.mas_right).offset(10);
        make.centerY.equalTo(_leftIcon);
        make.height.mas_equalTo(25);
        make.width.mas_greaterThanOrEqualTo(80);
        make.width.mas_lessThanOrEqualTo(200);
    }];
    
    _routeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_routeLabel setImageUrl:@"shuqian"];
    [_routeLabel setTitleColor:RGBHex(g_gray_54)];
    [_routeLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_routeLabel];
    [_routeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftIcon.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView);
        make.height.mas_equalTo(30);
    }];
    
    
    _upLocationLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_upLocationLabel setImageUrl:@"shang"];
    [_upLocationLabel setTitleColor:RGBHex(g_gray_54)];
    [_upLocationLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_upLocationLabel];
    [_upLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_routeLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView);
        make.height.mas_equalTo(30);
    }];
    
    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_endLabel setImageUrl:@"xia"];
    [_endLabel setTitleColor:RGBHex(g_gray_54)];
    [_endLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_upLocationLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView);
        make.height.mas_equalTo(30);
    }];
    
    _peopleLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_peopleLabel setTitle:@""];
    [_peopleLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_peopleLabel setImageUrl:@"yuanren"];
    [self addSubview:_peopleLabel];
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    _bakLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_bakLabel setTitle:@""];
    [_bakLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_bakLabel setImageUrl:@"bei"];
    [self addSubview:_bakLabel];
    [_bakLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_peopleLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    _fee = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_fee setTitle:@""];
    [_fee setTitleFont:[UIFont systemFontOfSize:13]];
    [_fee setTitleColor:RGBHex(g_blue)];
    [self addSubview:_fee];
    [_fee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_peopleLabel.mas_bottom);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_greaterThanOrEqualTo(20);
    }];

    
    UIView *view =[[UIView alloc] init];
    [view setBackgroundColor:RGBHex(g_blue)];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.equalTo(_timeLabel.iconView.mas_bottom);
        make.left.equalTo(_timeLabel.iconView.mas_centerX);
        make.bottom.equalTo(self);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) setModel:(OrderModel *)model
{
    _model = model;
    [_timeLabel setTitle:_model.appointDate];
    [_routeLabel setTitle:_model.lineName];
    [_peopleLabel setTitle:[NSString stringWithFormat:@"%@人",_model.orderPerson]];
    [_bakLabel setTitle:_model.descriptions];
    [_fee setTitle:[NSString stringWithFormat:@"￥%@",_model.fee]];
    //getOrderDescription

    [_buttonStatus setTitle:[CommonUtility getDriverOrderDescription:_model.state] forState:UIControlStateNormal];
    if ([@"3" isEqualToString:_model.state] || [@"4" isEqualToString:_model.state] || [@"5" isEqualToString:_model.state]) {
        [_buttonStatus setUserInteractionEnabled:YES];
    }else {
        [_buttonStatus setUserInteractionEnabled:NO];
    }
    
    if ([@"2" isEqualToString:_model.state]||[@"3" isEqualToString:_model.state]||[@"5" isEqualToString:_model.state]) {
        //||[@"4" isEqualToString:_model.state]
        [_buttonNav setHidden:NO];
    }else{
        [_buttonNav setHidden:YES];
    }
    [_buttonCall setTitle:model.mRealName?model.mRealName:model.mPhoneNo forState:UIControlStateNormal];
    [_upLocationLabel setTitle:model.slocation];
    [_endLabel setTitle:_model.elocation];
//    NSLog(@"%@",model);

}

- (void) buttonTarget:(UIButton*)button
{
    if (button == _buttonCall) {
        [CommonUtility callTelphone:_model.mPhoneNo];
        return;
    }
    if (button == _buttonNav) {
        if (_delegate &&[_delegate respondsToSelector:@selector(buttonTarget:withObj:)])
        {
            [_delegate buttonTarget:button withObj:_model];
        }
        return;
    }
    if (_delegate &&[_delegate respondsToSelector:@selector(buttonTarget:)])
    {
        [_delegate buttonTarget:_model];
    }
}
@end
