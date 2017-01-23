//
//  TripScrollerView.m
//  callmec
//
//  Created by sam on 16/7/7.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "TripScrollerView.h"
#import "TripTypeModel.h"

@interface TripScrollerView()

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIView *redlineView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIImageView *backImageView2;

@property (nonatomic,strong) NSMutableArray *array;
@end

@implementation TripScrollerView

- (instancetype) initWithFrame:(CGRect)frame selected:(NSInteger)index
{
    _selectIndex = index;
    self = [super initWithFrame:frame];
    _array = [NSMutableArray array];
    return self;
}

- (void) setDataArray:(NSArray *)dataArray
{
    [_array removeAllObjects];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    _lineView = [[UIView alloc] init];
    [_lineView setBackgroundColor:RGBHex(g_gray)];
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
        make.left.equalTo(self);
        make.width.equalTo(self);
    }];
    
//    _redlineView = [[UIView alloc] init];
//    [_redlineView setBackgroundColor:RGBHex(g_red)];
//    [self addSubview:_redlineView];
//    [_redlineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self);
//        make.height.mas_equalTo(2);
//        make.left.equalTo(self);
//        //        make.width.equalTo(self).dividedBy(4);
//        make.width.mas_equalTo(kScreenSize.width/4);
//    }];
    
    _dataArray = dataArray;
    UIButton *btn_old;
    _backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"huangseyuan"]];
    [self addSubview:_backImageView];
    _backImageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xin圆角矩形-6"]];
    [self addSubview:_backImageView2];
    for (int i = 0;i<_dataArray.count;i++)
    {

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn.titleLabel setText:_dataArray[i]];
        [btn setTitle:_dataArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGBHex(g_blue) forState:UIControlStateNormal];
        [btn setTitleColor:RGBHex(g_red) forState:UIControlStateHighlighted];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        UILabel *tipLabel = [[UILabel alloc] init];
        [tipLabel setBackgroundColor:[UIColor redColor]];
        [tipLabel.layer setMasksToBounds:YES];
        [tipLabel setText:@"1"];
        [tipLabel setTextColor:[UIColor whiteColor]];
        [tipLabel.layer setCornerRadius:8];
        [tipLabel setFont:[UIFont systemFontOfSize:8]];
        [tipLabel setTextAlignment:NSTextAlignmentCenter];
        [tipLabel setHidden:YES];
        [self addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn).offset(-5);
            make.left.equalTo(btn.mas_centerX).offset(20);
            make.height.width.mas_equalTo(16);
        }];
        [_array addObject:tipLabel];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self);
            if (!btn_old)
            {
                make.left.equalTo(self);
            }else{
                make.left.equalTo(btn_old.mas_right);
            }
            make.width.mas_equalTo(kScreenSize.width/2);
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(-2);
        }];
        
        if (i == 0) {
            [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(btn);
                make.centerY.equalTo(btn);
            }];
        }else if(i == 1){
            [_backImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(btn);
                make.centerY.equalTo(btn);
            }];
        }
       
        NSLog(@"%d",_selectIndex);
        if (_selectIndex==i) {
            if(i == 0){
                [btn setTitleColor:RGBHex(g_yellow) forState:UIControlStateNormal];
            }
            _backImageView.hidden = YES;
            _backImageView2.hidden = NO;

//            [btn setBackgroundImage:[UIImage imageNamed:@"yuanjiao6"] forState:UIControlStateNormal];
            
            /*
             [_redlineView mas_updateConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self).offset(kScreenSize.width*0.25*i);
             }];
             */
//            [_redlineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(self);
//                make.height.mas_equalTo(2);
//                make.left.equalTo(btn);
//                NSLog(@"self.frame.size.width:%f %f",self.frame.size.width,kScreenSize.width);
//                make.width.mas_equalTo(kScreenSize.width/2);
//            }];
        }else{
            [btn setTitleColor:RGBHex(g_black) forState:UIControlStateNormal];
            _backImageView.hidden = NO;
            _backImageView2.hidden = YES;
//            [btn setBackgroundImage:nil forState:UIControlStateNormal];
        }
        btn_old = btn;
    }
}



- (void) buttonTarget:(UIButton*)sender
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton*)view;
            if (sender!=view) {
                [btn setTitleColor:RGBHex(g_black) forState:UIControlStateNormal];
                _backImageView.hidden = NO;
                _backImageView2.hidden = YES;
                //                [btn setBackgroundImage:nil forState:UIControlStateNormal];
            }else{
                if (btn.tag == 0) {
                    [btn setTitleColor:RGBHex(g_yellow) forState:UIControlStateNormal];
                }else{
                    [btn setTitleColor:RGBHex(g_blue) forState:UIControlStateNormal];
                }
                _backImageView.hidden = YES;
                _backImageView2.hidden = NO;
                //                [btn setBackgroundImage:[UIImage imageNamed:@"yuanjiao6"] forState:UIControlStateNormal];
            }
        }
    }
    
    NSInteger tag = sender.tag;
    [self startAnimation:sender withTag:tag];
    if (_delegate && [_delegate respondsToSelector:@selector(buttonSelectedIndex:)])
    {
        [_delegate buttonSelectedIndex:tag];
    }else if(_delegate && [_delegate respondsToSelector:@selector(buttonTarget:)])
    {
        [_delegate buttonTarget:sender];
    }
}

- (void) startAnimation:(UIView*)view withTag:(NSInteger)tag
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_redlineView cache:YES];
    [UIView setAnimationDuration:0.3];
    
    // 设置要变化的frame 推入与推出修改对应的frame即可
    [UIView commitAnimations];
    // 执行动画
    if (_redlineView) {
        [_redlineView setNeedsUpdateConstraints];
        [_redlineView updateConstraintsIfNeeded];
        [_redlineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.height.mas_equalTo(2);
            make.left.equalTo(view);
            make.width.mas_equalTo(kScreenSize.width/2);
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            [self layoutIfNeeded];
        }];
    }
}

- (void) setSelectIndex:(NSInteger)selectIndex
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton*)view;
            if (selectIndex == 0) {
                if (btn.tag == 0) {
                    [btn setTitleColor:RGBHex(g_yellow) forState:UIControlStateNormal];
                }else{
                    [btn setTitleColor:RGBHex(g_black) forState:UIControlStateNormal];
                }
                _backImageView.hidden = NO;
                _backImageView2.hidden = YES;
                //                [btn setBackgroundImage:nil forState:UIControlStateNormal];
            }else{
                if (btn.tag == 0) {
                    [btn setTitleColor:RGBHex(g_black) forState:UIControlStateNormal];
                }else{
                    [btn setTitleColor:RGBHex(g_blue) forState:UIControlStateNormal];
                }
                _backImageView.hidden = YES;
                _backImageView2.hidden = NO;
                //                [btn setBackgroundImage:[UIImage imageNamed:@"yuanjiao6"] forState:UIControlStateNormal];
            }
        }
    }
    _selectIndex = selectIndex;
    //    [self startAnimation:_redlineView withTag:selectIndex];
    if (_delegate && [_delegate respondsToSelector:@selector(buttonSelectedIndex:)])
    {
        [_delegate buttonSelectedIndex:selectIndex];
    }else if(_delegate && [_delegate respondsToSelector:@selector(buttonTarget:)])
    {
        [_delegate buttonTarget:nil];
    }
}
- (void) updateRedBobble:(NSInteger)index withNumber:(NSInteger)number
{
    UILabel *tipLabel= _array[index];
    if (tipLabel) {
        if (number>0 && number<99) {
            [tipLabel setText:[NSString stringWithFormat:@"%ld",(long)number]];
            [tipLabel setHidden:NO];
        }else if(number>99){
            [tipLabel setText:[NSString stringWithFormat:@"99+"]];
            [tipLabel setHidden:NO];
        }else{
            [tipLabel setText:[NSString stringWithFormat:@"%ld",(long)number]];
            [tipLabel setHidden:YES];
        }
    }
}
@end
