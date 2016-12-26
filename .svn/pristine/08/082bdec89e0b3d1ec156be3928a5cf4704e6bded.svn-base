//
//  CancelView.h
//  callmec
//
//  Created by sam on 16/8/14.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverTypeModel : BaseModel
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *ids;
@end

typedef void (^SelectDriverTypeBlock)(NSInteger index,NSString *name);

@interface DriverTypeView : UIView
@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,readwrite,copy) SelectDriverTypeBlock block;
@property (nonatomic,copy) NSString *title;
@end
