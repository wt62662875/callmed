//
//  BaseController.h
//  callmec
//
//  Created by sam on 16/6/21.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KTopbarH 64




@interface BaseController : UIViewController

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIView *bottomHeaderLine;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,assign) BOOL hiddenHeader;
@property (nonatomic,assign) id<CallBackDelegate> delegateCallback;
- (void) initDefaultHeader;
- (void) setRightButtonText:(NSString*)title withFont:(UIFont*)font;
- (void) setLeftButtonText:(NSString*) title withFont:(UIFont*)font;
- (void) setRightButtonImage:(NSString*)imageUrl;
- (void) reloadData;
- (void) removeViewFromParent;
- (void) callback:(id)sender;
- (void) buttonTarget:(id)sender;
+ (BOOL) hasVisiabled;
@end
