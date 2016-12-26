//
//  BalanceTopCell.m
//  callmed
//
//  Created by sam on 16/8/4.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BalanceTopCell.h"
#import "LeftTitleLabel.h"
#import "MyTimeTool.h"
@interface BalanceTopCell()

@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) LeftTitleLabel *feeStepLabel;
@property (nonatomic,strong) LeftTitleLabel *feeDistanceLabel;
@property (nonatomic,strong) LeftTitleLabel *feeTotalLabel;
@end

@implementation BalanceTopCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super  initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self setBackgroundColor:[UIColor clearColor]];
    _containerView = [[UIView alloc] init];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    [_containerView.layer setCornerRadius:5];
    [_containerView.layer setMasksToBounds:YES];
    [self addSubview:_containerView];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    _titleLabel =[[UILabel alloc] init];
    [_titleLabel setText:@"行程公里 0  时长 0分钟"];
    [_titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(20);
    }];
    
    _tipLabel =[[UILabel alloc] init];
    [_tipLabel setText:@"费用明细"];
    [_tipLabel setFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(20);
        make.left.equalTo(self).offset(20);
    }];
    //feeStepLabel
    
//    _feeStepLabel = [[LeftTitleLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [_feeStepLabel setTitle:@"起步费:"];
//    [_feeStepLabel setContent:@"100"];
//    [_feeStepLabel setLayout:ALginLayoutRight];
//    [_containerView addSubview:_feeStepLabel];
//    [_feeStepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_tipLabel.mas_bottom).offset(5);
//        make.left.equalTo(_containerView).offset(10);
//        make.right.equalTo(_containerView).offset(-10);
//        make.height.mas_equalTo(30);
//    }];
//    
//    _feeDistanceLabel = [[LeftTitleLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [_feeDistanceLabel setTitle:@"里程费:"];
//    [_feeDistanceLabel setContent:@"100"];
//    [_feeDistanceLabel setLayout:ALginLayoutRight];
//    [_containerView addSubview:_feeDistanceLabel];
//    [_feeDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_feeStepLabel.mas_bottom).offset(5);
//        make.left.equalTo(_containerView).offset(10);
//        make.right.equalTo(_containerView).offset(-10);
//        make.height.mas_equalTo(30);
//    }];
    
    _feeTotalLabel = [[LeftTitleLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_feeTotalLabel setTitle:@"合计:"];
    [_feeTotalLabel setContent:@"100"];
    [_feeTotalLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_feeTotalLabel setLayout:ALginLayoutRight];
    [_feeTotalLabel setContentColor:[UIColor redColor]];
    [_containerView addSubview:_feeTotalLabel];
    [_feeTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipLabel.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(30);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void) setData:(NSDictionary *)data
{
    _data = data;
    
    NSArray *dataArray = _data[@"details"];
    LeftTitleLabel *obj=nil;
    if (dataArray && dataArray.count>0) {
        for (NSDictionary *item in dataArray) {
            LeftTitleLabel *itemView = [[LeftTitleLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [itemView setTitle:@"起步费:"];
//            [itemView setContent:@"100"];
            [itemView setLayout:ALginLayoutRight];
            [itemView setTitle:item[@"description"]];
            [itemView setContent:item[@"fee"]];
            [_containerView addSubview:itemView];
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (obj) {
                    make.top.equalTo(obj.mas_bottom).offset(5);
                }else{
                    make.top.equalTo(_tipLabel.mas_bottom).offset(5);
                }
                make.left.equalTo(_containerView).offset(10);
                make.right.equalTo(_containerView).offset(-10);
                make.height.mas_equalTo(30);
            }];
            obj = itemView;
        }
        if (obj) {
            [_feeTotalLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(obj.mas_bottom).offset(0);
                make.left.equalTo(_containerView).offset(10);
                make.right.equalTo(_containerView).offset(-10);
                make.height.mas_equalTo(30);
            }];
        }
    }
    
    //totalFee
    [_feeTotalLabel setContent:[NSString stringWithFormat:@"￥%@ 元",_data[@"totalFee"]]];
}

- (void) setOrderId:(NSString *)orderId
{
    _orderId = orderId;
    OrderDistance *dmodel = [[GlobalData sharedInstance].dictDistance objectForKey:_orderId];
    if (dmodel) {
        NSInteger second = [MyTimeTool compareFromDate:dmodel.date toDate:nil];
        NSString *second_str = [MyTimeTool timeformatFromSeconds:second];
        NSString *distance;
        if (dmodel.distancef>((float)_distance)) {
            distance = dmodel.km;
        }else{
            distance = [NSString stringWithFormat:@"%0.1f",((float)_distance/1000.f)];
        }
        NSString *content = [NSString stringWithFormat:@"行程公里%@时长%@",distance,second_str];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:content];
        
        [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, distance.length)];
        [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4+distance.length+2,
                                                                                                          second_str.length)];
        [_titleLabel setAttributedText:attribute];
    }else{
        
        NSString *second_str = [NSString stringWithFormat:@"%0.1ld分钟",(long)_times];
        NSString *distance = [NSString stringWithFormat:@"%0.1f",((float)_distance/1000.f)];
        
        NSString *content = [NSString stringWithFormat:@"行程公里%@时长%@",distance,second_str];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:content];
        
        [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, distance.length)];
        [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4+distance.length+2,
                                                                                                          second_str.length)];
        [_titleLabel setAttributedText:attribute];
    }
}

@end
