//
//  NoticeView.h
//  callmed
//
//  Created by sam on 16/8/3.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationModel.h"
@interface NoticeBusView : UIView

@property (nonatomic,strong) NotificationModel *model;
@property (nonatomic,assign) BOOL dismissWhenTouchOutside;
@property (nonatomic,weak) id<TargetActionDelegate> delegate;
@property (nonatomic,assign) NSInteger buttonType;
@property (nonatomic,copy) NSString *bizType;
- (void) dismiss;
@end
