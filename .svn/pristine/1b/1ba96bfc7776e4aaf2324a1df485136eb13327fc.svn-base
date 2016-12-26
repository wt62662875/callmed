//
//  GoodsCarListCell.m
//  callmed
//
//  Created by sam on 16/8/15.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "GoodsCarListCell.h"
#import "LeftIconLabel.h"

#import "OrderModel.h"
@interface GoodsCarListCell()

@property (nonatomic,strong) LeftIconLabel *timeLabel;
@property (nonatomic,strong) LeftIconLabel *startLabel;
@property (nonatomic,strong) LeftIconLabel *endLabel;
//@property (nonatomic,strong) LeftIconLabel *feeLabel;
@property (nonatomic,strong) UILabel *goodsNameLabel;
@property (nonatomic,strong) UILabel *goodsInfoLabel;
@property (nonatomic,strong) UIView *containerView;

@end

@implementation GoodsCarListCell

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
    _timeLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_timeLabel setTitle:@"2016-08-12 10:22"];
    [_timeLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_timeLabel setImageUrl:@"icon_qidian_dot_3"];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(5);
        make.height.mas_equalTo(30);
    }];
    
    
    _containerView = [[UIView alloc] init];
    [_containerView.layer setMasksToBounds:YES];
    [_containerView.layer setCornerRadius:5];
    [_containerView setBackgroundColor:RGBHex(g_assit_gray_eee)];
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(10);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    _startLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_startLabel setTitle:@"昆明－北京"];
    [_startLabel setImageUrl:@"icon_fahuo"];
    [_startLabel setImageW:13 withH:17];
    [_startLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_startLabel];
    [_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView).offset(10);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(30);
    }];
    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_endLabel setTitle:@"2人"];
    [_endLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_endLabel setImageUrl:@"icon_shouhuo"];
    [_endLabel setImageW:13 withH:17];
    [self addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_startLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:RGBHex(g_gray)];
    [_containerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endLabel.mas_bottom).offset(10);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    _goodsNameLabel = [[UILabel alloc] init];
    [_goodsNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_goodsNameLabel setFont:[UIFont systemFontOfSize:13]];
    
    [_containerView addSubview:_goodsNameLabel];
    [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    _goodsInfoLabel = [[UILabel alloc] init];
    [_goodsInfoLabel setFont:[UIFont systemFontOfSize:13]];
    [_goodsInfoLabel setTextAlignment:NSTextAlignmentCenter];
    [_containerView addSubview:_goodsInfoLabel];
    [_goodsInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsNameLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(25);
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void) setModel:(OrderModel *)model
{
    _model = model;
    [_timeLabel setTitle:_model.appointDate];
    [_startLabel setTitle:_model.slocation];
    [_endLabel setTitle:_model.elocation];
    
    NSString *para = [NSString stringWithFormat:@"[%@]",[@"0" isEqualToString:model.chartered]?@"拼货":@"包车"];
    NSString *str = [NSString stringWithFormat:@"%@ %@",para,model.goodsName];
    NSMutableAttributedString *textAttribute = [[NSMutableAttributedString alloc] initWithString:str];
    [textAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, para.length)];
    [_goodsNameLabel setAttributedText:textAttribute];
    
    NSString *para1 = [NSString stringWithFormat:@"%@ (千克)",model.goodsWeight];
    NSString *size = nil;
    if (_model.goodsScale) {
        size = [NSString stringWithFormat:@"长%@宽%@高%@",
                _model.goodsScale.count>0?[CommonUtility convertLenght:[NSString stringWithFormat:@"%@",_model.goodsScale[0]]]:@"",
                _model.goodsScale.count>1?[CommonUtility convertLenght:[NSString stringWithFormat:@"%@",_model.goodsScale[1]]]:@"",
                _model.goodsScale.count>2?[CommonUtility convertLenght:[NSString stringWithFormat:@"%@",_model.goodsScale[2]]]:@""];
    }
    //CommonUtility
    NSString *str1 = [NSString stringWithFormat:@"%@ %@",para1,size?size:@""];
    NSMutableAttributedString *textAttribute1 = [[NSMutableAttributedString alloc] initWithString:str1];
    NSRange qk = [str1 rangeOfString:@"(千克)"];
    NSRange cm = [str1 rangeOfString:@"(米)"];
    [textAttribute1 addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:qk];
    [textAttribute1 addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:cm];
    
    [_goodsInfoLabel setAttributedText:textAttribute1];
}

@end
