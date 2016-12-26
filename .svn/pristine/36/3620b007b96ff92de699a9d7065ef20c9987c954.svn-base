//
//  CarSpecialCell.m
//  callmed
//
//  Created by sam on 16/8/5.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CarSpecialCell.h"
#import "LeftIconLabel.h"

@interface CarSpecialCell()

@property (nonatomic,strong) LeftIconLabel *timeLabel;
@property (nonatomic,strong) UIButton *buttonStatus;
@property (nonatomic,strong) UIButton *buttonCall;
@property (nonatomic,strong) UIButton *buttonNav;

@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) LeftIconLabel *beginLabel;
@property (nonatomic,strong) LeftIconLabel *endLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *distanceLabel;
@end

@implementation CarSpecialCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void) initView
{
    _timeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_timeLabel setTitle:@"2016-08-06 11:32:12"];
    [_timeLabel setImageUrl:@"huang3"];
    [_timeLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(200);
    }];
    
    _buttonStatus = [UIButton buttonWithType:UIButtonTypeCustom];

    
    [_buttonStatus.layer setCornerRadius:5];
//    [_buttonStatus.layer setMasksToBounds:YES];
    [_buttonStatus.layer setBorderWidth:1];
    [_buttonStatus.layer setBorderColor:RGBHex(g_yellow).CGColor];
    [_buttonStatus setTitleColor:RGBHex(g_yellow) forState:UIControlStateNormal];
    [_buttonStatus.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_buttonStatus setUserInteractionEnabled:NO];
    [_buttonStatus setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    /*
    [_buttonStatus.layer setBorderColor:RGBHex(g_green).CGColor];
    [_buttonStatus setTitle:@"" forState:UIControlStateNormal];
    [_buttonStatus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];            //RGBHex(g_green)
    [_buttonStatus setTitleColor:RGBHex(g_green) forState:UIControlStateSelected];     //RGBHex(g_green)
    [_buttonStatus setTitleColor:RGBHex(g_green) forState:UIControlStateHighlighted];  //RGBHex(g_green)
    [_buttonStatus.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_buttonStatus setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_green)] forState:UIControlStateNormal];
    [_buttonStatus setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [_buttonStatus setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
     */
    [_buttonStatus addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonStatus.layer setCornerRadius:5];
    [_buttonStatus.layer setMasksToBounds:YES];
    [_buttonStatus.layer setBorderWidth:1];
    [_buttonStatus setTag:1];
    [self addSubview:_buttonStatus];
    [_buttonStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(30);
//        make.width.mas_lessThanOrEqualTo(130);
    }];
    
    
    _buttonNav = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonNav.layer setCornerRadius:5];
    [_buttonNav.layer setMasksToBounds:YES];
    [_buttonNav.layer setBorderWidth:1];
    [_buttonNav.layer setBorderColor:RGBHex(g_yellow).CGColor];
    [_buttonNav.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_buttonNav setTitleColor:RGBHex(g_yellow) forState:UIControlStateNormal];
    [_buttonNav setTitle:@"导航" forState:UIControlStateNormal];
    [_buttonNav setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    /*
    [_buttonNav setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];            //RGBHex(g_green)
    [_buttonNav setTitleColor:RGBHex(g_green) forState:UIControlStateSelected];     //RGBHex(g_green)
    [_buttonNav setTitleColor:RGBHex(g_green) forState:UIControlStateHighlighted];  //RGBHex(g_green)
    [_buttonNav.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_buttonNav setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_green)] forState:UIControlStateNormal];
    [_buttonNav setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [_buttonNav setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    */
    [_buttonNav addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
//    [_buttonNav.layer setCornerRadius:5];
//    [_buttonNav.layer setMasksToBounds:YES];
//    [_buttonNav.layer setBorderWidth:1];
    [_buttonNav setTag:2];
    [self addSubview:_buttonNav];
    [_buttonNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.right.equalTo(_buttonStatus.mas_left).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
    }];
    
    _containerView = [[UIView alloc] init];
    [_containerView.layer setCornerRadius:5];
    [_containerView.layer setMasksToBounds:YES];
    [_containerView setBackgroundColor:RGBHex(g_assit_gray_eee)];
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buttonStatus.mas_bottom).offset(10);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    _distanceLabel =[[UILabel alloc] init];
    [_distanceLabel setText:@"距离0.0公里"];
    [_distanceLabel setFont:[UIFont systemFontOfSize:13]];
    [_distanceLabel.layer setCornerRadius:10];
    [_distanceLabel setTextAlignment:NSTextAlignmentCenter];
    [_distanceLabel.layer setMasksToBounds:YES];
    [_distanceLabel setTextColor:[UIColor whiteColor]];
    [_distanceLabel setBackgroundColor:RGBHex(g_yellow)];
    [_containerView addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView).offset(10);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(130);
    }];
    
    _buttonCall = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCall setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    [_buttonCall setTitle:@"呼和浩特" forState:UIControlStateNormal];
    [_buttonCall.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_buttonCall setTitleColor:RGBHex(g_assit_c1) forState:UIControlStateNormal];
    [_buttonCall addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_buttonCall];
    [_buttonCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_distanceLabel.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    _beginLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_beginLabel setTitle:@"广东省广州市海伦春天"];
    [_beginLabel setImageUrl:@"icon_qidian_dot_3"];
    [_beginLabel setTitleFont:[UIFont systemFontOfSize:14]];
    [_beginLabel setPadding:10];
    [_containerView addSubview:_beginLabel];
    [_beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buttonCall.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-30);
        make.height.mas_greaterThanOrEqualTo(20);
        
    }];
    
    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_endLabel setTitle:@""];
    [_endLabel setImageUrl:@"icon_qidian_dot_4"];
    [_endLabel setTitleFont:[UIFont systemFontOfSize:14]];
    [_endLabel setPadding:10];
    [_containerView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beginLabel.mas_bottom).offset(10);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-30);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    _moneyLabel = [[UILabel alloc] init];
    [_moneyLabel setText:@"￥"];
    [_moneyLabel setTextColor:[UIColor redColor]];
    [_moneyLabel setFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.bottom.equalTo(_containerView).offset(-10);
        make.right.equalTo(_containerView).offset(-5);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(_endLabel.mas_centerY);
    }];
    
    
    UIView *view =[[UIView alloc] init];
    [view setBackgroundColor:RGBHex(g_m_c)];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.equalTo(_timeLabel.iconView.mas_bottom);
        make.left.equalTo(_timeLabel.iconView.mas_centerX);
        make.bottom.equalTo(self);
    }];
}

- (void)awakeFromNib {

}

- (void) setModel:(OrderModel *)model
{
    _model = model;
    NSString *txt = [CommonUtility getDriverOrderDescription:_model.state];
    CGSize size = [txt sizeFont:15];
    [_buttonStatus setTitle:txt forState:UIControlStateNormal];
    [_buttonStatus mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(size.width+20);
    }];
   
    if ([@"3" isEqualToString:_model.state] || [@"4" isEqualToString:_model.state] || [@"5" isEqualToString:_model.state]) {
        [_buttonStatus setUserInteractionEnabled:YES];
    }else {
        [_buttonStatus setUserInteractionEnabled:NO];
    }
    
    [_buttonCall setTitle:[NSString stringWithFormat:@"%@ %@",_model.mRealName?_model.mRealName:@"",_model.mPhoneNo?_model.mPhoneNo:@""] forState:UIControlStateNormal];
    
    if ([@"1" isEqualToString:_model.appoint])
    {
        [_timeLabel setTitle:_model.appointDate];
    }else{
        [_timeLabel setTitle:@"现在"];
    }
    if ([@"4" isEqualToString:_model.type])
    {
        [_timeLabel setTitle:_model.createDate];
    }
    
    NSString *dist = [NSString stringWithFormat:@"距离%0.1f公里",[model.distance floatValue]/1000];
    size = [dist sizeFont:13];
    [_distanceLabel setText:dist];
    [_distanceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView).offset(10);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(size.width+20);
    }];
    
    [_beginLabel setTitle:model.slocation];
    
    NSLog(@"%@",model.elocation);
    if (model.elocation && ![model.elocation hasPrefix:@"(null"]) {
        [_endLabel setTitle:model.elocation];
        [_endLabel setHidden:NO];
    }else{
        [_endLabel setHidden:YES];
    }
    
    
    if ([@"6" isEqualToString:_model.state]|| [@"7" isEqualToString:_model.state]) {
        [_moneyLabel setText:[NSString stringWithFormat:@"￥%@",model.actFee?model.actFee:@""]];
    }else{
        [_moneyLabel setText:[NSString stringWithFormat:@"￥%@",model.fee?model.fee:@""]];
    }
    
    if ([@"2" isEqualToString:_model.state]||[@"3" isEqualToString:_model.state]||[@"5" isEqualToString:_model.state]) {
        //||[@"4" isEqualToString:_model.state]
        [_buttonNav setHidden:NO];
    }else{
        [_buttonNav setHidden:YES];
    }
    if ([@"4" isEqualToString:_model.type]) {
        [_buttonNav setHidden:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) buttonTarget:(id)sender
{
    if (sender == _buttonCall) {
        
        [CommonUtility callTelphone:_model.mPhoneNo];
        return;
    }
    if (sender == _buttonNav) {
        if (_delegate && [_delegate respondsToSelector:@selector(buttonTarget:)]) {
            [_delegate buttonTarget:_buttonNav];
        }
    }else if (_delegate && [_delegate respondsToSelector:@selector(buttonTarget:)]) {
        [_delegate buttonTarget:_model];
    }
}

@end
