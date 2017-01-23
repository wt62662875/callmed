//
//  allOrderViewController.h
//  callmed
//
//  Created by wt on 2016/12/27.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface allOrderViewController : BaseController
@property (strong, nonatomic) NSString *accountId;
@property (strong, nonatomic) NSString *balance;

@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;

@end
