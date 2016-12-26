//
//  UserInfoCell.m
//  callmec
//
//  Created by sam on 16/6/25.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "UserInfoCell.h"
#import "BaseItemModel.h"


@interface UserInfoCell()

@property (nonatomic,strong) UIImageView *iconHeaderView;
@property (nonatomic,strong) UILabel *lb_name_v;
@property (nonatomic,strong) UIButton *bt_login_v;
@property (nonatomic,strong) UIView *grayLine;
@property (nonatomic,strong) UITextField *inputText;
@end

@implementation UserInfoCell

- (void) setModel:(BaseItemModel *)model
{
    [super setModel:model];
    if (model.isCanSelected)
    {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }else{
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([model isKindOfClass:[UserItemModel class]]) {
        [self initHeadeView:(UserItemModel*)model];
    }else if([model isKindOfClass:[FunctionModel class]])
    {
        [self initFunction:(FunctionModel*)model];
    }else if([model isKindOfClass:[SpeakerModel class]]){
        [self initSpeaker:model];
    }else if([model isKindOfClass:[InputModel class]]){
        [self initInput:model];
    }else{
        [self initDefault:model];
    }
    if (model.hasMore) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        if (model.index==0) {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

- (void) initHeadeView:(UserItemModel*)model
{
    [self clearAllView];
    [self setBackgroundColor:RGBHex(g_m_c)];
    if (!_iconHeaderView) {
        _iconHeaderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_userss"]];
    }
    [_iconHeaderView sd_setCircleImageWithURL:model.icons placeholderImage:[UIImage imageNamed:@"icon_userss"]];
    
    
    [self addSubview:_iconHeaderView];
    [_iconHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.height.mas_equalTo(50);
    }];
    
    if (!_lb_name_v) {
        _lb_name_v = [[UILabel alloc] init];
    }
    [self addSubview:_lb_name_v];
    [_lb_name_v setFont:[UIFont systemFontOfSize:15]];
    [_lb_name_v setTextColor:[UIColor whiteColor]];
    
    
    [_lb_name_v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_iconHeaderView.mas_right).offset(10);
        make.height.mas_greaterThanOrEqualTo(20);
    }];
    
    
    if (!_bt_login_v) {
        _bt_login_v = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [self addSubview:_bt_login_v];
    if ([GlobalData sharedInstance].user.isLogin) {
        
        UserInfoModel *models = [GlobalData sharedInstance].user.userInfo;
        NSLog(@"phone:%@",[GlobalData sharedInstance].user.userInfo.phoneNo);
        [_lb_name_v setText:[GlobalData sharedInstance].user.userInfo.phoneNo];
        [_bt_login_v setImage:[UIImage imageNamed:model.icons] forState:UIControlStateNormal];
        [_bt_login_v setTitle:model.title forState:UIControlStateNormal];
    }else{
        [_lb_name_v setText:@"未登录"];
        [_bt_login_v setTitle:@"点击登录" forState:UIControlStateNormal];
        [_bt_login_v setImage:nil forState:UIControlStateNormal];
    }
    
    CGSize size= [model.title sizeFont:14];
    [_bt_login_v.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_bt_login_v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.mas_equalTo(size.height+10);
        make.width.mas_equalTo(size.width+30);
        make.right.equalTo(self).offset(-25);
    }];
    
    [_bt_login_v addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) initFunction:(FunctionModel*)model
{
    [self clearAllView];
    int i=0;
    for (FunctionItemModel *md in model.dataArray) {
        VerticalView *btn = [[VerticalView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [btn setTitle:md.title];
        [btn setImageUrl:md.icons];
        
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(i*(self.frame.size.width/4));
            make.centerY.equalTo(self);
            make.width.mas_equalTo(self.frame.size.width/4);
            make.height.equalTo(self);
        }];
        [btn setTitleFont:[UIFont systemFontOfSize:10]];
        if (i==0) {
            [btn setImageBackgroudColor:RGBHex(g_assit_blue)];
        }else if (i==1) {
            [btn setImageBackgroudColor:RGBHex(g_assit_orign)];
        }else if (i==2) {
            [btn setImageBackgroudColor:RGBHex(g_assit_yellow)];
        }else if (i==3) {
            [btn setImageBackgroudColor:RGBHex(g_assit_green)];
        }
        btn.delegate = self.delegate;
        [btn setTag:i];
        i++;
    }
}

- (void) initSpeaker:(BaseItemModel *)model
{
    [self clearAllView];
    if (!_lb_name_v) {
        _lb_name_v = [[UILabel alloc] init];
    }
    [self addSubview:_lb_name_v];
    [_lb_name_v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-30);
    }];
    [self.lb_name_v setText:model.title];
    [self.lb_name_v setTextColor:RGBHex(g_assit_c)];
    [self.lb_name_v setFont:[UIFont systemFontOfSize:14]];
    UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 100, 30)];
    [button setBackgroundColor:[UIColor redColor]];
    
    
    UISwitch *buttonS = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    [buttonS setOnImage:[UIImage imageNamed:@"img_on"]];
    [buttonS setOffImage:[UIImage imageNamed:@"img_off"]];
    [buttonS addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [buttonS setOn:model.hasMore animated:YES];
    self.accessoryView = buttonS;
}

- (void) initInput:(BaseItemModel*)model
{
    [self clearAllView];
    if (!_lb_name_v) {
        _lb_name_v = [[UILabel alloc] init];
    }
    [self addSubview:_lb_name_v];
    [_lb_name_v mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.width.mas_equalTo(60);
    }];
    [self.lb_name_v setText:model.title?model.title:@""];
    [self.lb_name_v setTextColor:RGBHex(g_assit_c)];
    [self.lb_name_v setFont:[UIFont systemFontOfSize:14]];
    
    _inputText = [[UITextField alloc] init];
    [_inputText setText:model.value];
    [self addSubview:_inputText];
    [_inputText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lb_name_v.mas_right);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.right.equalTo(self).offset(-40);
    }];
    [_inputText addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void) initDefault:(BaseItemModel *)model
{
    [self clearAllView];
    if (!_lb_name_v) {
        _lb_name_v = [[UILabel alloc] init];
    }
    [self addSubview:_lb_name_v];
    [_lb_name_v mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-30);
    }];
    [self.lb_name_v setText:model.title?model.title:@""];
    [self.lb_name_v setTextColor:RGBHex(g_assit_c)];
    [self.lb_name_v setFont:[UIFont systemFontOfSize:14]];
//    if (!_grayLine) {
//        _grayLine = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 0, 1)];
//        [self addSubview:_grayLine];
//    }
//    [_grayLine setBackgroundColor:RGBHex(g_black)];
//    [_grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(10);
//        make.height.mas_equalTo(1);
//        make.bottom.equalTo(self);
//    }];
}

- (void) clearAllView
{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setAccessoryType:UITableViewCellAccessoryNone];
    [self setAccessoryView:nil];
    
    [self setUserInteractionEnabled:YES];
    if (IOS_VERSION>8.0) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }else{
        for (UIView *view in self.subviews[0].subviews) {
            [view removeFromSuperview];
        }
    }
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

- (void) textValueChanged:(UITextField*)text
{
    ((BaseItemModel*)self.model).value = text.text;
}

@end
