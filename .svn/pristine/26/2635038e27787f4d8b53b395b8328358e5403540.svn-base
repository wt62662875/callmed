//
//  CarSpecialCell.m
//  callmed
//
//  Created by sam on 16/8/5.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CarBusCell.h"
#import "LeftIconLabel.h"

@interface CarBusCell()

@property (nonatomic,strong) LeftIconLabel *timeLabel;
@property (nonatomic,strong) UIButton *buttonStatus;
@property (nonatomic,strong) UIButton *buttonCall;
@property (nonatomic,strong) UIButton *buttonNav;
@property (nonatomic,strong) UIButton *buttonCancel;

@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) LeftIconLabel *userInfoLabel;
@property (nonatomic,strong) LeftIconLabel *beginLabel;
@property (nonatomic,strong) LeftIconLabel *endLabel;
@property (nonatomic,strong) LeftIconLabel *peopleLabel;
@property (nonatomic,strong) UIButton *distanceLabel;
@property (nonatomic,strong) UIView *line;
@end

@implementation CarBusCell

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
    [_timeLabel setTitle:@""];
    [_timeLabel setImageUrl:@"icon_qidian_dot_3"];
    [_timeLabel setImageH:25];
    [_timeLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(180);
    }];
    
    UIView *column = [[UIView alloc] init];
    [column setBackgroundColor:RGBHex(g_m_c)];
    [self addSubview:column];
    [column mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.iconView.mas_bottom);
        make.centerX.equalTo(_timeLabel.iconView.mas_centerX);
        make.width.mas_equalTo(1);
        make.bottom.equalTo(self);
    }];
    
    _buttonStatus = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonStatus.layer setBorderColor:RGBHex(g_green).CGColor];
    [_buttonStatus setTitle:@"到达乘客位置" forState:UIControlStateNormal];
    
    [_buttonStatus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];            //RGBHex(g_green)
    [_buttonStatus setTitleColor:RGBHex(g_green) forState:UIControlStateSelected];     //RGBHex(g_green)
    [_buttonStatus setTitleColor:RGBHex(g_green) forState:UIControlStateHighlighted];  //RGBHex(g_green)
    [_buttonStatus.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_buttonStatus setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_green)] forState:UIControlStateNormal];
    [_buttonStatus setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [_buttonStatus setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [_buttonStatus addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonStatus.layer setCornerRadius:5];
    [_buttonStatus.layer setMasksToBounds:YES];
    [_buttonStatus.layer setBorderWidth:1];
    [_buttonStatus setTag:1];
    [self addSubview:_buttonStatus];
    [_buttonStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_greaterThanOrEqualTo(50);
        //make.width.mas_lessThanOrEqualTo(130);
    }];
    
    
    _buttonNav = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_buttonNav.layer setBorderColor:RGBHex(g_green).CGColor];
    [_buttonNav setTitle:@"导航" forState:UIControlStateNormal];
    
    [_buttonNav setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];            //RGBHex(g_green)
    [_buttonNav setTitleColor:RGBHex(g_green) forState:UIControlStateSelected];     //RGBHex(g_green)
    [_buttonNav setTitleColor:RGBHex(g_green) forState:UIControlStateHighlighted];  //RGBHex(g_green)
    [_buttonNav.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_buttonNav setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_green)] forState:UIControlStateNormal];
    [_buttonNav setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [_buttonNav setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [_buttonNav addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonNav.layer setCornerRadius:5];
    [_buttonNav.layer setMasksToBounds:YES];
    [_buttonNav.layer setBorderWidth:1];
    [_buttonNav setTag:2];
    [self addSubview:_buttonNav];
    [_buttonNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
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
        make.top.equalTo(_timeLabel.mas_bottom).offset(5);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];
    

    
    _buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCancel.layer setBorderColor:RGBHex(g_green).CGColor];
    [_buttonCancel setTitle:@"取消预约" forState:UIControlStateNormal];
    
    [_buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];            //RGBHex(g_green)
    [_buttonCancel setTitleColor:RGBHex(g_green) forState:UIControlStateSelected];     //RGBHex(g_green)
    [_buttonCancel setTitleColor:RGBHex(g_green) forState:UIControlStateHighlighted];  //RGBHex(g_green)
    [_buttonCancel.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_buttonCancel setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_green)] forState:UIControlStateNormal];
    [_buttonCancel setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [_buttonCancel setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [_buttonCancel addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonCancel.layer setCornerRadius:5];
    [_buttonCancel.layer setMasksToBounds:YES];
    [_buttonCancel.layer setBorderWidth:1];
    [_buttonCancel setTag:3];
    [_containerView addSubview:_buttonCancel];
   
    
    _userInfoLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_userInfoLabel setTitle:@""];
    [_userInfoLabel setImageUrl:@"icon_userss"];
    [_userInfoLabel setImageH:40];
    [_userInfoLabel setTitleFont:[UIFont systemFontOfSize:14]];
    [_userInfoLabel setPadding:10];
    [_containerView addSubview:_userInfoLabel];
    [_userInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView).offset(10);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(200);
    }];
    
    [_buttonCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
        make.centerY.equalTo(_userInfoLabel.mas_centerY);
    }];
    
    _line = [[UIView alloc] init];
    [_line setBackgroundColor:[UIColor whiteColor]];
    [_containerView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userInfoLabel.mas_bottom).offset(19);
        make.right.equalTo(_containerView).offset(-10);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    _buttonCall =[UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCall.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_buttonCall.layer setCornerRadius:10];
    [_buttonCall.layer setMasksToBounds:YES];
    [_buttonCall setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonCall setBackgroundColor:RGBHex(g_m_c)];
    [_buttonCall setTag:4];
    [_buttonCall setTitle:@"" forState:UIControlStateNormal];
    [_containerView addSubview:_buttonCall];
    [_buttonCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(10);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(130);
    }];
    
//    _buttonCall = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_buttonCall setImage:[UIImage imageNamed:@"icon_phone"] forState:UIControlStateNormal];
//    [_buttonCall setTitle:@"呼和浩特" forState:UIControlStateNormal];
//    [_buttonCall.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [_buttonCall setTitleColor:RGBHex(g_assit_c1) forState:UIControlStateNormal];
    [_buttonCall addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
//    [_containerView addSubview:_buttonCall];
//    [_buttonCall mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_distanceLabel.mas_bottom).offset(5);
//        make.left.equalTo(_containerView).offset(10);
//        make.height.mas_equalTo(40);
//    }];
    
    _beginLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_beginLabel setTitle:@""];
    [_beginLabel setImageUrl:@"icon_qidian_dot_3"];
    [_beginLabel setTitleFont:[UIFont systemFontOfSize:14]];
    [_beginLabel setPadding:10];
    [_containerView addSubview:_beginLabel];
    [_beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buttonCall.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-30);
        make.height.mas_equalTo(25);
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
        make.height.mas_equalTo(25);
    }];
    
    _peopleLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_peopleLabel setTitle:@"0人"];
    [_peopleLabel setImageUrl:@"icon_pc_pepo"];
    [_peopleLabel setTitleFont:[UIFont systemFontOfSize:14]];
    [_peopleLabel setPadding:10];
    [_containerView addSubview:_peopleLabel];
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endLabel.mas_bottom).offset(10);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-30);
        make.height.mas_equalTo(25);
    }];
}

- (void)awakeFromNib {

}

- (void) setModel:(OrderModel *)model
{
    _model = model;
    NSString *txt = @"到达乘客位置";//[CommonUtility getDriverOrderDescription:_model.state];
    CGSize size = [txt sizeFont:15];
    [_buttonStatus setTitle:txt forState:UIControlStateNormal];
    [_buttonStatus mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(size.width+20);
    }];
    if (_model.memberId) {
        [_userInfoLabel setImageUrl:[CommonUtility userHeaderImageUrl:_model.memberId] withDefault:@"icon_userss" withCircle:YES];
        [_userInfoLabel setTitle:_model.memberName?_model.memberName:@""];
    }
    //setImageUrl:[CommonUtility userHeaderImageUrl:_model.memberId]
//    if ([@"1" isEqualToString:_model.appoint])
//    {
//        [_timeLabel setTitle:_model.appointDate];
//    }else{
//        [_timeLabel setTitle:@"现在"];
//    }
//    if ([@"4" isEqualToString:_model.type])
//    {
//        [_timeLabel setTitle:_model.createDate];
//    }
    [_peopleLabel setTitle:[NSString stringWithFormat:@"%@人",model.orderPerson]];
    NSString *dist = [NSString stringWithFormat:@"%@",model.mPhoneNo?model.mPhoneNo:@""];
    size = [dist sizeFont:13];
    [_buttonCall setTitle:model.mPhoneNo forState:UIControlStateNormal];
    [_buttonCall mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(10);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(size.width+20);
    }];
    
    [_beginLabel setTitle:model.slocation];
    [_endLabel setTitle:model.elocation];
    
//    if ([@"2" isEqualToString:_model.state]||[@"3" isEqualToString:_model.state]||[@"5" isEqualToString:_model.state]) {
//        [_buttonNav setHidden:NO];
//    }else{
//        [_buttonNav setHidden:YES];
//    }
//    if ([@"4" isEqualToString:_model.type]) {
//        [_buttonNav setHidden:YES];
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) buttonTarget:(id)sender
{
    if (sender == _buttonCall) {
        [CommonUtility callTelphone:_model.mPhoneNo];
        return;
    }
//    if (sender == _buttonNav || sender == _buttonCancel) {
        if (_delegate && [_delegate respondsToSelector:@selector(buttonTarget:withObj:)]) {
            [_delegate buttonTarget:sender withObj:_model];
        }
//    }
//    else if (_delegate && [_delegate respondsToSelector:@selector(buttonTarget:)]) {
//        [_delegate buttonTarget:_model];
//    }
}

@end
