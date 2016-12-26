//
//  UserInfoModel.h
//  callmec
//
//  Created by sam on 16/6/22.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel
@property (nonatomic,copy) NSString  *ids;

@property (nonatomic,copy) NSString<Optional>  *address;
@property (nonatomic,copy) NSString<Optional>  *alias;
@property (nonatomic,copy) NSString<Optional>  *bizType;

@property (nonatomic,copy) NSString<Optional>  *clientId;
@property (nonatomic,copy) NSString<Optional>  *distance;
@property (nonatomic,copy) NSString<Optional>  *duration;

@property (nonatomic,copy) NSString<Optional>  *elatitude;
@property (nonatomic,copy) NSString<Optional>  *elocation;
@property (nonatomic,copy) NSString<Optional>  *elongitude;

@property (nonatomic,copy) NSString<Optional>  *slatitude;
@property (nonatomic,copy) NSString<Optional>  *slocation;
@property (nonatomic,copy) NSString<Optional>  *slongitude;

@property (nonatomic,copy) NSString<Optional>  *email;
@property (nonatomic,copy) NSString<Optional>  *fullJob;
@property (nonatomic,copy) NSString<Optional>  *gender;                 //1男，0女

@property (nonatomic,copy) NSString<Optional>  *identifierNo;
@property (nonatomic,copy) NSString<Optional>  *latitude;
@property (nonatomic,copy) NSString<Optional>  *longitude;

@property (nonatomic,copy) NSString<Optional>  *licenseDate;
@property (nonatomic,copy) NSString<Optional>  *licenseNo;
@property (nonatomic,copy) NSString<Optional>  *licenseType;
@property (nonatomic,copy) NSString<Optional>  *departmentName;
@property (nonatomic,copy) NSString<Optional>  *departmentId;

@property (nonatomic,copy) NSString<Optional>  *loginName;

@property (nonatomic,copy) NSString<Optional>  *nativePlace;            //籍贯
@property (nonatomic,copy) NSString<Optional>  *no;
@property (nonatomic,copy) NSString<Optional>  *passed;                    //司机审核状态0未证证，1已经认证 2审核中..
@property (nonatomic,copy) NSString<Optional>  *phoneNo;
@property (nonatomic,copy) NSString<Optional>  *ready;                     //出车的状态是否已经出车
@property (nonatomic,copy) NSString<Optional>  *realName;
@property (nonatomic,copy) NSString<Optional>  *regCity;

@property (nonatomic,copy) NSString<Optional> *serviceNo;

@property (nonatomic,copy) NSString<Optional>  *company;
@property (nonatomic,copy) NSString<Optional> *descriptions;

@property (nonatomic,copy) NSString<Optional> *carId;
@property (nonatomic,copy) NSDictionary<Optional> *car;
@property (nonatomic,copy) NSString<Optional>  *carType;

@property (nonatomic,copy) NSString<Optional> *state;
@property (nonatomic,copy) NSString<Optional> *type;                      //出车类型 1专车 2 快车 4 快吧 3货车

@property (nonatomic,copy) NSString<Optional> *bankNo;                    //账号
@property (nonatomic,copy) NSString<Optional> *bankAccount;               //账户名
@property (nonatomic,copy) NSString<Optional> *bankProv;                    //开户省
@property (nonatomic,copy) NSString<Optional> *bankCity;                    //开户市
@property (nonatomic,copy) NSString<Optional> *bankName;
@property (nonatomic,copy) NSString<Optional> *attribute1;                //推荐人
@property (nonatomic,copy) NSString<Optional> *upReason;

+ (void) save:(UserInfoModel*)userinfo;

+ (void) login:(NSString*)username withPwd:(NSString*)pwd succ:(QuerySuccessBlock)suc fail:(QueryErrorBlock)fai;

+ (void) fetchValidateCode:(NSString*)mobile succ:(QuerySuccessBlock)suc fail:(QueryErrorBlock)fai;

+ (void) commitEditUserInfo:(NSMutableDictionary*)params succ:(QuerySuccessBlock)suc fail:(QueryErrorBlock)fai;

+ (void) fetchUserHeaderImage:(NSString*)ids succ:(QuerySuccessBlock)suc fail:(QueryErrorBlock)fai;

+ (void) uploadImageData:(NSMutableDictionary*)params succ:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;
@end
