//
//  MultiplePhotoView.m
//  callmed
//
//  Created by sam on 16/7/26.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "MultiplePhotoView.h"
#import "PhotoTitleView.h"


@interface MultiplePhotoView()

@property (nonatomic,strong) PhotoTitleView *imageView1;
@property (nonatomic,strong) PhotoTitleView *imageView2;
@property (nonatomic,strong) PhotoTitleView *imageView3;
@property (nonatomic,strong) PhotoTitleView *imageView4;
@property (nonatomic,strong) PhotoTitleView *imageView5;
@property (nonatomic,strong) PhotoTitleView *imageView6;
@property (nonatomic,strong) PhotoTitleView *imageView7;
@property (nonatomic,strong) PhotoTitleView *imageView8;
@end

@implementation MultiplePhotoView

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
    for (int i=0;i<8;i++)
    {
        PhotoTitleView *view = [[PhotoTitleView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        view.tag = i+100;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *g1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
        g1.numberOfTapsRequired = 1;
        g1.numberOfTouchesRequired = 1;
        [view addGestureRecognizer:g1];
        
        [self bindView:view withTag:i+100];
        [self addSubview:view];
    }
    
    //line1
    [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.mas_width).multipliedBy(0.67*0.5);
    }];
    [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(_imageView1.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(self.imageView1.mas_width).multipliedBy(0.67);
    }];
    
    //line2
    [_imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView1.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self.mas_centerX);
        make.height.equalTo(self.imageView1.mas_width).multipliedBy(0.67);
    }];
    [_imageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView1.mas_bottom);
        make.left.equalTo(_imageView3.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(self.imageView1.mas_width).multipliedBy(0.67);
    }];
    
    //line3
    [_imageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView3.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self.mas_centerX);
        make.height.equalTo(self.imageView1.mas_width).multipliedBy(0.67);
    }];
    [_imageView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView3.mas_bottom);
        make.left.equalTo(_imageView5.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(self.imageView1.mas_width).multipliedBy(0.67);
    }];
    
    //line4
    [_imageView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView5.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self.mas_centerX);
        make.height.equalTo(self.imageView1.mas_width).multipliedBy(0.67);
    }];
    [_imageView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView5.mas_bottom);
        make.left.equalTo(_imageView3.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(self.imageView1.mas_width).multipliedBy(0.67);
    }];
}

- (void) setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    for (int i =0;i<_dataArray.count;i++) {
        NSString *title = _dataArray[i];
        PhotoTitleView *view = [self viewWithTag:i+100];
        if (view&&[view isKindOfClass:[PhotoTitleView class]]) {
            [view setTitle:title];
        }
    }
    [self layoutIfNeeded];
}

- (void)bindView:(PhotoTitleView*)view withTag:(NSInteger)tag
{
    if (tag==100) {
        _imageView1 = view;
        
    }else if(tag==101)
    {
        _imageView2 = view;
        
    }else if(tag==102)
    {
        _imageView3 = view;
        
    }else if(tag==103)
    {
        _imageView4 = view;
        
    }else if(tag==104)
    {
        _imageView5 = view;
        
    }else if(tag==105)
    {
        _imageView6 = view;
        
    }else if(tag==106)
    {
        _imageView7 = view;
        
    }else if(tag==107)
    {
        _imageView8 = view;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) gesture:(UITapGestureRecognizer*)g
{
    if (_delegate && [_delegate respondsToSelector:@selector(buttonTarget:)])
    {
        [_delegate buttonTarget:g.view];
    }
}

@end
