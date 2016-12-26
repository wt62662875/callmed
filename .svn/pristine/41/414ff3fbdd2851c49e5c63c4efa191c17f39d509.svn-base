//
//  NotificationModel.m
//  callmed
//
//  Created by sam on 16/8/3.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "NotificationModel.h"

@implementation NotificationModel

- (BOOL) isTimeout
{
    
    if (_ts && [_ts length]>0) {
        NSInteger second =  [CommonUtility compareDateStringToNow:_ts withFormat:nil];
        NSLog(@"second%ld",(long)second);
        if (second>180) {
            NSLog(@"second 超出规定时间 舍弃");
            return YES;
        }
    }
    NSLog(@"second 未超出规定时间");
    return NO;
}
@end
