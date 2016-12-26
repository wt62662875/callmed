//
//  NoticeView.m
//  callmed
//
//  Created by sam on 16/8/3.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CarPoolingView.h"
#import "LeftIconLabel.h"
#import "CMSearchManager.h"

@interface CarPoolingView()

@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UIView *top_containerView;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) LeftIconLabel *userView;
@property (nonatomic,strong) UIButton *buttonCall;
@property (nonatomic,strong) UIButton *buttonMessage;

@property (nonatomic,strong) UIButton *buttonSubmit;
@property (nonatomic,strong) UIButton *buttonCancel;

@property (nonatomic,strong) LeftIconLabel *routeLabel;
@property (nonatomic,strong) LeftIconLabel *startLabel;
@property (nonatomic,strong) LeftIconLabel *endLabel;


@property (nonatomic,strong) LeftIconLabel *peopleLabel;
@property (nonatomic,strong) LeftIconLabel *feeLabel;
@property (nonatomic,strong) LeftIconLabel *remarkLabel;
@property (nonatomic,strong) UIButton *routePlanLine;//规划线路
@end

@implementation CarPoolingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
//        make.height.mas_equalTo(300);
        make.height.mas_greaterThanOrEqualTo(200);
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
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lanbai"]];
    [_top_containerView addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_top_containerView);
        make.left.equalTo(_top_containerView);
        make.right.equalTo(_top_containerView);
        make.bottom.equalTo(_top_containerView);
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
    [_distanceLabel setBackgroundColor:RGBHex(g_blue)];
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
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(150);
    }];
    
    _buttonCall = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCall setTag:0];
    [_buttonCall setImage:[UIImage imageNamed:@"landianhua"] forState:UIControlStateNormal];
    [_buttonCall addTarget:self action:@selector(buttonTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    [_containerView addSubview:_buttonCall];
    [_buttonCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_containerView).offset(-30);
        make.centerY.equalTo(_userView);
//        make.height.width.mas_equalTo(30);
    }];
    
    _buttonMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonMessage setTag:41];
    [_buttonMessage setImage:[UIImage imageNamed:@"lanxinfeng"] forState:UIControlStateNormal];
    [_buttonMessage addTarget:self action:@selector(buttonTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    [_containerView addSubview:_buttonMessage];
    [_buttonMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_buttonCall).offset(-50);
        make.centerY.equalTo(_buttonCall);
//        make.height.width.mas_equalTo(30);
    }];

    
    
    
    _routeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_routeLabel setTitle:@""];
    [_routeLabel setImageUrl:@"shuqian"];
    [_routeLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_routeLabel setPadding:10];
    [_containerView addSubview:_routeLabel];
    [_routeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userView.mas_bottom).offset(15);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
    }];
    
    _startLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_startLabel setTitle:@""];
    [_startLabel setImageUrl:@"shang"];
    [_startLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_startLabel setPadding:10];
    [_containerView addSubview:_startLabel];
    [_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_routeLabel.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
    }];
    
    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_endLabel setTitle:@""];
    [_endLabel setImageUrl:@"xia"];
    [_endLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_endLabel setPadding:10];
    [_containerView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_startLabel.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
    }];
    
    _peopleLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_peopleLabel setTitle:@"人"];
    [_peopleLabel setImageUrl:@"yuanren"];
    [_peopleLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_peopleLabel setPadding:10];
    [_containerView addSubview:_peopleLabel];
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endLabel.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
    }];
    
    _feeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_feeLabel setTitle:@"0元"];
    [_feeLabel setImageUrl:@"￥"];
    [_feeLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_feeLabel setPadding:10];
    [_containerView addSubview:_feeLabel];
    [_feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_peopleLabel.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
    }];
    
    _remarkLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_remarkLabel setTitle:@""];
    [_remarkLabel setImageUrl:@"bei"];
    [_remarkLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_remarkLabel setPadding:10];
    [_containerView addSubview:_remarkLabel];
    [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_feeLabel.mas_bottom).offset(0);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_greaterThanOrEqualTo(25);
    }];
    
    _routePlanLine = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_routePlanLine setTag:3];
    [_routePlanLine setTitle:@"查看线路规划" forState:UIControlStateNormal];
    [_routePlanLine setTitleColor:RGBHex(g_black) forState:UIControlStateNormal];
    [_routePlanLine setImage:[UIImage imageNamed:@"lanbiao"] forState:UIControlStateNormal];
    [_routePlanLine.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_routePlanLine setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [_containerView addSubview:_routePlanLine];
    [_routePlanLine addTarget:self action:@selector(buttonTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    [_routePlanLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_remarkLabel.mas_bottom).offset(5);
        make.centerX.equalTo(_containerView);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    
    _buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonSubmit setTag:1];
    [_buttonSubmit setTitle:@"接单" forState:UIControlStateNormal];
    [_buttonSubmit.layer setCornerRadius:5];
    [_buttonSubmit.layer setMasksToBounds:YES];
    
    [_buttonSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [_buttonSubmit setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_blue)] forState:UIControlStateNormal];
    [_buttonSubmit setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_blue)] forState:UIControlStateHighlighted];
    [_buttonSubmit addTarget:self action:@selector(buttonTarget:) forControlEvents:(UIControlEventTouchUpInside)];
   
    [_containerView addSubview:_buttonSubmit];
    [_buttonSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_routePlanLine.mas_bottom).offset(5);
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
    [_buttonCancel.layer setBorderColor:RGBHex(g_blue).CGColor];
    [_buttonCancel.layer setBorderWidth:1];
    [_buttonCancel setTitleColor:RGBHex(g_blue) forState:UIControlStateNormal];
    [_buttonCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_buttonCancel setBackgroundImage:[ImageTools imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_buttonCancel setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_blue)] forState:UIControlStateHighlighted];
    [_buttonCancel addTarget:self action:@selector(buttonTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    [_containerView addSubview:_buttonCancel];
    [_buttonCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_routePlanLine.mas_bottom).offset(5);
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
    
    [_moneyLabel setText:[NSString stringWithFormat:@"￥%@",model.fee]];
    [_distanceLabel setText:model.distance];
    [_userView setTitle:model.mRealName?model.mRealName:model.mPhoneNo];
    [_routeLabel setTitle:model.lineName];
    [_startLabel setTitle:model.slocation];
    [_endLabel setTitle:model.elocation];
    [_peopleLabel setTitle:[NSString stringWithFormat:@"%@人",model.orderPerson?model.orderPerson:@"0"]];
    if (!model.otherFee||[@"0" isEqualToString:model.otherFee]) {
        [_feeLabel setHidden:NO];
    }else{
        [_feeLabel setHidden:NO];
        [_feeLabel setTitle:[NSString stringWithFormat:@"%@元",model.otherFee]];
    }
    
    if (!model.descriptions || [model.descriptions length]==0) {
        [_remarkLabel setHidden:NO];
    }else{
        [_remarkLabel setHidden:NO];
        [_remarkLabel setTitle:model.descriptions];
    }
    
    
    
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
        
    }
    if (_delegate &&[_delegate respondsToSelector:@selector(buttonTarget:)]) {
        [_delegate buttonTarget:button];
    }
}
@end
