//
//  BaseNavController.h
//  callmec
//
//  Created by sam on 16/6/23.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BaseController.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

//#import "DDLocation.h"
//#import "DDSearchViewController.h"
//#import "DDSearchManager.h"

//#import "DDDriverManager.h"
//#import "DDLocationView.h"

#import "iflyMSC/IFlySpeechError.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

@interface BaseNavController : BaseController <MAMapViewDelegate,IFlySpeechSynthesizerDelegate,AMapNaviDriveManagerDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapNaviDriveManager *naviManager;
@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;

- (void)initMapView;

- (void)initNaviManager;

- (void)initIFlySpeech;

- (void)returnAction;
@end
