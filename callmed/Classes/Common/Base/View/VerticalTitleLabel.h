//
//  VerticalTitleLabel.h
//  callmed
//
//  Created by sam on 16/7/20.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalTitleLabel : UIView
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *imageName;

@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *contentColor;
@property (nonatomic,strong) UIFont *titleFont;
@property (nonatomic,strong) UIFont *contentFont;
@property (nonatomic,assign) CGFloat paddingTop;
@property (nonatomic,assign) CGFloat paddingLeft;
@property (nonatomic,assign) CGFloat paddingBottom;
@property (nonatomic,assign) CGFloat paddingRight;
@property (nonatomic,assign) CGFloat paddingMiddle;
@property (nonatomic,assign) NSTextAlignment titleAlignment;
@property (nonatomic,assign) NSTextAlignment contentAlignment;
@property (nonatomic,assign) CGFloat contentRate;
@property (nonatomic,assign) CGFloat titleRate;
@property (nonatomic,assign) CGFloat titleAlpha;
@property (nonatomic,assign) CGFloat contentAlpha;

@end
