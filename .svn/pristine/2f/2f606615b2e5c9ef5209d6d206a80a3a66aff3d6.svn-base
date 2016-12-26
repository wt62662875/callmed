//
//  UserItemModel.m
//  callmec
//
//  Created by sam on 16/8/8.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "AuthItemModel.h"

@implementation AuthItemModel

+ (void) saveAuthVerifyedInfo:(NSMutableDictionary*)params success:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail{

    [HttpShareEngine callWithFormParams:params withMethod:@"dEdit" succ:^(NSDictionary *resultDictionary) {
        if (suc) {
            suc(resultDictionary);
        }
    } fail:fail];
}
@end
