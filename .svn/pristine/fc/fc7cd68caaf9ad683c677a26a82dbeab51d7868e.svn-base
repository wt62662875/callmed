//
//  CarStatusCell.m
//  callmed
//
//  Created by sam on 16/7/27.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CarStatusCell.h"

@interface CarStatusCell()

@property (nonatomic,strong) UIButton *buttonStatus;
@property (nonatomic,strong) UIImageView *backImage;

@property (nonatomic,strong) UIImageView *carImage;
@property (nonatomic,strong) UILabel *carLabel;

@end

@implementation CarStatusCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView
{
    _backImage = [[UIImageView alloc]init];
    [self addSubview:_backImage];
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(-5);
    }];
    
    _carImage = [[UIImageView alloc]init];
    [self addSubview:_carImage];
    [_carImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(_backImage);
    }];
    
    _carLabel = [[UILabel alloc]init];
    _carLabel.textColor = [UIColor whiteColor];
    _carLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_carLabel];
    [_carLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_carImage.mas_right).offset(10);
        make.centerY.equalTo(_backImage);
    }];

    
    
    _buttonStatus=[UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonStatus.layer setCornerRadius:20];
    [_buttonStatus.layer setMasksToBounds:YES];
    [_buttonStatus.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_buttonStatus.layer setBorderWidth:1];
    [_buttonStatus.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_buttonStatus setUserInteractionEnabled:NO];
    [self.buttonStatus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self addSubview:_buttonStatus];
    [_buttonStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backImage);
        make.right.equalTo(self).offset(-30);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void) setModel:(CarStatusModel *)model
{
    _model = model;

    if ([_model.type isEqualToString:@"1"]) {
        [_backImage setImage:[UIImage imageNamed:@"huangbian"]];
    }else{
        [_backImage setImage:[UIImage imageNamed:@"lanbian"]];
    }
    [_carLabel setText:model.title];
    
    [_carImage setImage:[UIImage imageNamed:model.imageUrl]];
    if (0 ==_model.status) {
        [self.buttonStatus setTitle:@"出车" forState:UIControlStateNormal];
        [self.buttonStatus setBackgroundColor:[UIColor clearColor]];
        [_buttonStatus.layer setBorderWidth:1];

    }else{
        [self.buttonStatus setTitle:@"收车" forState:UIControlStateNormal];
        if ([_model.type isEqualToString:@"1"]) {
            [self.buttonStatus setBackgroundColor:RGBHex(g_yellow)];
        }else{
            [self.buttonStatus setBackgroundColor:RGBHex(g_blue)];
        }
        [_buttonStatus.layer setBorderWidth:0];

    }
    
}

@end
