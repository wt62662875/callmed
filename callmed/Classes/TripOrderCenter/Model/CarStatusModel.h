//
//  CarStatusModel.h
//  callmed
//
//  Created by sam on 16/7/27.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BaseModel.h"

@interface CarStatusModel : BaseModel
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) CGFloat height;

+ (void) driverUpdateStatusType:(NSString*)type status:(NSInteger)status success:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;

@end
