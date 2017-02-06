//
//  PhotoTitleView.m
//  callmed
//
//  Created by sam on 16/7/26.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "PhotoTitleView.h"


@interface PhotoTitleView()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
@end

@implementation PhotoTitleView

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
    [self setHidden:YES];
    _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DF_img"]];
    [_iconImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(5,5,5,5));
    }];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel];
    [_titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_titleLabel setTextColor:RGBHex(g_gray_99)];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_iconImageView);
        make.width.equalTo(self).multipliedBy(0.8);
        make.top.equalTo(self.mas_centerY).offset(20);
    }];
    

}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:_title];
    [self setHidden:NO];
}

- (void) setImageUrl:(NSString *)imageUrl
{
    if (imageUrl && [imageUrl hasPrefix:@"https"]) {
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"DF_img"]];
    }else{
        [_iconImageView setImage:[UIImage imageNamed:@"DF_img"]];
    }
}

- (void) setImageData:(UIImage *)imageData
{
    _imageData = imageData;
    [_iconImageView setImage:imageData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{
 
}
*/
- (void) setIndicatorHidden:(BOOL)indicatorHidden
{
    _indicatorHidden = indicatorHidden;
    if (_indicatorHidden && _indicatorView) {
        [_indicatorView stopAnimating];
        _indicatorView = nil;
    }else{
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_indicatorView setColor:[UIColor redColor]];
        [_indicatorView startAnimating];
        [_indicatorView stopAnimating];
        [_indicatorView setHidesWhenStopped:YES];
        [self addSubview:_indicatorView];
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_iconImageView);
            make.height.width.mas_equalTo(40);
        }];
        [_indicatorView startAnimating];
    }
}

@end
