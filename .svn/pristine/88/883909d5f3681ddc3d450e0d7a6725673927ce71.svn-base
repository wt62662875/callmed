//
//  EditPhotoCell.m
//  callmed
//
//  Created by sam on 16/8/19.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "EditPhotoCell.h"



@interface EditPhotoCell()

@property (nonatomic,strong) UIImageView *leftView;
@property (nonatomic,strong) UIImageView *rightView;

@property (nonatomic,strong) UIImageView *threeView;
@property (nonatomic,strong) UIImageView *fourView;
@end

@implementation EditPhotoCell

- (void) initView
{
    [self setBackgroundColor:RGBHex(g_assit_gray_eee)];
    UIImage *image = [UIImage imageNamed:@"DF_img"];
    _leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DF_img"]];
    [_leftView setContentMode:UIViewContentModeScaleAspectFit|UIViewContentModeScaleToFill];
    [self addSubview:_leftView];
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self.mas_centerX).offset(-2.5);
        make.height.mas_equalTo(image.size.height);
    }];
    
    _rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DF_img"]];
    [_rightView setContentMode:UIViewContentModeScaleAspectFit|UIViewContentModeScaleToFill];
    [self addSubview:_rightView];
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self.mas_centerX).offset(2.5);
        make.right.equalTo(self).offset(-5);
        make.height.mas_equalTo(image.size.height);
    }];
    
    
    _threeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DF_img"]];
    [_threeView setContentMode:UIViewContentModeScaleAspectFit|UIViewContentModeScaleToFill];
    [self addSubview:_threeView];
    [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftView.mas_bottom).offset(5);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self.mas_centerX).offset(-2.5);
        make.height.mas_equalTo(image.size.height);
    }];
    
    _fourView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DF_img"]];
    [_fourView setContentMode:UIViewContentModeScaleAspectFit|UIViewContentModeScaleToFill];
    [self addSubview:_fourView];
    [_fourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftView.mas_bottom).offset(5);
        make.left.equalTo(self.mas_centerX).offset(2.5);
        make.right.equalTo(self).offset(-5);
        make.height.mas_equalTo(image.size.height);
    }];
}

- (void) setModel:(BaseModel *)model
{
    if (![GlobalData sharedInstance].user.isLogin) {
        return;
    }
    NSString *ids = [GlobalData sharedInstance].user.userInfo.ids;
    [_leftView sd_setImageWithURL:[NSURL URLWithString:[CommonUtility driverPictureUrl:ids withType:@"1"]] placeholderImage:[UIImage imageNamed:@"DF_img"]];
    [_rightView sd_setImageWithURL:[NSURL URLWithString:[CommonUtility driverPictureUrl:ids withType:@"2"]] placeholderImage:[UIImage imageNamed:@"DF_img"]];
    [_threeView sd_setImageWithURL:[NSURL URLWithString:[CommonUtility driverPictureUrl:ids withType:@"3"]] placeholderImage:[UIImage imageNamed:@"DF_img"]];
    [_fourView sd_setImageWithURL:[NSURL URLWithString:[CommonUtility driverPictureUrl:ids withType:@"4"]] placeholderImage:[UIImage imageNamed:@"DF_img"]];
}

@end
