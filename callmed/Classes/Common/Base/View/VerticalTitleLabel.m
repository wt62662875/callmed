//
//  VerticalTitleLabel.m
//  callmed
//
//  Created by sam on 16/7/20.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "VerticalTitleLabel.h"

@interface VerticalTitleLabel()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView * imageView;

@end

@implementation VerticalTitleLabel

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
    _imageView = [[UIImageView alloc]init];
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.centerX.equalTo(self);
//        make.width.equalTo(self);
//        make.bottom.equalTo(self.mas_centerY).offset(-5);
    }];
    
    _titleLabel =[[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).offset(5);
        make.centerX.equalTo(self);
        make.width.equalTo(self);
//        make.bottom.equalTo(self.mas_centerY).offset(-5);
    }];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.textColor = RGBHex(@"#999999");
    
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.centerX.equalTo(self);
//        make.bottom.equalTo(self);
        make.width.equalTo(self);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) setImageName:(NSString *)imageName{
    _imageName = imageName;
    [_imageView setImage:[UIImage imageNamed:imageName]];
//    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_imageView.mas_bottom).offset(5);
//        make.centerX.equalTo(self);
//        make.width.equalTo(self);
//        make.bottom.equalTo(self.mas_centerY).offset(-5);
//    }];
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:title];
}

- (void) setContent:(NSString *)content
{
    _content = content;
    [_contentLabel setText:_content];
}

- (void) setContentColor:(UIColor *)contentColor
{
    _contentColor = contentColor;
    [_contentLabel setTextColor:_contentColor];
}

- (void) setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [_titleLabel setTextColor:_titleColor];
}

- (void) setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [_titleLabel setFont:_titleFont];
}

- (void) setContentFont:(UIFont *)contentFont
{
    _contentFont = contentFont;
    [_contentLabel setFont:_contentFont];
}

- (void) setPaddingTop:(CGFloat)paddingTop
{
    _paddingTop = paddingTop;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(_paddingTop);
    }];
}

- (void) setPaddingBottom:(CGFloat)paddingBottom
{
    _paddingBottom = paddingBottom;
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(_paddingBottom);
    }];
}

- (void) setPaddingMiddle:(CGFloat)paddingMiddle
{
    _paddingMiddle = paddingMiddle;
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(_paddingMiddle);
    }];
}

- (void) setContentRate:(CGFloat)contentRate
{
    _contentRate = contentRate;

    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self).multipliedBy(_contentRate);
    }];
}


- (void) setTitleRate:(CGFloat)titleRate
{
    _titleRate = titleRate;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self).multipliedBy(_titleRate);
    }];
}

- (void) setTitleAlignment:(NSTextAlignment)titleAlignment
{
    _titleAlignment = titleAlignment;
    [_titleLabel setTextAlignment:_titleAlignment];
}

- (void) setContentAlignment:(NSTextAlignment)contentAlignment
{
    _contentAlignment = contentAlignment;
    [_contentLabel setTextAlignment:_titleAlignment];
}

- (void) setTitleAlpha:(CGFloat)titleAlpha
{
    _titleAlpha = titleAlpha;
    [_titleLabel setAlpha:_titleAlpha];
}

- (void) setContentAlpha:(CGFloat)contentAlpha
{
    _contentAlpha = contentAlpha;
    [_contentLabel setAlpha:_contentAlpha];
}
@end
