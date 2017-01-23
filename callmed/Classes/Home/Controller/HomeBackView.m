//
//  HomeBackView.m
//  callmed
//
//  Created by wt on 2017/1/13.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "HomeBackView.h"
#import "UserCenterController.h"

@implementation HomeBackView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    _headImage.layer.cornerRadius = 31;
    _headImage.layer.masksToBounds = YES;
    NSString *urlStr = [NSString stringWithFormat:@"%@getDHeadIcon?id=%@&token=%@",kserviceURL,
                        [GlobalData sharedInstance].user.userInfo.ids,
                        [GlobalData sharedInstance].user.session];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"teng"]];
    _nameLabel.text = [GlobalData sharedInstance].user.userInfo.loginName?[GlobalData sharedInstance].user.userInfo.loginName:[GlobalData sharedInstance].user.userInfo.phoneNo;
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (_delegate &&[_delegate respondsToSelector:@selector(buttonSelected:Index:)]) {
        [_delegate buttonTarget:sender];
    }
}

@end
