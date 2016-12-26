//
//  CenterRadioCell.m
//  callmed
//
//  Created by sam on 16/9/27.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CenterRadioCell.h"
#import "BaseItemModel.h"

@interface CenterRadioCell()

@property (nonatomic,strong) UILabel *lb_name_v;
@property (nonatomic,strong) UISwitch *buttonS;
@end

@implementation CenterRadioCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) initView
{
    [self initSpeaker];
}
- (void) setModel:(BaseItemModel *)model
{
    [super setModel:model];
    [self.lb_name_v setText:model.title];
    [_buttonS setOn:model.hasMore animated:YES];
}
- (void) initSpeaker
{
    if (!_lb_name_v) {
        _lb_name_v = [[UILabel alloc] init];
    }
    [self addSubview:_lb_name_v];
    [_lb_name_v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-30);
    }];
    
    [self.lb_name_v setTextColor:RGBHex(g_assit_c)];
    [self.lb_name_v setFont:[UIFont systemFontOfSize:14]];
    UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 100, 30)];
    [button setBackgroundColor:[UIColor redColor]];
    
    
    _buttonS = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    _buttonS.onTintColor = RGBHex(g_blue);
    [_buttonS setOnImage:[UIImage imageNamed:@"img_on"]];
    [_buttonS setOffImage:[UIImage imageNamed:@"img_off"]];
    [_buttonS addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = _buttonS;
}

- (void) buttonTarget:(UIButton*)btn
{
    if (_delegate&&[_delegate respondsToSelector:@selector(buttonTarget:)]) {
        [_delegate buttonTarget:btn];
    }
}

- (void) valueChanged:(UISwitch*)sender
{
    [SandBoxHelper setVoiceStatus:sender.on];
}
@end