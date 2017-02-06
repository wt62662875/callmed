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

@property (nonatomic,strong) UILabel *time;


@property (nonatomic,strong) UIButton *buttonStatus;
@property (nonatomic,strong) UIButton *buttonNav;
@property (nonatomic,strong) UIButton *buttonCall;
//@property (nonatomic,strong) UIImageView *leftIcon;
@property (nonatomic,strong) UIButton *leftCall;

@property (nonatomic,strong) UIButton *cancelButton;

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
    _containerView = [[UIView alloc] init];
    [_containerView.layer setCornerRadius:5];
    [_containerView.layer setMasksToBounds:YES];
    [_containerView.layer setBorderWidth:1];
    [_containerView.layer setBorderColor:[UIColor clearColor].CGColor];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    _buttonStatus = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonStatus.backgroundColor = RGBHex(g_blue);
    [_buttonStatus.layer setCornerRadius:5];
    [_buttonStatus.layer setMasksToBounds:YES];
//    [_buttonStatus.layer setBorderWidth:1];
//    [_buttonStatus.layer setBorderColor:RGBHex(g_blue).CGColor];
    [_buttonStatus.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_buttonStatus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonStatus setUserInteractionEnabled:NO];
    [_buttonStatus addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonStatus];
    [_buttonStatus mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(30);
//        make.right.equalTo(self).offset(-10);
//        make.top.equalTo(self).offset(5);        
        make.left.equalTo(_containerView.mas_centerX).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.bottom.equalTo(_containerView.mas_bottom).offset(-10);
        make.height.offset(35);
    }];
    
    _buttonNav = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonNav.backgroundColor = RGBHex(g_blue);
    [_buttonNav setTag:2];
    [_buttonNav.layer setCornerRadius:5];
    [_buttonNav.layer setMasksToBounds:YES];
//    [_buttonNav.layer setBorderWidth:1];
//    [_buttonNav.layer setBorderColor:RGBHex(g_blue).CGColor];
    [_buttonNav.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_buttonNav setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonNav setTitle:@"导航" forState:UIControlStateNormal];
    [_buttonNav addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonNav];
    [_buttonNav mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(30);
//        make.right.equalTo(_buttonStatus.mas_left).offset(-10);
//        make.top.equalTo(self).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView.mas_centerX).offset(-10);
        make.bottom.equalTo(_containerView.mas_bottom).offset(-10);
        make.height.offset(35);
    }];
    
    UIView *blueView = [[UIView alloc]init];
    [blueView setBackgroundColor:RGBHex(g_blue)];
    [_containerView addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView);
        make.right.equalTo(_containerView);
        make.top.equalTo(_containerView);
        make.height.offset(35);
    }];
    
    _time = [[UILabel alloc]init];
    _time.font = [UIFont systemFontOfSize:13];
    [_time setTextColor:[UIColor whiteColor]];
    [blueView addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(blueView).offset(5);
        make.centerY.equalTo(blueView);
    }];
    
    
    _timeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_timeLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_timeLabel setTitleColor:RGBHex(g_black)];
    [_timeLabel setImageUrl:@"lanyuan-1"];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(30);
        make.right.equalTo(_buttonNav.mas_left);
        make.top.equalTo(self);
    }];
    
    _leftCall = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftCall setBackgroundImage:[UIImage imageNamed:@"landian"] forState:UIControlStateNormal];
    [_leftCall addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_leftCall];
    [_leftCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blueView.mas_bottom).offset(30);
        make.left.equalTo(_containerView).offset(30);
    }];
  
    _buttonCall = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCall setTitleColor:RGBHex(g_gray_54) forState:UIControlStateNormal];
    [_buttonCall setTitle:@"" forState:UIControlStateNormal];
    [_buttonCall.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    [_buttonCall setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10) ];
    [_buttonCall addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_buttonCall];
    [_buttonCall mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_leftIcon.mas_right).offset(10);
//        make.centerY.equalTo(_leftIcon);
        make.height.mas_equalTo(25);
        make.centerX.equalTo(_leftCall);
        make.top.equalTo(_leftCall.mas_bottom).offset(10);
        make.width.mas_greaterThanOrEqualTo(120);
        make.width.mas_lessThanOrEqualTo(200);
    }];
//
    _routeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_routeLabel setImageUrl:@"shuqian"];
    [_routeLabel setTitleColor:RGBHex(g_gray_54)];
    [_routeLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_routeLabel];
    [_routeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blueView.mas_bottom);
        make.left.equalTo(_leftCall.mas_right).offset(35);
//        make.right.equalTo(_containerView);
        make.height.mas_equalTo(30);
    }];
//
//    
    _upLocationLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_upLocationLabel setImageUrl:@"shang"];
    [_upLocationLabel setTitleColor:RGBHex(g_gray_54)];
    [_upLocationLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_upLocationLabel];
    [_upLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_routeLabel.mas_bottom);
        make.left.equalTo(_leftCall.mas_right).offset(35);
//        make.right.equalTo(_containerView);
        make.height.mas_equalTo(30);
    }];
//
    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_endLabel setImageUrl:@"xia"];
    [_endLabel setTitleColor:RGBHex(g_gray_54)];
    [_endLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_upLocationLabel.mas_bottom);
        make.left.equalTo(_leftCall.mas_right).offset(35);
//        make.right.equalTo(_containerView);
        make.height.mas_equalTo(30);
    }];
//
    _peopleLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_peopleLabel setTitle:@""];
    [_peopleLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_peopleLabel setImageUrl:@"yuanren"];
    [self addSubview:_peopleLabel];
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endLabel.mas_bottom);
        make.left.equalTo(_leftCall.mas_right).offset(35);
        make.height.mas_equalTo(25);
    }];
//
    _bakLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_bakLabel setTitle:@""];
    [_bakLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_bakLabel setImageUrl:@"bei"];
    [self addSubview:_bakLabel];
    [_bakLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_peopleLabel.mas_bottom);
        make.left.equalTo(_leftCall.mas_right).offset(35);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
//
    _fee = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_fee setTitle:@""];
    [_fee setTitleFont:[UIFont systemFontOfSize:13]];
    [_fee setTitleColor:[UIColor whiteColor]];
    [self addSubview:_fee];
    [_fee mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_peopleLabel.mas_bottom);
        make.centerY.equalTo(_time);
        make.left.equalTo(_time.mas_right).offset(10);
//        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelButton setTitle:@"取消订单" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [blueView addSubview:_cancelButton];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blueView);
        make.right.equalTo(blueView).offset(-10);
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
//    [_timeLabel setTitle:_model.appointDate];
    _time.text = _model.appointDate;
    [_routeLabel setTitle:_model.lineName];
    [_peopleLabel setTitle:[NSString stringWithFormat:@"%@人",_model.orderPerson]];
    if ([_model.descriptions isEqualToString:@""]) {
        _bakLabel.hidden = YES;
    }else{
        _bakLabel.hidden = NO;
        [_bakLabel setTitle:_model.descriptions];
    }
    [_fee setTitle:[NSString stringWithFormat:@"￥%@",_model.fee]];
    //getOrderDescription

    if ([_model.state isEqualToString:@"6"]) {
        _buttonStatus.backgroundColor = [UIColor whiteColor];
        [_buttonStatus setTitleColor:RGBHex(g_blue) forState:UIControlStateNormal];
    }else{
        _buttonStatus.backgroundColor = RGBHex(g_blue);
        [_buttonStatus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
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
    if ([@"2" isEqualToString:_model.state] ||[@"3" isEqualToString:_model.state] || [@"4" isEqualToString:_model.state]) {
        _cancelButton.hidden = NO;
    }else{
        _cancelButton.hidden = YES;
    }
    [_buttonCall setTitle:model.mRealName?model.mRealName:model.mPhoneNo forState:UIControlStateNormal];
    [_upLocationLabel setTitle:model.slocation];
    [_endLabel setTitle:_model.elocation];
//    NSLog(@"%@",model);

}

- (void) buttonTarget:(UIButton*)button
{
    if (button == _buttonCall || button == _leftCall) {
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
-(void)cancelButtonClick:(UIButton *)button{
    if ((_delegate && [_delegate respondsToSelector:@selector(valueChanged:)])) {
        [_delegate valueChanged:_model];
    }
    
}
@end
