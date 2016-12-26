//
//  EditCommiteCell.m
//  callmed
//
//  Created by sam on 16/8/19.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "EditCommiteCell.h"
#import "BrowerController.h"

@interface EditCommiteCell()
{
    UIButton *checkButton;
    BOOL isCheck;
}

@property (nonatomic,strong) UIButton *submit;

@end

@implementation EditCommiteCell


- (void) initView
{
    _submit =[UIButton buttonWithType:UIButtonTypeCustom];
    [_submit setTitle:@"确定提交并继续完善信息" forState:UIControlStateNormal];
    [_submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submit setBackgroundColor:RGBHex(g_red)];
    [_submit.layer setCornerRadius:20];
    [_submit.layer setMasksToBounds:YES];
    [_submit setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_red)] forState:UIControlStateNormal];
    [_submit setBackgroundImage:[ImageTools imageWithColor:RGBHex(g_gray)] forState:UIControlStateHighlighted];
    [_submit addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_submit];
    [_submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-5);
        make.height.mas_equalTo(40);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"同意《呼我服务条款》"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [button setAttributedTitle:str forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button.titleLabel setTextColor:RGBHex(g_red)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_submit.mas_top).offset(-10);
        make.centerX.equalTo(_submit).offset(10);
    }];
    
    checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:checkButton];

    [checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(button);
        make.right.equalTo(button.mas_left).offset(-10);
    }];
    isCheck = YES;
}
-(void)buttonClick:(id)sender{
    BrowerController *brower = [[BrowerController alloc] init];
    brower.titleStr =@"呼我服务条款";
    brower.urlStr = @"http://work.huwochuxing.com/getArticle?id=108";
    
    
    [[self getViewContro].navigationController pushViewController:brower animated:YES];
}
-(UIViewController *)getViewContro{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
-(void)checkButtonClick:(id)sender{
    isCheck = !isCheck;
    if (isCheck) {
        [checkButton setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateNormal];
    }else{
        [checkButton setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    }
    
}
- (void) buttonTarget:(id)sender
{
    if (!isCheck) {
        [MBProgressHUD showAndHideWithMessage:@"请勾选同意《呼我服务条款》" forHUD:nil];
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(buttonTarget:)]) {
            [_delegate buttonTarget:sender];
        }
    }
}

@end
