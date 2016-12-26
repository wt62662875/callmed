//
//  NoticeView.m
//  callmed
//
//  Created by sam on 16/8/3.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "NoticeBusCommonView.h"
#import "LeftIconLabel.h"

#import "CMSearchManager.h"
@interface NoticeBusCommonView()

@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UIView *top_containerView;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *cancelLabel;
@property (nonatomic,strong) LeftIconLabel *userView;
@property (nonatomic,strong) UIButton *buttonCall;
@property (nonatomic,strong) UIButton *buttonSubmit;
@property (nonatomic,strong) UIButton *buttonCancel;

@property (nonatomic,strong) LeftIconLabel *beginLabel;
@property (nonatomic,strong) LeftIconLabel *endLabel;
@property (nonatomic,strong) LeftIconLabel *peopleLabel;
@property (nonatomic,strong) LeftIconLabel *routeLine;

@property (nonatomic,strong) dispatch_source_t timer;
@end

@implementation NoticeBusCommonView
{
    NSInteger lastTimer;
    BOOL isCanceled;
}
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
        lastTimer = 30;
        isCanceled = NO;
        [self initView];
    }
    return self;
}

- (void) initTimer
{
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,dispatch_get_main_queue());
    dispatch_source_set_timer(_timer,
                              DISPATCH_TIME_NOW,
                              1.0*NSEC_PER_SEC,
                              0.0);
    
    dispatch_source_set_event_handler(_timer, ^{
        NSLog(@"timers:%ld",(long)lastTimer);
        lastTimer--;
        if (!isCanceled) {
            [_buttonSubmit setTitle:[NSString stringWithFormat:@"抢单(%@)",[NSString stringWithFormat:@"%ld",(long)lastTimer]] forState:UIControlStateNormal];
        }
        if (lastTimer==0 || isCanceled) {
            [self dismiss];
        }
    });
    dispatch_resume(_timer);
}
- (void) cancelTimer
{
    lastTimer = 0;
    isCanceled = YES;
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
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
        make.height.mas_greaterThanOrEqualTo(300);
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
    [_timeLabel setText:@"快巴订单被取消"];
    [_timeLabel setTextColor:[UIColor whiteColor]];
    [_timeLabel setFont:[UIFont systemFontOfSize:20]];
    [_top_containerView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_top_containerView);
        make.centerX.equalTo(_top_containerView);
        make.height.mas_equalTo(30);
    }];

    _userView =[[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_userView setImageUrl:@"icon_guest_pl"];
    [_userView setImageH:35];
    [_userView setTitle:@"高女士"];
    [_containerView addSubview:_userView];
    [_userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_top_containerView.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(150);
    }];
    
    _cancelLabel =[[UILabel alloc] init];
    [_cancelLabel setText:@"与司机达成一致取消订单"];
    [_cancelLabel setFont:[UIFont systemFontOfSize:15]];
    [_cancelLabel setTextAlignment:NSTextAlignmentLeft];
    [_cancelLabel.layer setMasksToBounds:YES];
    [_cancelLabel setTextColor:[UIColor blackColor]];
    [_containerView addSubview:_cancelLabel];
    [_cancelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userView.mas_bottom).offset(10);
        make.left.equalTo(_top_containerView).offset(10);
        make.height.mas_equalTo(30);
        make.width.equalTo(self);
    }];
    
    _buttonCall = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonCall setImage:[UIImage imageNamed:@"icon_phone"] forState:UIControlStateNormal];
    [_buttonCall addTarget:self action:@selector(buttonTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    [_buttonCall setHidden:YES];
    [_buttonCall setTag:3];
    [_containerView addSubview:_buttonCall];
    [_buttonCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_containerView).offset(-30);
        make.centerY.equalTo(_userView);
        make.height.width.mas_equalTo(40);
    }];
    
    _beginLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_beginLabel setTitle:@"永宁街道34号永宁街道34号永宁街道34号永宁街道34号"];
    [_beginLabel setImageUrl:@"icon_qidian_dot_3"];
    [_beginLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_beginLabel setPadding:10];
    [_containerView addSubview:_beginLabel];
    [_beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cancelLabel.mas_bottom).offset(15);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
    }];
    
    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_endLabel setTitle:@"天河体育中心"];
    [_endLabel setImageUrl:@"icon_qidian_dot_4"];
    [_endLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_endLabel setPadding:10];
    [_containerView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beginLabel.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
    }];
    
    _buttonSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonSubmit setTitle:@"确定" forState:UIControlStateNormal];
    [_buttonSubmit.layer setCornerRadius:5];
    [_buttonSubmit.layer setMasksToBounds:YES];
    [_buttonSubmit setTag:1];
    [_buttonSubmit setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_m_c)] forState:UIControlStateNormal];
    [_buttonSubmit addTarget:self action:@selector(buttonTarget:) forControlEvents:(UIControlEventTouchUpInside)];
    [_containerView addSubview:_buttonSubmit];
    [_buttonSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_containerView).offset(-20);
        make.left.equalTo(_containerView).offset(20);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(_containerView).offset(-10);
    }];
    

//    [self initTimer];
}

- (void) setModel:(NotificationModel *)model
{
    _model = model;
    
//    if ([@"1" isEqualToString:_model.appoint])
//    {
//        [_timeLabel setText:_model.appointDate];
//    }else{
//        [_timeLabel setText:@"现在"];
//    }
    
    [_cancelLabel setText:model.cancelReason];
    [_userView setTitle:model.phoneNo];
    [_beginLabel setTitle:model.sLocation];
    [_endLabel setTitle:model.eLocation];
    
    if ([@"17" isEqualToString:_model.type]) {
        [_timeLabel setText:@"快巴订单被取消"];
    }
//    if ([@"2" isEqualToString:_model.bizType])
//    {
//        [_buttonSubmit mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_routeLine.mas_bottom).offset(10);
//            make.right.equalTo(_containerView.mas_centerX).offset(-10);
//            make.height.mas_equalTo(40);
//            make.bottom.equalTo(_containerView).offset(-10);
//            make.width.mas_equalTo(100);
//        }];
//        [_buttonCancel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_routeLine.mas_bottom).offset(10);
//            make.left.equalTo(_containerView.mas_centerX).offset(10);
//            make.height.mas_equalTo(40);
//            make.bottom.equalTo(_containerView).offset(-10);
//            make.width.mas_equalTo(100);
//        }];
//        [_buttonCancel setHidden:NO];
//    }else{
//        [_buttonSubmit mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_routeLine.mas_bottom).offset(10);
//            make.centerX.equalTo(_containerView);
//            make.height.mas_equalTo(40);
//            make.bottom.equalTo(_containerView).offset(-10);
//            make.width.mas_equalTo(200);
//        }];
//        [_buttonCancel setHidden:YES];
//    }
//    CLLocation *end = [[CLLocation alloc] initWithLatitude:[_model.sLatitude floatValue] longitude:[_model.sLongitude floatValue]];
//    CLLocation *start = [[CLLocation alloc] initWithLatitude:[GlobalData sharedInstance].coordinate.latitude longitude:[GlobalData sharedInstance].coordinate.longitude];
//    [[CMSearchManager sharedInstance] searchRouteLine:start end:end completionBlock:^(id request, id response, NSError *error) {
//        
//        AMapRouteSearchResponse *resp = (AMapRouteSearchResponse*)response;
//        if (resp.route == nil)
//        {
//            NSLog(@"获取路径失败");
//            return;
//        }
//        AMapPath * path = [resp.route.paths firstObject];
//        NSLog(@"caclute:%@",[NSString stringWithFormat:@"预估费用%.2f元  距离%.1f km  时间%.1f分钟", resp.route.taxiCost, path.distance / 1000.f, path.duration / 60.f, nil]);
////        [_distanceLabel setText:[NSString stringWithFormat:@"距离%0.1f公里",(path.distance / 1000.f)]];
//    }];
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
    if (button==self.buttonCancel) {
        _buttonType = 0;
    }else if(button== self.buttonSubmit)
    {
        _buttonType =1;
    }else if(button==self.buttonCall)
    {
        _buttonType = 2;
    }
    if (_delegate &&[_delegate respondsToSelector:@selector(buttonSelected:Index:)]) {
        [_delegate buttonSelected:self Index:button.tag];
    }
}

- (void) dismiss
{
    isCanceled = YES;
//    [self cancelTimer];
    [self removeFromSuperview];
}
@end
