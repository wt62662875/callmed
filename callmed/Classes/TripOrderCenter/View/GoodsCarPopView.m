//
//  GoodsCarPopView.m
//  callmed
//
//  Created by sam on 16/8/15.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "GoodsCarPopView.h"
#import "LeftIconLabel.h"
#import "CMSearchManager.h"

@interface GoodsCarPopView()
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UIView *top_containerView;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) LeftIconLabel *userView;
@property (nonatomic,strong) UIButton *buttonCall;
@property (nonatomic,strong) UIButton *buttonSubmit;
@property (nonatomic,strong) UIButton *buttonCancel;

@property (nonatomic,strong) LeftIconLabel *carTypeLabel;
@property (nonatomic,strong) LeftIconLabel *startLabel;
@property (nonatomic,strong) LeftIconLabel *endLabel;

@property (nonatomic,strong) LeftIconLabel *goodsNameLabel;
@property (nonatomic,strong) LeftIconLabel *goodsInfoLabel;

@property (nonatomic,strong) UIImageView *iconReceiver;
@property (nonatomic,strong) UIButton *buttonCallReceiver;

@property (nonatomic,strong) UIButton *routePlanLine;//规划线路
@end

@implementation GoodsCarPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView
{
    [self setBackgroundColor:RGBHexa(g_gray_99, 0.5)];
    _containerView =[[UIView alloc] init];
    [_containerView.layer setMasksToBounds:YES];
    [_containerView.layer setCornerRadius:5];
    [_containerView setClipsToBounds:YES];
    
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_greaterThanOrEqualTo(400);
    }];
    
    _top_containerView = [[UIView alloc] init];
    [_top_containerView setBackgroundColor:RGBHex(g_m_c)];
    [_containerView addSubview:_top_containerView];
    [_top_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.left.equalTo(_containerView);
        make.right.equalTo(_containerView);
        make.height.mas_equalTo(60);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    [_timeLabel setText:@"2016-08-12 10:22"];
    [_timeLabel setTextColor:[UIColor whiteColor]];
    [_top_containerView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_top_containerView);
        make.left.equalTo(_top_containerView).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    _moneyLabel = [[UILabel alloc] init];
    [_moneyLabel setText:@"￥123.15"];
    [_moneyLabel setTextColor:[UIColor whiteColor]];
    [_top_containerView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_top_containerView);
        make.right.equalTo(_top_containerView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    
    _distanceLabel =[[UILabel alloc] init];
    [_distanceLabel setText:@"距离1.5公里"];
    [_distanceLabel setFont:[UIFont systemFontOfSize:13]];
    [_distanceLabel.layer setCornerRadius:10];
    [_distanceLabel setTextAlignment:NSTextAlignmentCenter];
    [_distanceLabel.layer setMasksToBounds:YES];
    [_distanceLabel setTextColor:[UIColor whiteColor]];
    [_distanceLabel setBackgroundColor:RGBHex(g_m_c)];
    [_containerView addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_top_containerView.mas_bottom).offset(10);
        make.left.equalTo(_top_containerView).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
    _userView =[[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_userView setImageUrl:@"icon_guest_pl"];
    [_userView setImageH:35];
    [_userView setTitle:@"高女士"];
    [_containerView addSubview:_userView];
    [_userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_distanceLabel.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(230);
    }];
    
    _buttonCall = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCall setTag:0];
    [_buttonCall setImage:[UIImage imageNamed:@"icon_phone"] forState:UIControlStateNormal];
    [_buttonCall addTarget:self action:@selector(buttonTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    [_containerView addSubview:_buttonCall];
    [_buttonCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_containerView).offset(-30);
        make.centerY.equalTo(_userView);
        make.height.width.mas_equalTo(40);
    }];
    
    _carTypeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_carTypeLabel setTitle:@"weweweew"];
    [_carTypeLabel setImageUrl:@"top_set"];
    [_carTypeLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_carTypeLabel setPadding:10];
    [_containerView addSubview:_carTypeLabel];
    [_carTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userView.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    _startLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_startLabel setTitle:@""];
    [_startLabel setImageUrl:@"icon_fahuo"];
    [_startLabel setImageW:13 withH:17];
    [_startLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_startLabel setPadding:10];
    [_containerView addSubview:_startLabel];
    [_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_carTypeLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_endLabel setTitle:@""];
    [_endLabel setImageUrl:@"icon_shouhuo"];
    [_endLabel setImageW:13 withH:17];
    [_endLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_endLabel setPadding:10];
    [_containerView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_startLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    _goodsNameLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_goodsNameLabel setTitle:@"人"];
    [_goodsNameLabel setImageUrl:@"icon_pc_pepo"];
    [_goodsNameLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_goodsNameLabel setPadding:10];
    [_containerView addSubview:_goodsNameLabel];
    [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    _goodsInfoLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_goodsInfoLabel setTitle:@"0元"];
    [_goodsInfoLabel setImageUrl:@"icon_pc_bei"];
    [_goodsInfoLabel setTitleFont:[UIFont systemFontOfSize:12]];
    [_goodsInfoLabel setPadding:10];
    [_containerView addSubview:_goodsInfoLabel];
    [_goodsInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsNameLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(30);
        make.right.equalTo(_containerView).offset(-10);
    }];
    
    _iconReceiver = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_guest_pl"]];
    [_containerView addSubview:_iconReceiver];
    [_iconReceiver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsInfoLabel.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(20);
        make.height.width.mas_equalTo(30);
    }];
    
    _buttonCallReceiver = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCallReceiver.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_buttonCallReceiver.layer setCornerRadius:15];
    [_buttonCallReceiver.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_buttonCallReceiver.layer setMasksToBounds:YES];
    [_buttonCallReceiver setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonCallReceiver addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonCallReceiver setBackgroundColor:RGBHex(g_m_c)];
    [_containerView addSubview:_buttonCallReceiver];
    [_buttonCallReceiver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconReceiver.mas_right).offset(10);
        make.centerY.equalTo(_iconReceiver);
        make.height.mas_equalTo(30);
        make.right.equalTo(_containerView).offset(-30);
    }];

//    _routePlanLine = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [_routePlanLine setTitle:@"查看线路规划"];
//    [_routePlanLine setImageUrl:@"icon_map_mk"];
//    [_routePlanLine setTitleFont:[UIFont systemFontOfSize:15]];
//    [_routePlanLine setPadding:10];
//    [_containerView addSubview:_routePlanLine];
//    [_routePlanLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_buttonCallReceiver.mas_bottom).offset(15);
//        make.centerX.equalTo(_containerView);
//        make.width.mas_equalTo(120);
//    }];
    
    
    _routePlanLine = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_routePlanLine setTag:3];
    [_routePlanLine setTitle:@"查看线路规划" forState:UIControlStateNormal];
    [_routePlanLine setTitleColor:RGBHex(g_black) forState:UIControlStateNormal];
    [_routePlanLine setImage:[UIImage imageNamed:@"icon_map_mk"] forState:UIControlStateNormal];
    [_routePlanLine.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_routePlanLine setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [_containerView addSubview:_routePlanLine];
    [_routePlanLine addTarget:self action:@selector(buttonTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    [_routePlanLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buttonCallReceiver.mas_bottom).offset(15);
        make.centerX.equalTo(_containerView);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    
    
    
    _buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonSubmit setTag:1];
    [_buttonSubmit setTitle:@"接单" forState:UIControlStateNormal];
    [_buttonSubmit.layer setCornerRadius:5];
    [_buttonSubmit.layer setMasksToBounds:YES];
    [_buttonSubmit.layer setBorderColor:RGBHex(g_m_c).CGColor];
    [_buttonSubmit.layer setBorderWidth:1];
    
    [_buttonSubmit setTitleColor:RGBHex(g_m_c) forState:UIControlStateNormal];
    [_buttonSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [_buttonSubmit setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_buttonSubmit setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_m_c)] forState:UIControlStateHighlighted];
    [_buttonSubmit addTarget:self action:@selector(buttonTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_containerView addSubview:_buttonSubmit];
    [_buttonSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_routePlanLine.mas_bottom).offset(10);
        make.right.equalTo(_containerView.mas_centerX).offset(-10);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(_containerView).offset(-10);
        make.left.equalTo(_containerView).offset(20);
    }];
    
    
    _buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCancel setTitle:@"不接" forState:UIControlStateNormal];
    [_buttonCancel setTag:2];
    [_buttonCancel.layer setCornerRadius:5];
    [_buttonCancel.layer setMasksToBounds:YES];
    [_buttonCancel.layer setBorderColor:RGBHex(g_m_c).CGColor];
    [_buttonCancel.layer setBorderWidth:1];
    [_buttonCancel setTitleColor:RGBHex(g_m_c) forState:UIControlStateNormal];
    [_buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_buttonCancel setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_buttonCancel setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_m_c)] forState:UIControlStateHighlighted];
    [_buttonCancel addTarget:self action:@selector(buttonTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    [_containerView addSubview:_buttonCancel];
    [_buttonCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_routePlanLine.mas_bottom).offset(10);
        make.left.equalTo(_containerView.mas_centerX).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(_containerView).offset(-10);
        make.right.equalTo(_containerView).offset(-20);
    }];
}

- (void) setModel:(OrderModel *)model
{
    _model = model;
    
    if ([@"1" isEqualToString:_model.appoint])
    {
        [_timeLabel setText:_model.appointDate];
    }else{
        [_timeLabel setText:@"现在"];
    }
    if (![@"0" isEqualToString:model.fee]) {
        [_moneyLabel setText:model.fee];
    }else{
        [_moneyLabel setHidden:YES];
    }
    
    [_distanceLabel setText:model.distance];
    [_userView setTitle:model.mRealName];
    NSLog(@"_model.chartered:%@",_model.chartered);
    [_carTypeLabel setTitle:[@"1" isEqualToString:_model.chartered]?@"包车":@"拼货"];
    [_startLabel setTitle:_model.slocation];
    [_endLabel setTitle:_model.elocation];
    [_goodsNameLabel setTitle:model.goodsName];
    
    NSString *params = [NSString stringWithFormat:@"%@(千克) 长%@ 宽%@ 高%@ (cm)",_model.goodsWeight,
                        _model.goodsScale.count>0?[CommonUtility convertLenght:_model.goodsScale[0]]:@"",
                        _model.goodsScale.count>1?[CommonUtility convertLenght:_model.goodsScale[1]]:@"",
                        _model.goodsScale.count>2?[CommonUtility convertLenght:_model.goodsScale[2]]:@""];
    NSMutableAttributedString * attribute = [[NSMutableAttributedString alloc] initWithString:params];
    
    NSRange qk = [params rangeOfString:@"(千克)"];
    NSRange cm = [params rangeOfString:@"(米)"];
    
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:qk];
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:cm];
    [_goodsInfoLabel setTitleAttribute:attribute];
    [_buttonCallReceiver setTitle:[NSString stringWithFormat:@"%@ %@",
                                   _model.receiver,
                                   _model.receiverPhone] forState:UIControlStateNormal];
    
    CLLocation *end = [[CLLocation alloc] initWithLatitude:[_model.slatitude floatValue] longitude:[_model.slongitude floatValue]];
    CLLocation *start = [[CLLocation alloc] initWithLatitude:[GlobalData sharedInstance].coordinate.latitude longitude:[GlobalData sharedInstance].coordinate.longitude];
    
    //[GlobalData sharedInstance].location;
    [[CMSearchManager sharedInstance] searchRouteLine:start end:end completionBlock:^(id request, id response, NSError *error) {
        
        AMapRouteSearchResponse *resp = (AMapRouteSearchResponse*)response;
        if (resp.route == nil)
        {
            NSLog(@"获取路径失败");
            return;
        }
        AMapPath * path = [resp.route.paths firstObject];
        NSLog(@"caclute:%@",[NSString stringWithFormat:@"预估费用%.2f元  距离%.1f km  时间%.1f分钟", resp.route.taxiCost, path.distance / 1000.f, path.duration / 60.f, nil]);
        [_distanceLabel setText:[NSString stringWithFormat:@"距离%0.1f公里",(path.distance / 1000.f)]];
    }];

    
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (_dismissWhenTouchOutside) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:_containerView];
        if (point.y<0) {
            NSLog(@"touchesBegan point:%@",NSStringFromCGPoint(point));
            [self removeFromSuperview];
        }
    }
    
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

- (void) setDismissWhenTouchOutside:(BOOL)dismissWhenTouchOutside
{
    _dismissWhenTouchOutside = dismissWhenTouchOutside;
    
}

- (void) buttonTarget:(UIButton*)button
{
    if (button==_buttonCall) {
        [CommonUtility callTelphone:_model.mPhoneNo];
        return;
    }else if(button==_buttonCallReceiver)
    {
        [CommonUtility callTelphone:_model.receiverPhone];
        return;
    }
    if (_delegate &&[_delegate respondsToSelector:@selector(buttonTarget:)]) {
        [_delegate buttonTarget:button];
    }
}
@end
