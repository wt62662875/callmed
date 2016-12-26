//
//  GoodsCarOrderCell.m
//  callmed
//
//  Created by sam on 16/8/15.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "GoodsCarOrderCell.h"

#import "LeftIconLabel.h"
#import "LeftTitleLabel.h"

@interface  GoodsCarOrderCell()
@property (nonatomic,strong) LeftIconLabel *topLabel;
@property (nonatomic,strong) LeftIconLabel *bottomLabel;
@property (nonatomic,strong) UIButton *buttonStatus;
@property (nonatomic,strong) UIButton *buttonNav;
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UILabel *goodsCarType;
@property (nonatomic,strong) UILabel *goodsNumber;
@property (nonatomic,strong) UIButton *peopleLabel;
@property (nonatomic,strong) UIButton *senderLabel;
@property (nonatomic,strong) UIImageView *peopleImageView;
@property (nonatomic,strong) UIImageView *senderImageView;
@property (nonatomic,strong) LeftIconLabel *startLabel;
@property (nonatomic,strong) LeftIconLabel *endLabel;
@property (nonatomic,strong) LeftIconLabel *fee;
@property (nonatomic,strong) LeftIconLabel *noteLabel;


@property (nonatomic,strong) UILabel *goodsNameLabel;
@property (nonatomic,strong) UILabel *goodsInfoLabel;

@end

@implementation GoodsCarOrderCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        [self initView];
    }
    return self;
}

- (void) initView
{
    _topLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_topLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_topLabel setImageUrl:@"icon_qidian_dot_3"];
    [_topLabel setTitleColor:RGBHex(g_black)];
    [self addSubview:_topLabel];
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(35);
    }];
    
    _bottomLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:_bottomLabel];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(5);
        make.width.mas_equalTo(200);
        make.height.equalTo(self);
    }];
    
    _buttonStatus = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonStatus.layer setCornerRadius:5];
    [_buttonStatus.layer setMasksToBounds:YES];
    [_buttonStatus.layer setBorderWidth:1];
    [_buttonStatus.layer setBorderColor:RGBHex(g_m_c).CGColor];
    [_buttonStatus setTitleColor:RGBHex(g_m_c) forState:UIControlStateNormal];
    [_buttonStatus.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_buttonStatus setUserInteractionEnabled:NO];
    [_buttonStatus setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [_buttonStatus addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonStatus];
    [_buttonStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.width.mas_lessThanOrEqualTo(130);
        make.width.mas_greaterThanOrEqualTo(100);
        make.height.mas_equalTo(30);
        make.right.equalTo(self).offset(-10);
    }];
    
    _buttonNav = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonNav setTag:2];
    [_buttonNav.layer setCornerRadius:5];
    [_buttonNav.layer setMasksToBounds:YES];
    [_buttonNav.layer setBorderWidth:1];
    [_buttonNav.layer setBorderColor:RGBHex(g_m_c).CGColor];
    [_buttonNav.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_buttonNav setTitleColor:RGBHex(g_m_c) forState:UIControlStateNormal];
    [_buttonNav setTitle:@"导航" forState:UIControlStateNormal];
    [_buttonNav setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [_buttonNav addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonNav];
    [_buttonNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
        make.right.equalTo(_buttonStatus.mas_left).offset(-10);
    }];
    
    _containerView = [[UIView alloc] init];
    [_containerView.layer setMasksToBounds:YES];
    [_containerView.layer setCornerRadius:5];
    [_containerView setBackgroundColor:RGBHex(g_assit_gray_eee)];
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buttonStatus.mas_bottom).offset(10);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    _goodsCarType = [[UILabel alloc] init];
    [_goodsCarType setText:@"拼货"];
    [_goodsCarType setFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_goodsCarType];
    [_goodsCarType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView).offset(5);
        make.left.equalTo(_containerView).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    
    _goodsNumber = [[UILabel alloc] init];
    [_goodsNumber setText:@"使用货位(1/6)"];
    [_goodsNumber setFont:[UIFont systemFontOfSize:13]];
    [_containerView addSubview:_goodsNumber];
    [_goodsNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView).offset(5);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    UIView *line =[[UIView alloc] init];
    [line setBackgroundColor:RGBHex(g_gray)];
    [_containerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsCarType.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    _peopleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone_hd"]];
    [_containerView addSubview:_peopleImageView];
    
    _senderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone_hd"]];
    [_containerView addSubview:_senderImageView];
    
    _peopleLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_peopleLabel setTitle:@"联系收货人:" forState:UIControlStateNormal];
    [_peopleLabel addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_peopleLabel.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_peopleLabel setBackgroundColor:RGBHex(g_m_c)];
    [_peopleLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [_peopleLabel.layer setCornerRadius:12];
    [_peopleLabel.layer setMasksToBounds:YES];
    [_containerView addSubview:_peopleLabel];
    
    [_peopleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView).offset(10);
        make.top.equalTo(line.mas_bottom).offset(10);
    }];
    [_senderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView).offset(10);
        make.top.equalTo(_peopleLabel.mas_bottom).offset(20);
    }];
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_peopleImageView.mas_right).offset(5);
        make.height.mas_equalTo(25);
        make.width.mas_greaterThanOrEqualTo(200);
        make.centerY.equalTo(_peopleImageView);
    }];
   
    _senderLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_senderLabel setTitle:@"发货人:" forState:UIControlStateNormal];
    [_senderLabel addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_senderLabel.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_senderLabel setBackgroundColor:RGBHex(g_m_c)];
    [_senderLabel setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [_senderLabel.layer setCornerRadius:12];
    [_senderLabel.layer setMasksToBounds:YES];
    [_containerView addSubview:_senderLabel];
    
    [_senderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_senderImageView.mas_right).offset(5);
        make.height.mas_equalTo(25);
        make.width.mas_greaterThanOrEqualTo(200);
        make.centerY.equalTo(_senderImageView);
    }];
    
    _startLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_startLabel setTitle:@"广州站"];
    [_startLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_startLabel setTitleColor:RGBHex(g_gray_54)];
    [_startLabel setImageUrl:@"icon_fahuo"];
    [_startLabel setImageW:13 withH:17];
    [_containerView addSubview:_startLabel];
    [_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView).offset(10);
        make.top.equalTo(_senderLabel.mas_bottom).offset(5);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_endLabel setTitle:@"广州站"];
    [_endLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_endLabel setTitleColor:RGBHex(g_gray_54)];
    [_endLabel setImageUrl:@"icon_shouhuo"];
    [_endLabel setImageW:13 withH:17];
    [_containerView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView).offset(10);
        make.top.equalTo(_startLabel.mas_bottom).offset(5);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    
    _goodsNameLabel = [[UILabel alloc] init];
    [_goodsNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_goodsNameLabel setFont:[UIFont systemFontOfSize:13]];
    [_goodsNameLabel setHidden:YES];
    [_containerView addSubview:_goodsNameLabel];
    [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    _goodsInfoLabel = [[UILabel alloc] init];
    [_goodsInfoLabel setFont:[UIFont systemFontOfSize:13]];
    [_goodsInfoLabel setTextAlignment:NSTextAlignmentCenter];
    [_containerView addSubview:_goodsInfoLabel];
    [_goodsInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    _noteLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_noteLabel setTitle:@""];
    [_noteLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_noteLabel setTitleColor:RGBHex(g_gray_54)];
    [_noteLabel setImageUrl:@"icon_pc_bei"];
//    [_noteLabel setImageW:13 withH:17];
    [_containerView addSubview:_noteLabel];
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView).offset(10);
        make.top.equalTo(_goodsInfoLabel.mas_bottom).offset(5);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    _fee = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_fee setTitle:@""];
    [_fee setTitleFont:[UIFont systemFontOfSize:13]];
    [_fee setTitleColor:[UIColor redColor]];
    [self addSubview:_fee];
    [_fee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_endLabel.mas_bottom);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    UIView *view =[[UIView alloc] init];
    [view setBackgroundColor:RGBHex(g_m_c)];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.equalTo(_topLabel.iconView.mas_bottom);
        make.left.equalTo(_topLabel.iconView.mas_centerX);
        make.bottom.equalTo(self);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) setModel:(OrderModel *)model
{
    _model = model;
    [_topLabel setTitle:_model.appointDate];
    [_peopleLabel setTitle:[NSString stringWithFormat:@"收货人:%@ %@",
                            _model.receiver,
                            _model.receiverPhone] forState:UIControlStateNormal];
    [_senderLabel setTitle:[NSString stringWithFormat:@"发货人:%@ %@",
                            @"",
                            _model.mPhoneNo] forState:UIControlStateNormal];
    
    [_bottomLabel setTitle:_model.lineName];
    [_startLabel setTitle:_model.slocation];
    [_endLabel setTitle:_model.elocation];
    [_fee setTitle:[NSString stringWithFormat:@"￥%@",_model.fee]];
    [_noteLabel setTitle:_model.descriptions];

    NSString *para = [NSString stringWithFormat:@"(%@/6)",_model.goodsNum];
    NSString *str = [NSString stringWithFormat:@"使用货位%@",para];
    NSMutableAttributedString *textAttribute = [[NSMutableAttributedString alloc] initWithString:str];
    [textAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, para.length)];
    [_goodsNumber setAttributedText:textAttribute];
    [_goodsCarType setText:[@"0" isEqualToString:model.chartered]?@"拼货":@"包车"];
    [_buttonStatus setTitle:[CommonUtility getDriverOrderDescription:_model.state] forState:UIControlStateNormal];
    if ([@"3" isEqualToString:_model.state] || [@"4" isEqualToString:_model.state] || [@"5" isEqualToString:_model.state]) {
        [_buttonStatus setUserInteractionEnabled:YES];
    }else {
        [_buttonStatus setUserInteractionEnabled:NO];
    }
    
    if ([@"2" isEqualToString:_model.state]||[@"3" isEqualToString:_model.state]||[@"5" isEqualToString:_model.state]) {
        //||[@"4" isEqualToString:_model.state]
        [_buttonNav setHidden:NO];
    }else{
        [_buttonNav setHidden:YES];
    }
    
    
//    NSString *goodname_str = [NSString stringWithFormat:@"%@",model.goodsName];
//    NSMutableAttributedString *tAttribute = [[NSMutableAttributedString alloc] initWithString:goodname_str];
//    [textAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, para.length)];
//    [_goodsNameLabel setAttributedText:tAttribute];
    
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

- (void) buttonTarget:(UIButton*)button
{
    if (button==_peopleLabel) {
        [CommonUtility callTelphone:_model.receiverPhone];
        return;
    }
    if (button==_senderLabel) {
        [CommonUtility callTelphone:_model.mPhoneNo];
        return;
    }
    if (button==_buttonNav) {
        if (_delegate &&[_delegate respondsToSelector:@selector(buttonTarget:withObj:)])
        {
            [_delegate buttonTarget:button withObj:_model];
        }
        return;
    }
    
    if (_delegate &&[_delegate respondsToSelector:@selector(buttonTarget:)])
    {
        [_delegate buttonTarget:_model];
    }
}

@end