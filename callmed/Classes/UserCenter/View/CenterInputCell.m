//
//  CenterInputCell.m
//  callmed
//
//  Created by sam on 16/9/27.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CenterInputCell.h"

#import "BaseItemModel.h"

@interface CenterInputCell()

@property (nonatomic,strong) UIImageView *iconHeaderView;
@property (nonatomic,strong) UILabel *lb_name_v;
@property (nonatomic,strong) UIView *grayLine;
@property (nonatomic,strong) UITextField *inputText;
@property (nonatomic,strong) UIButton *buttonSubmit;
@end
@implementation CenterInputCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) initView
{
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    if (!_lb_name_v) {
        _lb_name_v = [[UILabel alloc] init];
    }
    [self addSubview:_lb_name_v];
    [_lb_name_v mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(100);
    }];
    
    [self.lb_name_v setTextColor:RGBHex(g_assit_c)];
    [self.lb_name_v setFont:[UIFont systemFontOfSize:14]];
    
    _inputText = [[UITextField alloc] init];
    [_inputText setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:_inputText];
    
    _buttonSubmit =[UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonSubmit setTitle:@"保存" forState:UIControlStateNormal];
    [_buttonSubmit.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_buttonSubmit setTitleColor:RGBHex(g_black) forState:UIControlStateNormal];
    [self addSubview:_buttonSubmit];
    [_inputText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lb_name_v.mas_right);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.right.equalTo(_buttonSubmit.mas_left).offset(-1);
    }];
    [_buttonSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-25);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(60);
        make.height.equalTo(self);
    }];
    [_buttonSubmit addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_inputText addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void) setModel:(BaseModel *)model
{
    [super setModel:model];
    InputModel *md = (InputModel*)model;
    if (md.hasMore) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self.lb_name_v setText:md.title?md.title:@""];
    if (md.hasButton && md.hasMore) {
        [_buttonSubmit setHidden:NO];
        [_inputText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lb_name_v.mas_right);
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
            make.right.equalTo(_buttonSubmit.mas_left).offset(-1);
        }];
    }else{
        [_buttonSubmit setHidden:YES];
        [_inputText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lb_name_v.mas_right);
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
            make.right.equalTo(self).offset(-30);
        }];
    }
    [_inputText setText:md.value];
    [_inputText setEnabled:md.hasMore];
    [_inputText setPlaceholder:md.placeHolder];
}

- (void) textValueChanged:(UITextField*)text
{
    ((BaseItemModel*)self.model).value = text.text;
}

- (void) buttonTarget:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(buttonTarget:)]) {
        [_delegate buttonTarget:self.model];
    }
}
@end
