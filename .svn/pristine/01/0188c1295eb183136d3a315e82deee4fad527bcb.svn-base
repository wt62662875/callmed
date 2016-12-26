//
//  BalanceExtraCell.m
//  callmed
//
//  Created by sam on 16/8/4.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BalanceExtraCell.h"
#import "LeftInputView.h"

@interface BalanceExtraCell()<TargetActionDelegate>

@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) LeftInputView *feeSpeedRoadLabel;
@property (nonatomic,strong) LeftInputView *feeBridgeLabel;
@property (nonatomic,strong) LeftInputView *feeStopLabel;
@end
@implementation BalanceExtraCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super  initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self setBackgroundColor:[UIColor clearColor]];
    _containerView = [[UIView alloc] init];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    [_containerView.layer setCornerRadius:5];
    [_containerView.layer setMasksToBounds:YES];
    [self addSubview:_containerView];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    _titleLabel =[[UILabel alloc] init];
    [_titleLabel setText:@"费用信息"];
    [_containerView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(20);
    }];
    
    _feeSpeedRoadLabel = [[LeftInputView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_feeSpeedRoadLabel setTitle:@"高速费"];
    [_feeSpeedRoadLabel setHiddenIcon:YES];
    [_feeSpeedRoadLabel setPlaceHolder:@"输入金额"];
    [_feeSpeedRoadLabel setKeyBoardType:UIKeyboardTypeDecimalPad];
    [_feeSpeedRoadLabel setTailText:@"元"];
    [_feeSpeedRoadLabel setDelegate:self];
    [_feeSpeedRoadLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_feeSpeedRoadLabel setContentFont:[UIFont systemFontOfSize:15]];
    [_feeSpeedRoadLabel setTailFont:[UIFont systemFontOfSize:13]];
    
    [_containerView addSubview:_feeSpeedRoadLabel];
    [_feeSpeedRoadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(20);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    _feeBridgeLabel = [[LeftInputView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_feeBridgeLabel setTitle:@"路桥费"];
    [_feeBridgeLabel setHiddenIcon:YES];
    [_feeBridgeLabel setPlaceHolder:@"输入金额"];
    [_feeBridgeLabel setKeyBoardType:UIKeyboardTypeDecimalPad];
    [_feeBridgeLabel setTailText:@"元"];
    [_feeBridgeLabel setDelegate:self];
    [_feeBridgeLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_feeBridgeLabel setContentFont:[UIFont systemFontOfSize:15]];
    [_feeBridgeLabel setTailFont:[UIFont systemFontOfSize:13]];
    
    [_containerView addSubview:_feeBridgeLabel];
    [_feeBridgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_feeSpeedRoadLabel.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    _feeStopLabel = [[LeftInputView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_feeStopLabel setTitle:@"停车费"];
    [_feeStopLabel setHiddenIcon:YES];
    [_feeStopLabel setPlaceHolder:@"输入金额"];
    [_feeStopLabel setKeyBoardType:UIKeyboardTypeDecimalPad];
    [_feeStopLabel setTailText:@"元"];
    [_feeStopLabel setDelegate:self];
    [_feeStopLabel setTitleFont:[UIFont systemFontOfSize:13]];
    [_feeStopLabel setContentFont:[UIFont systemFontOfSize:15]];
    [_feeStopLabel setTailFont:[UIFont systemFontOfSize:13]];
    
    [_containerView addSubview:_feeStopLabel];
    [_feeStopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_feeBridgeLabel.mas_bottom).offset(5);
        make.left.equalTo(_containerView).offset(10);
        make.right.equalTo(_containerView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) valueChanged:(id)sender
{
    if (sender == _feeBridgeLabel) {
        if (_dataValue) {
            [_dataValue setObject:((LeftInputView*)sender).content forKey:@"fee2"];
        }
    }else if (sender == _feeSpeedRoadLabel) {
        if (_dataValue) {
            [_dataValue setObject:((LeftInputView*)sender).content forKey:@"fee1"];
        }
    }else if (sender == _feeStopLabel) {
        if (_dataValue) {
            [_dataValue setObject:((LeftInputView*)sender).content forKey:@"fee3"];
        }
    }
}

@end
