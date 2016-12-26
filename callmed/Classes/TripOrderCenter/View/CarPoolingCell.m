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
@property (nonatomic,strong) UILabel *distanceLabel;
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
    _timeLabel = [[UILabel alloc] init];
    [_timeLabel setText:@"2016-08-12 10:22"];
    [_timeLabel setFont:[UIFont systemFontOfSize:15]];
    [_timeLabel setTextColor:[UIColor blackColor]];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(30);
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
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_distanceLabel setText:@"距离0.0公里"];
    [_distanceLabel setFont:[UIFont systemFontOfSize:13]];
    [_distanceLabel.layer setCornerRadius:10];
    [_distanceLabel setTextAlignment:NSTextAlignmentCenter];
    [_distanceLabel.layer setMasksToBounds:YES];
    [_distanceLabel setTextColor:[UIColor whiteColor]];
    [_distanceLabel setBackgroundColor:RGBHex(g_blue)];
    [self addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(150);
    }];

    
    _routeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_routeLabel setTitle:@"昆明－北京"];
    [_routeLabel setImageUrl:@"shuqian"];
    [_routeLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [self addSubview:_routeLabel];
    [_routeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_distanceLabel.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    _startLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_startLabel setTitle:@""];
    [_startLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_startLabel setImageUrl:@"shang"];
    [self addSubview:_startLabel];
    [_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_routeLabel.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_endLabel setTitle:@""];
    [_endLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_endLabel setImageUrl:@"xia"];
    [self addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_startLabel.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    _peopleLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_peopleLabel setTitle:@""];
    [_peopleLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_peopleLabel setImageUrl:@"yuanren"];
    [self addSubview:_peopleLabel];
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endLabel.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    _feeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_feeLabel setTitle:@"0元"];
    [_feeLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_feeLabel setImageUrl:@"￥"];
    [self addSubview:_feeLabel];
    [_feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_peopleLabel.mas_bottom);
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    _moneyLabel = [[UILabel alloc] init];
    [_moneyLabel setText:@"￥123.15"];
    [_moneyLabel setFont:[UIFont systemFontOfSize:15]];
    [_moneyLabel setTextColor:RGBHex(g_blue)];
    [self addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(_feeLabel);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void) setModel:(OrderModel *)model
{
    _model = model;
    [_timeLabel setText:_model.appointDate];
    [_routeLabel setTitle:_model.lineName];
    [_moneyLabel setText:[NSString stringWithFormat:@"￥%@",_model.fee]];
    if ([@"0" isEqualToString:_model.otherFee]) {
        [_feeLabel setHidden:YES];
    }else{
        [_feeLabel setTitle:[NSString stringWithFormat:@"感谢费%@元",_model.otherFee]];
    }
    
    [_startLabel setTitle:_model.slocation];
    [_endLabel setTitle:_model.elocation];

    [_peopleLabel setTitle:[NSString stringWithFormat:@"%@人",_model.orderPerson]];
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

@end
