//
//  WalletInfoModel.h
//  callmec
//
//  Created by sam on 16/7/13.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BaseModel.h"

@interface WalletInfoModel : BaseModel
@property (nonatomic,copy) NSString* cash;
@property (nonatomic,copy) NSString* cmoney;
@property (nonatomic,copy) NSString* descriptions;
@property (nonatomic,copy) NSString* icardNo;
@property (nonatomic,copy) NSString* level;

+ (void) fetchWalletInfoSuccess:(QuerySuccessBlock)sucess failed:(QueryErrorBlock)fail;
@end
