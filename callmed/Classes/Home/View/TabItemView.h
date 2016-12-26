//
//  TabItemView.h
//  callmed
//
//  Created by sam on 16/7/18.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabItemView : UIView

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *imageUrlNormal;
@property (nonatomic,copy) NSString *imageUrlSelect;
@property (nonatomic,assign,setter=setSelected:) BOOL isSelected;
@end
