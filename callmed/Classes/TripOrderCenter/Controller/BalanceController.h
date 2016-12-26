//
//  BalanceController.h
//  callmed
//
//  Created by sam on 16/8/4.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BaseController.h"
#import "OrderModel.h"

@interface BalanceController : BaseController
@property (nonatomic,strong)OrderModel *model;
@end
