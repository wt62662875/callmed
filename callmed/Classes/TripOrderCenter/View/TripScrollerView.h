//
//  TripScrollerView.h
//  callmec
//
//  Created by sam on 16/7/7.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripScrollerView : UIView

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIColor *lightColor;
@property (nonatomic,strong) UIColor *normalColor;
@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,weak) id<TargetActionDelegate> delegate;


- (void) updateRedBobble:(NSInteger)index withNumber:(NSInteger)number;
- (instancetype) initWithFrame:(CGRect)frame selected:(NSInteger)index;
@end
