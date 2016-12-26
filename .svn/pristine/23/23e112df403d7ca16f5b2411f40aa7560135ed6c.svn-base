//
//  IntegrateModel.m
//  callmec
//
//  Created by sam on 16/8/17.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel

+ (void) fetchOrderList:(NSInteger)page type:(NSInteger)type accountId:(NSString*)ids success:(QuerySuccessListBlock)succes failed:(QueryErrorBlock)fail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(page) forKey:@"page"];
    [params setObject:@(10) forKey:@"pageSize"];
    if (ids) {
        [params setObject:ids forKey:@"accountId"];
    }else{
        [params setObject:[GlobalData sharedInstance].user.userInfo.ids forKey:@"accountId"];
    }
    
    [params setObject:@(type) forKey:@"ownerType"];
    
    [HttpShareEngine callWithFormParams:params withMethod:@"listDAccountLog" succList:^(NSArray *result, int pageCount, int recordCount) {
        if (succes) {
            succes(result,pageCount,recordCount);
        }
    } fail:fail];
}
@end
