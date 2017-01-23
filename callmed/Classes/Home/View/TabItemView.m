//
//  TabItemView.m
//  callmed
//
//  Created by sam on 16/7/18.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "TabItemView.h"



@interface TabItemView()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation TabItemView

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
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_icon_1"]];
    [self addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.height.width.mas_equalTo(20);
        make.centerX.equalTo(self);
    }];
    
    _titleLabel =[[UILabel alloc] init];
    [_titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_iconView.mas_bottom);
        make.width.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:_title];
}

- (void) setImageUrlNormal:(NSString *)imageUrlNormal
{
    _imageUrlNormal = imageUrlNormal;
    [_iconView setImage:[UIImage imageNamed:_imageUrlNormal]];
}

- (void) setImageUrlSelect:(NSString *)imageUrlSelect
{
    _imageUrlSelect = imageUrlSelect;
    if (_isSelected) {
        [_iconView setImage:[UIImage imageNamed:_imageUrlSelect]];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (_isSelected) {
        [_iconView setImage:[UIImage imageNamed:_imageUrlSelect]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
    }else{
        [_iconView setImage:[UIImage imageNamed:_imageUrlNormal]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
    }
}

@end
