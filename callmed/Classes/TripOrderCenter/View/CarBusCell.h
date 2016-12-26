//
//  CarSpecialCell.h
//  callmed
//
//  Created by sam on 16/8/5.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface CarBusCell : UITableViewCell

@property (nonatomic,strong) OrderModel *model;
@property (nonatomic,weak) id<TargetActionDelegate> delegate;
@end
