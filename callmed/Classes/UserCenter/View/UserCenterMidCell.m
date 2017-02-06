//
//  UserCenterMidCell.m
//  callmed
//
//  Created by sam on 16/7/20.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "UserCenterMidCell.h"
#import "VerticalTitleLabel.h"
#import "CarIncomeView.h"


@interface UserCenterMidCell()

@property (nonatomic,strong) VerticalTitleLabel *estamiteLabel;         //评价率
@property (nonatomic,strong) VerticalTitleLabel *distanceLabel;         //里程
@property (nonatomic,strong) VerticalTitleLabel *successRateLabel;      //成交率

@property (nonatomic,strong) CarIncomeView *carSpecial;
@property (nonatomic,strong) CarIncomeView *carSpooling;
@property (nonatomic,strong) CarIncomeView *carFastBus;
@property (nonatomic,strong) CarIncomeView *carGoods;
@property (nonatomic,strong) UITapGestureRecognizer *g1,*g2,*g3,*g4;
@end

@implementation MidCellModel



@end

@implementation UserCenterMidCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) initView
{
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = RGBHex(g_assit_gray);
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(0);
    }];

    
    _estamiteLabel = [[VerticalTitleLabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [_estamiteLabel setImageName:@"xingji"];
    [_estamiteLabel setTitle:@"4.5"];
    [_estamiteLabel setContent:@"评价星级"];
    [_estamiteLabel setTitleFont:[UIFont systemFontOfSize:20]];
    [_estamiteLabel setTitleColor:[UIColor blackColor]];
    [_estamiteLabel setContentFont:[UIFont systemFontOfSize:12]];
    [self addSubview:_estamiteLabel];
    
    
    _distanceLabel = [[VerticalTitleLabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [_distanceLabel setImageName:@"xingch"];
    [_distanceLabel setTitle:@"30"];
    [_distanceLabel setContent:@"我的行程"];
    [_distanceLabel setTitleFont:[UIFont systemFontOfSize:20]];
    [_distanceLabel setTitleColor:[UIColor blackColor]];
    [_distanceLabel setContentFont:[UIFont systemFontOfSize:12]];
    [self addSubview:_distanceLabel];
    
    [_estamiteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(_distanceLabel.mas_left);
        make.height.mas_equalTo(90);
    }];
    
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom);
        make.left.equalTo(_estamiteLabel.mas_right);
        make.width.equalTo(_estamiteLabel.mas_width);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(90);
    }];
    
    _successRateLabel = [[VerticalTitleLabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [_successRateLabel setImageName:@"chengjiao"];
    [_successRateLabel setTitle:@"98%"];
    [_successRateLabel setContent:@"成交率"];
    [_successRateLabel setTitleFont:[UIFont systemFontOfSize:20]];
    [_successRateLabel setTitleColor:[UIColor blackColor]];
    [_successRateLabel setContentFont:[UIFont systemFontOfSize:12]];
    [self addSubview:_successRateLabel];
    [_successRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom);
        make.left.equalTo(_distanceLabel.mas_right);
        make.width.equalTo(_distanceLabel.mas_width);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(90);
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = RGBHex(g_assit_gray);
    [self addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_successRateLabel.mas_bottom).offset(10);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(5);
    }];
    
    
    UIView *lineone = [[UIView alloc] init];
    [lineone setBackgroundColor:RGBHex(g_assit_gray)];
    [self addSubview:lineone];
    [lineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(lineView2.mas_bottom).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.width.mas_equalTo(1);
    }];
    
    _carSpecial =[[CarIncomeView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_carSpecial setTitle:@"专车"];
    _g1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    _g1.numberOfTapsRequired =1;
    _g1.numberOfTouchesRequired =1;
    [_carSpecial addGestureRecognizer:_g1];
    
    [self addSubview:_carSpecial];
    [_carSpecial mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom);
        make.right.equalTo(self.mas_centerX);
        make.height.mas_equalTo(50);
        make.left.equalTo(self);
    }];
    
    
    _carSpooling =[[CarIncomeView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_carSpooling setTitle:@"快车"];
    _g2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    _g2.numberOfTapsRequired =1;
    _g2.numberOfTouchesRequired =1;
    [_carSpooling addGestureRecognizer:_g2];
    [self addSubview:_carSpooling];
    [_carSpooling mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom);
        make.height.mas_equalTo(50);
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self);
    }];
    
//    UIView *linetwo = [[UIView alloc] init];
//    [linetwo setBackgroundColor:RGBHex(g_gray)];
//    [self addSubview:linetwo];
//    [linetwo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self);
//        make.top.equalTo(_carSpecial.mas_bottom);
//        make.height.mas_equalTo(1);
//        make.width.equalTo(self);
//    }];
    
//    _carFastBus =[[CarIncomeView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [_carFastBus setTitle:@"快巴"];
//    _g3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
//    _g3.numberOfTapsRequired =1;
//    _g3.numberOfTouchesRequired =1;
//    [_carFastBus addGestureRecognizer:_g3];
//    [self addSubview:_carFastBus];
//    [_carFastBus mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(linetwo.mas_bottom).offset(10);
//        make.right.equalTo(self.mas_centerX);
//        make.height.mas_equalTo(50);
//        make.left.equalTo(self);
//    }];

//    _carGoods =[[CarIncomeView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [_carGoods setTitle:@"货的"];
//    _g4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
//    _g4.numberOfTapsRequired =1;
//    _g4.numberOfTouchesRequired =1;
//    [_carGoods addGestureRecognizer:_g4];
//    
//    [self addSubview:_carGoods];
//    [_carGoods mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(linetwo.mas_bottom).offset(10);
//        make.right.equalTo(self);
//        make.height.mas_equalTo(50);
//        make.left.equalTo(_carFastBus.mas_right);
//    }];

}

- (void) setData:(NSDictionary *)data
{
    if (!data) {
        return;
    }
    _data= data;
    [_estamiteLabel setTitle:[NSString stringWithFormat:@"%@",_data[@"level"]]];
    [_distanceLabel setTitle:[NSString stringWithFormat:@"%ld",[_data[@"distance"] integerValue]/1000]];
    [_successRateLabel setTitle:[NSString stringWithFormat:@"%@",_data[@"rate"]]];
    
    NSArray *carArray =_data[@"details"];
    if (carArray && carArray.count>0) {
        for (NSDictionary *dict in carArray) {
            MidCellModel *model = [[MidCellModel alloc] initWithDictionary:dict error:nil];
            if (model &&[@"1" isEqualToString:model.type]) {
                [_carSpecial setNumber:model.totalNum];
                [_carSpecial setMoney:model.totalFee];
            }else if (model &&[@"2" isEqualToString:model.type]) {
                [_carSpooling setNumber:model.totalNum];
                [_carSpooling setMoney:model.totalFee];
            }else if (model &&[@"3" isEqualToString:model.type]) {
                [_carGoods setNumber:model.totalNum];
                [_carGoods setMoney:model.totalFee];
            }else if (model &&[@"4" isEqualToString:model.type]) {
                [_carFastBus setNumber:model.totalNum];
                [_carFastBus setMoney:model.totalFee];
            }
        }
    }
}

- (void) gesture:(UITapGestureRecognizer*)gesuter
{
    if (_g1 ==gesuter) {
        if (_delegate && [_delegate respondsToSelector:@selector(buttonSelectedIndex:)])
        {
            [_delegate buttonSelectedIndex:1];
        }
    }else if (_g2 ==gesuter) {
        if (_delegate && [_delegate respondsToSelector:@selector(buttonSelectedIndex:)])
        {
            [_delegate buttonSelectedIndex:2];
        }
    }else if (_g3 ==gesuter) {
        if (_delegate && [_delegate respondsToSelector:@selector(buttonSelectedIndex:)])
        {
            [_delegate buttonSelectedIndex:4];
        }
    }else if (_g4 ==gesuter) {
        if (_delegate && [_delegate respondsToSelector:@selector(buttonSelectedIndex:)])
        {
            [_delegate buttonSelectedIndex:3];
        }
    }
}

@end
