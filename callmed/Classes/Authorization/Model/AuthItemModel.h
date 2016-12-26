//
//  UserItemModel.h
//  callmec
//
//  Created by sam on 16/8/8.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BaseModel.h"
#import "BaseCellModel.h"
@interface AuthItemModel : BaseCellModel


+ (void) saveAuthVerifyedInfo:(NSMutableDictionary*)params success:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;
@end
