//
//  CarStatusModel.m
//  callmed
//
//  Created by sam on 16/7/27.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CarStatusModel.h"

@implementation CarStatusModel

+ (void) driverUpdateStatusType:(NSString*)type status:(NSInteger)status success:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:type forKey:@"type"];
    if ([GlobalData sharedInstance].user.isLogin) {
        [params setObject:[GlobalData sharedInstance].user.userInfo.ids forKey:@"id"];
        [params setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.longitude] forKey:@"longitude"];
        [params setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.latitude] forKey:@"latitude"];
    }
    
    NSString *method;
    if (status==0) {
        method=@"dRexit";
    }else{
        method=@"dRenter";
    }
    
    [HttpShareEngine callWithFormParams:params withMethod:method succ:^(NSDictionary *resultDictionary) {
        if (suc) {
            suc(resultDictionary);
        }
    } fail:fail];
}
@end
