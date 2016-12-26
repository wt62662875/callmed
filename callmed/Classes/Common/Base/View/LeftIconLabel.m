//
//  LeftIconLabel.m
//  callmec
//
//  Created by sam on 16/7/23.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "LeftIconLabel.h"

@interface LeftIconLabel()


@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation LeftIconLabel


- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView
{
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_time"]];
    [self addSubview:_iconView];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(0);
        make.width.height.mas_equalTo(15);
    }];
    
    
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setTextColor:RGBHex(g_black)];
    [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(_iconView.mas_right).offset(5);
        make.right.equalTo(self);
        make.centerY.equalTo(self);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [_iconView setImage:[UIImage imageNamed:_imageUrl]];
}

- (void) setImageUrl:(NSString *)imageUrl withDefault:(NSString*)defalt withCircle:(BOOL)isCircle
{
    if ([imageUrl hasPrefix:@"http://"]) {
        if (isCircle) {
            [_iconView sd_setCircleImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:defalt]];
        }else{
            [_iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:defalt]];
        }
    }else{
        [self setImageUrl:imageUrl];
    }
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:_title];
}

- (void) setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [_titleLabel setFont:_titleFont];
}

- (void) setImageH:(CGFloat)imageH
{
    _imageH = imageH;
    [_iconView.layer setCornerRadius:_imageH/2];
    [_iconView.layer setMasksToBounds:YES];
    [_iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(_imageH);
    }];
}

- (void) setPadding:(CGFloat)padding
{
    _padding = padding;
    
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(_iconView.mas_right).offset(_padding);
        make.right.equalTo(self);
        make.centerY.equalTo(self);
    }];
}

- (void) setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [_titleLabel setTextColor:_titleColor];
}

- (void) setImageW:(CGFloat)w withH:(CGFloat)h
{
    [_iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(h);
        make.width.mas_equalTo(w);
    }];
}

- (void) setTitleAttribute:(NSMutableAttributedString *)titleAttribute
{
    _titleAttribute = titleAttribute;
    [_titleLabel setAttributedText:titleAttribute];
}
@end
