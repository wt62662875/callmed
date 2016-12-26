//
//  RightIconView.m
//  callmec
//
//  Created by sam on 16/7/21.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "LeftInputView.h"

@interface LeftInputView ()
@property (nonatomic,strong) UIImageView *leftIcon;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextField *contentLabel;
@property (nonatomic,strong) UIImageView *rightIcon;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UILabel *tailLabel;
@end

@implementation LeftInputView


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
    _leftIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_time"]];
    [self addSubview:_leftIcon];
    
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.height.equalTo(self.mas_height);
    }];
    
    _titleLabel=[[UILabel alloc] init];
    [self addSubview:_titleLabel];
//    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_leftIcon.mas_right);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    _contentLabel = [[UITextField alloc] init];
    [_contentLabel addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    [_contentLabel setTextColor:RGBHex(g_black)];
    UITapGestureRecognizer *g1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTarget:)];
    g1.numberOfTapsRequired= 1;
    g1.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:g1];
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_titleLabel.mas_right).offset(0);
        make.height.equalTo(self);
        make.right.equalTo(self).offset(-10);
    }];
    
    _rightIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrpw"]];
    [self addSubview:_rightIcon];
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15);
        make.width.height.mas_equalTo(15);
    }];
    
    _tailLabel = [[UILabel alloc] init];
    [self addSubview:_tailLabel];
    [_tailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(20);
    }];
    
    _bottomLine = [[UIView alloc] init];
    [_bottomLine setBackgroundColor:RGBHex(g_assit_gray)];
    [self addSubview:_bottomLine];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self).offset(-1);
        make.left.equalTo(_contentLabel);
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
    [_leftIcon setImage:[UIImage imageNamed:_imageUrl]];
    
    [_leftIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(_leftIcon.mas_height);
        
    }];
}

- (void) setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    [_contentLabel setPlaceholder:_placeHolder];
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    if (_title) {
        if (_titleFont) {
            
        }
    }
    [_titleLabel setText:_title];
}

- (void) setEnable:(BOOL)enable
{
    [_contentLabel setEnabled:enable];
}

- (void) buttonTarget:(UITapGestureRecognizer*)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(buttonTarget:)])
    {
        [_delegate buttonTarget:sender.view];
    }
}

- (void)valueChanged:(UITextField*)text
{
    _content = text.text;
    if (_delegate && [_delegate respondsToSelector:@selector(valueChanged:)]) {
        [_delegate valueChanged:self];
    }
}

- (void) setHiddenIcon:(BOOL)hiddenIcon
{
    _hiddenIcon = hiddenIcon;
    [_leftIcon setHidden:_hiddenIcon];
    if (_hiddenIcon) {
        [_leftIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(1);
        }];
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(30);
        }];
    }else{
        [_leftIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.centerY.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-10);
            make.width.equalTo(_leftIcon.mas_height);
        }];
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftIcon.mas_right).offset(10);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
    }
}

- (void) setHiddenTitle:(BOOL)hiddenTitle
{
    _hiddenTitle = hiddenTitle;
    [_titleLabel setHidden:_hiddenTitle];
    if (_hiddenTitle) {
        [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
        }];
    }else{
        [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_right).offset(10);
        }];
    }
}

- (void) setTailText:(NSString *)tailText
{
    _tailText = tailText;
    if (_tailText && [_tailText length]>0) {
        [_rightIcon setHidden:YES];
        [_tailLabel setHidden:NO];
        [_tailLabel setText:_tailText];
    }else{
        [_rightIcon setHidden:NO];
        [_tailLabel setHidden:YES];
    }
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

- (void) setTailFont:(UIFont *)tailFont
{
    _tailFont = tailFont;
    [_tailLabel setFont:_tailFont];
}

- (void) setKeyBoardType:(UIKeyboardType)keyBoardType
{
    _keyBoardType = keyBoardType;
    _contentLabel.keyboardType = _keyBoardType;
}

@end
