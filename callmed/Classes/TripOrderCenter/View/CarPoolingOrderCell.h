//
//  DriverOrderCell.h
//  callmed
//
//  Created by sam on 16/7/28.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface CarPoolingOrderCell : UITableViewCell

@property (nonatomic,strong) OrderModel* model;
@property (nonatomic,weak) id<TargetActionDelegate> delegate;
@end
