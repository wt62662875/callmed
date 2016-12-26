//
//  PhotoTitleView.h
//  callmed
//
//  Created by sam on 16/7/26.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTitleView : UIView
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIImage *imageData;
@property (nonatomic,assign) BOOL indicatorHidden;
@end
