//
//  CarPoolingCell.h
//  callmed
//
//  Created by sam on 16/8/3.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@interface CarPoolingCell : UITableViewCell

@property (nonatomic,strong) OrderModel *model;
@property (nonatomic,strong) UIButton *getOrder;

@property (nonatomic,strong) UIButton *moreOrder;

@end
