//
//  NoticeViewCommon.h
//  callmed
//
//  Created by sam on 16/8/8.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationModel.h"
@interface NoticeViewCommon : UIView
@property (nonatomic,strong) NotificationModel *model;
@property (nonatomic,assign) BOOL dismissWhenTouchOutside;
@property (nonatomic,weak) id<TargetActionDelegate> delegate;

- (void) dismiss;
@end
