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
@property (nonatomic,strong) UILabel *time;
@property (nonatomic,strong) UIButton *leftCall;
@property (nonatomic,strong) UIButton *cancelButton;


@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) LeftIconLabel *beginLabel;
@property (nonatomic,strong) LeftIconLabel *endLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
//@property (nonatomic,strong) UILabel *distanceLabel;
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
    _buttonStatus.backgroundColor = RGBHex(g_yellow);
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
        make.left.equalTo(_containerView.mas_centerX).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.bottom.equalTo(_containerView.mas_bottom).offset(-10);
        make.height.offset(35);
    }];
    
    _buttonNav = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonNav.backgroundColor = RGBHex(g_yellow);
    [_buttonNav setTag:2];
    [_buttonNav.layer setCornerRadius:5];
    [_buttonNav.layer setMasksToBounds:YES];
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
    [blueView setBackgroundColor:RGBHex(g_yellow)];
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
    [_timeLabel setImageUrl:@"huang3"];
    [_timeLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(30);
        make.right.equalTo(_buttonNav.mas_left);
        make.top.equalTo(self);
    }];

    _leftCall = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftCall setBackgroundImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
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
    [_buttonCall addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_buttonCall];
    [_buttonCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.centerX.equalTo(_leftCall);
        make.top.equalTo(_leftCall.mas_bottom).offset(10);
        make.width.mas_greaterThanOrEqualTo(120);
        make.width.mas_lessThanOrEqualTo(200);
    }];
    
//    _distanceLabel =[[UILabel alloc] init];
//    [_distanceLabel setText:@"距离0.0公里"];
//    [_distanceLabel setFont:[UIFont systemFontOfSize:13]];
//    [_distanceLabel.layer setCornerRadius:10];
//    [_distanceLabel setTextAlignment:NSTextAlignmentCenter];
//    [_distanceLabel.layer setMasksToBounds:YES];
//    [_distanceLabel setTextColor:[UIColor whiteColor]];
//    [_distanceLabel setBackgroundColor:RGBHex(g_yellow)];
//    [_containerView addSubview:_distanceLabel];
//    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_containerView).offset(10);
//        make.left.equalTo(_containerView).offset(10);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(130);
//    }];
    

    
    _beginLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_beginLabel setTitle:@"广东省广州市海伦春天"];
    [_beginLabel setImageUrl:@"icon_qidian_dot_3"];
    [_beginLabel setTitleFont:[UIFont systemFontOfSize:14]];
    [_beginLabel setPadding:10];
    [_containerView addSubview:_beginLabel];
    [_beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(blueView.mas_bottom);
        make.centerY.equalTo(self).offset(-25);
        make.left.equalTo(_leftCall.mas_right).offset(35);
        make.height.mas_equalTo(30);
    }];
    
    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_endLabel setTitle:@""];
    [_endLabel setImageUrl:@"icon_qidian_dot_4"];
    [_endLabel setTitleFont:[UIFont systemFontOfSize:14]];
    [_endLabel setPadding:10];
    [_containerView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_beginLabel.mas_bottom);
        make.centerY.equalTo(self).offset(25);
        make.left.equalTo(_leftCall.mas_right).offset(35);
        make.height.mas_equalTo(30);
    }];
    
    _moneyLabel = [[UILabel alloc] init];
    [_moneyLabel setText:@"￥"];
    [_moneyLabel setTextColor:[UIColor whiteColor]];
    [_moneyLabel setFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_time);
        make.left.equalTo(_time.mas_right).offset(10);
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
    [view setBackgroundColor:RGBHex(g_yellow)];
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
    if ([_model.state isEqualToString:@"6"]) {
        _buttonStatus.backgroundColor = [UIColor whiteColor];
        [_buttonStatus setTitleColor:RGBHex(g_yellow) forState:UIControlStateNormal];
    }else{
        _buttonStatus.backgroundColor = RGBHex(g_yellow);
        [_buttonStatus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    NSString *txt = [CommonUtility getDriverOrderDescription:_model.state];
    CGSize size = [txt sizeFont:15];
    [_buttonStatus setTitle:txt forState:UIControlStateNormal];
   
    if ([@"3" isEqualToString:_model.state] || [@"4" isEqualToString:_model.state] || [@"5" isEqualToString:_model.state]) {
        [_buttonStatus setUserInteractionEnabled:YES];
    }else {
        [_buttonStatus setUserInteractionEnabled:NO];
    }
    
    [_buttonCall setTitle:model.mRealName?model.mRealName:model.mPhoneNo forState:UIControlStateNormal];
    
    if ([@"1" isEqualToString:_model.appoint])
    {
        _time.text = _model.appointDate;
    }else{
        _time.text = @"现在";
    }
    if ([@"4" isEqualToString:_model.type])
    {
        _time.text = _model.createDate;
    }
    if ([@"2" isEqualToString:_model.state] ||[@"3" isEqualToString:_model.state] || [@"4" isEqualToString:_model.state]) {
        _cancelButton.hidden = NO;
    }else{
        _cancelButton.hidden = YES;
    }
//    NSString *dist = [NSString stringWithFormat:@"距离%0.1f公里",[model.distance floatValue]/1000];
//    size = [dist sizeFont:13];
//    [_distanceLabel setText:dist];
//    [_distanceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_containerView).offset(10);
//        make.left.equalTo(_containerView).offset(10);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(size.width+20);
//    }];
    
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
-(void)cancelButtonClick:(UIButton *)button{
    if ((_delegate && [_delegate respondsToSelector:@selector(valueChanged:)])) {
        [_delegate valueChanged:_model];
    }
    
}
- (void) buttonTarget:(id)sender
{
    if (sender == _buttonCall || sender == _leftCall) {
        
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
