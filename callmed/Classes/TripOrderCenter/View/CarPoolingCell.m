//
//  CarPoolingCell.m
//  callmed
//
//  Created by sam on 16/8/3.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CarPoolingCell.h"
#import "LeftIconLabel.h"
#import "CMSearchManager.h"

@interface CarPoolingCell()

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *timeLabel2;

@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) UIImageView *orderNewImage;

@property (nonatomic,strong) LeftIconLabel *routeLabel;
@property (nonatomic,strong) LeftIconLabel *peopleLabel;
@property (nonatomic,strong) LeftIconLabel *feeLabel;
@property (nonatomic,strong) LeftIconLabel *startLabel;
@property (nonatomic,strong) LeftIconLabel *endLabel;

@property (nonatomic,strong) UILabel *moneyLabel;


@end

@implementation CarPoolingCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = RGBHex(g_assit_gray);
//    UIView *backView = [[UIView alloc]init];
//    [backView setBackgroundColor:[UIColor whiteColor]];
//    backView.layer.cornerRadius = 5;
//    backView.layer.masksToBounds = YES;
//    [self addSubview:backView];
//    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self);
//        make.left.equalTo(self);
//        make.right.equalTo(self);
//        make.bottom.equalTo(self);
//    }];
    
    UIImageView * backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1213123123123123123123123"]];
    [self addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    UIImageView *timeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"diandian"]];
    [self addSubview:timeImage];
    [timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.left.equalTo(self).offset(25);
    }];
    
    _orderNewImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new"]];
    [self addSubview:_orderNewImage];
    [_orderNewImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.top.equalTo(self).offset(5);
    }];
    
    _routeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_routeLabel setTitle:@"昆明－北京"];
    [_routeLabel setImageUrl:@"shuqian"];
    [_routeLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [self addSubview:_routeLabel];
    [_routeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeImage).offset(-20);
        make.left.equalTo(timeImage.mas_rightMargin).offset(20);
    }];
    _peopleLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_peopleLabel setTitle:@""];
    [_peopleLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_peopleLabel setImageUrl:@"yuanren"];
    [self addSubview:_peopleLabel];
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeImage).offset(20);
        make.left.equalTo(timeImage.mas_rightMargin).offset(20);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = RGBHex(g_assit_gray);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeImage.mas_bottom).offset(20);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.height.offset(1);
    }];
    
    _moneyLabel = [[UILabel alloc] init];
    [_moneyLabel setText:@"￥123.15"];
    [_moneyLabel setFont:[UIFont systemFontOfSize:15]];
    [_moneyLabel setTextColor:RGBHex(g_blue)];
    [self addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeImage);
        make.top.equalTo(lineView).offset(15);
    }];

    _getOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getOrder setTitle:@"接单" forState:UIControlStateNormal];
    [_getOrder.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_getOrder setBackgroundColor:RGBHex(g_blue)];
    _getOrder.layer.cornerRadius = 5;
    _getOrder.layer.masksToBounds = YES;
    [self addSubview:_getOrder];
    [_getOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_moneyLabel);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    _moreOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_moreOrder setTitle:@"查看该线路更多订单" forState:UIControlStateNormal];
    [_moreOrder.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_moreOrder setBackgroundColor:RGBHex(g_blue)];
    [self addSubview:_moreOrder];
    [_moreOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self).offset(-6);
        make.height.mas_equalTo(40);
    }];

    
    _timeLabel = [[UILabel alloc] init];
    [_timeLabel setText:@"08.12"];
    [_timeLabel setFont:[UIFont systemFontOfSize:15]];
    [_timeLabel setTextColor:RGBHex(g_blue)];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(timeImage);
        make.centerY.equalTo(timeImage).offset(-10);
    }];
    _timeLabel2 = [[UILabel alloc] init];
    [_timeLabel2 setText:@"10:22"];
    [_timeLabel2 setFont:[UIFont systemFontOfSize:15]];
    [_timeLabel2 setTextColor:[UIColor whiteColor]];
    _timeLabel2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeLabel2];
    [_timeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(timeImage);
        make.centerY.equalTo(timeImage).offset(15);
    }];
    
//
//
//    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [_distanceLabel setText:@"距离0.0公里"];
//    [_distanceLabel setFont:[UIFont systemFontOfSize:13]];
//    [_distanceLabel.layer setCornerRadius:10];
//    [_distanceLabel setTextAlignment:NSTextAlignmentCenter];
//    [_distanceLabel.layer setMasksToBounds:YES];
//    [_distanceLabel setTextColor:[UIColor whiteColor]];
//    [_distanceLabel setBackgroundColor:RGBHex(g_blue)];
//    [self addSubview:_distanceLabel];
//    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_timeLabel.mas_bottom);
//        make.left.equalTo(self).offset(10);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(150);
//    }];
//
//    
    

//
//    _startLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [_startLabel setTitle:@""];
//    [_startLabel setTitleFont:[UIFont systemFontOfSize:15]];
//    [_startLabel setImageUrl:@"shang"];
//    [self addSubview:_startLabel];
//    [_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_routeLabel.mas_bottom);
//        make.left.equalTo(self).offset(10);
//        make.height.mas_equalTo(30);
//    }];
//    
//    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [_endLabel setTitle:@""];
//    [_endLabel setTitleFont:[UIFont systemFontOfSize:15]];
//    [_endLabel setImageUrl:@"xia"];
//    [self addSubview:_endLabel];
//    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_startLabel.mas_bottom);
//        make.left.equalTo(self).offset(10);
//        make.height.mas_equalTo(30);
//    }];
//    
//
//    _feeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [_feeLabel setTitle:@"0元"];
//    [_feeLabel setTitleFont:[UIFont systemFontOfSize:15]];
//    [_feeLabel setImageUrl:@"￥"];
//    [self addSubview:_feeLabel];
//    [_feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_peopleLabel.mas_bottom);
//        make.left.equalTo(self).offset(10);
//        make.height.mas_equalTo(30);
//    }];
//    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void) setModel:(OrderModel *)model
{
    _model = model;
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate* date = [formatter dateFromString:_model.appointDate];
    NSDateFormatter *month=[[NSDateFormatter alloc]init];
    month.dateFormat = @"MM.dd";
    NSDateFormatter *houre=[[NSDateFormatter alloc]init];
    houre.dateFormat = @"HH:mm";
    [_timeLabel setText:[month stringFromDate:date]];
    [_timeLabel2 setText:[houre stringFromDate:date]];
    
    NSDate *nowDate = [NSDate date];

    if ([[self dateTimeDifferenceWithStartTime:_model.createDate endTime:[formatter stringFromDate:nowDate]] intValue] >5) {
        _orderNewImage.hidden = YES;
    }else{
        _orderNewImage.hidden = NO;
    }
    
    [_routeLabel setTitle:[NSString stringWithFormat:@"行程：%@",_model.lineName]];
    [_moneyLabel setText:[NSString stringWithFormat:@"金额：￥%@",_model.fee]];
    if ([@"0" isEqualToString:_model.otherFee]) {
        [_feeLabel setHidden:YES];
    }else{
        [_feeLabel setTitle:[NSString stringWithFormat:@"感谢费%@元",_model.otherFee]];
    }
    
    [_startLabel setTitle:_model.slocation];
    [_endLabel setTitle:_model.elocation];

    [_peopleLabel setTitle:[NSString stringWithFormat:@"人数：%@人",_model.orderPerson]];
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
        [_distanceLabel setText:[NSString stringWithFormat:@"直线距离%0.1f公里",(path.distance / 1000.f)]];
    }];
}
- (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int minute = (int)value /60%60;
    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"%d%d%d",day,house,minute];
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"耗%d%d",house,minute];
    }else if (day== 0 && house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"%d",minute];
    }
    return str;
}
@end
