//
//  RightTitleLabel.m
//  callmec
//
//  Created by sam on 16/7/16.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "LeftTitleLabel.h"



@interface LeftTitleLabel ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIView *bottomLine;
@end

@implementation LeftTitleLabel


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
    _titleLabel =[[UILabel alloc] init];
    [_titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    _contentLabel = [[UILabel alloc] init];
    [_contentLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];
    
    _bottomLine =[[UIView alloc] init];
    [_bottomLine setBackgroundColor:RGBHex(g_gray)];
    [_bottomLine setHidden:YES];
    [self addSubview:_bottomLine];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];
}


- (void) setTitle:(NSString *)title
{
    [_titleLabel setText:title];
}

- (void) setContent:(NSString *)content
{
    [_contentLabel setText:content];
}

- (void) setContentColor:(UIColor *)contentColor
{
    _contentColor = contentColor;
    [_contentLabel setTextColor:_contentColor];
}

- (void) setHiddenLine:(BOOL)hiddenLine
{
    _hiddenLine = hiddenLine;
    [_bottomLine setHidden:hiddenLine];
}

- (void)setLayout:(AlginLayout)layout
{
    _layout = layout;
    if (_layout==ALginLayoutLeft) {
        [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_right).offset(10);
            make.centerY.equalTo(self);
        }];
    }else if(_layout == ALginLayoutRight)
    {
        [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(self);
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
