//
//  UserInfoModel.m
//  callmec
//
//  Created by sam on 16/6/22.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel


+ (void) login:(NSString *)username withPwd:(NSString *)pwd succ:(QuerySuccessBlock)suc fail:(QueryErrorBlock)fai
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:username forKey:@"loginName"];
    [params setObject:pwd forKey:@"loginPwd"];
    if([GlobalData sharedInstance].clientId)
    {
        [params setObject:[GlobalData sharedInstance].clientId forKey:@"clientId"];
    }
    [params setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.longitude] forKey:@"longitude"];
    [params setObject:[NSString stringWithFormat:@"%f",[GlobalData sharedInstance].coordinate.latitude] forKey:@"latitude"];
    [HttpShareEngine callWithFormParams:params withMethod:@"dLogin" succ:^(NSDictionary *resultDictionary) {
        if (suc) {
            suc(resultDictionary);
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        if (fai) {
            fai(errorCode,errorMessage);
        }
    }];
}

+ (void) fetchValidateCode:(NSString*)mobile succ:(QuerySuccessBlock)suc fail:(QueryErrorBlock)fai
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:mobile forKey:@"phoneNo"];

    [HttpShareEngine callWithFormParams:params withMethod:@"dAuthCode" succ:^(NSDictionary *resultDictionary) {
        if (suc) {
            suc(resultDictionary);
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        if (fai) {
            fai(errorCode,errorMessage);
        }
    }];
}

+ (void) save:(UserInfoModel*)userinfo
{
    
}

+ (void) commitEditUserInfo:(NSMutableDictionary*)params succ:(QuerySuccessBlock)suc fail:(QueryErrorBlock)fai
{
    
    [HttpShareEngine callWithFormParams:params withMethod:@"dEdit" succ:^(NSDictionary *resultDictionary) {
        if (suc) {
            suc(resultDictionary);
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        if (fai) {
            fai(errorCode,errorMessage);
        }
    }];
}

+ (void) fetchUserHeaderImage:(NSString*)ids succ:(QuerySuccessBlock)suc fail:(QueryErrorBlock)fai
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ids forKey:@"id"];
    //getDHeadIcon
    [HttpShareEngine callWithUrlParams:params withMethod:@"getMHeadIcon" succ:^(NSDictionary *resultDictionary) {
        if (suc) {
            suc(resultDictionary);
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        if (fai) {
            fai(errorCode,errorMessage);
        }
    }];
}
+ (void) uploadImageData:(NSMutableDictionary*)params succ:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail
{

    [HttpShareEngine callWithFormParams:params withMethod:@"dEdit" succ:^(NSDictionary *resultDictionary) {
        if (suc) {
            suc(resultDictionary);
        }
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        if (fail) {
            fail(errorCode,errorMessage);
        }
    }];
}
@end
