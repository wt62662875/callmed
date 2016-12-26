//
//  BaseNavController.m
//  callmec
//
//  Created by sam on 16/6/23.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BaseNavController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AMapServices sharedServices].apiKey=MAPAPIKey;
    
//    [self initMapView];
    
    [self initNaviManager];
    
    [self initIFlySpeech];
}


- (void)viewDidAppear:(BOOL)animated
{
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    _mapView.showsUserLocation = NO;
    _mapView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Handle Action

- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self clearMapView];
}


- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}

- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    }
    
    self.mapView.frame = self.view.bounds;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    _mapView.showsCompass = NO;
    _mapView.rotateEnabled = NO;
    _mapView.showsScale = NO;
    // 去除精度圈。
//    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)initNaviManager
{
    if (self.naviManager == nil)
    {
        _naviManager = [[AMapNaviDriveManager alloc] init];
    }
    
    self.naviManager.delegate = self;
}

- (void)initIFlySpeech
{
    if (self.iFlySpeechSynthesizer == nil)
    {
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    }
    
    _iFlySpeechSynthesizer.delegate = self;
}

#pragma mark - AMapNaviDriveManagerDelegate
/**
 *  发生错误时,会调用代理的此方法
 *
 *  @param error 错误信息
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error{
    NSLog(@"%@",error);
}

/**
 *  驾车路径规划成功后的回调函数
 */
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager{
    //[super driveManagerOnCalculateRouteSuccess:driveManager];
    
    [self.naviManager startGPSNavi];
}
/**
 *  驾车路径规划失败后的回调函数
 *
 *  @param error 错误信息,error.code参照AMapNaviCalcRouteState
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error{
    NSLog(@"路径规划失败:%@",error);
}

/**
 *  启动导航后回调函数
 *
 *  @param naviMode 导航类型，参考AMapNaviMode
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode{
    NSLog(@"启动导航成功:");
}

/**
 *  出现偏航需要重新计算路径时的回调函数
 */
- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager{
    NSLog(@"出现偏航需要重新计算路径:");
}

/**
 *  前方遇到拥堵需要重新计算路径时的回调函数
 */
- (void)driveManagerNeedRecalculateRouteForTrafficJam:(AMapNaviDriveManager *)driveManager{

    NSLog(@"前方遇到拥堵需要重新计算路径");
}

/**
 *  导航到达某个途经点的回调函数
 *
 *  @param wayPointIndex 到达途径点的编号，标号从1开始
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex{

    NSLog(@"导航到达某个途经点");
}

/**
 *  导航播报信息回调函数
 *
 *  @param soundString 播报文字
 *  @param soundStringType 播报类型,参考AMapNaviSoundType
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType{
    NSLog(@"实时播报:%@",soundString);
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
    if (soundStringType == AMapNaviSoundTypePassedReminder)
    {
        //用系统自带的声音做简单例子，播放其他提示音需要另外配置
        AudioServicesPlaySystemSound(1009);
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [_iFlySpeechSynthesizer startSpeaking:soundString];
        });
    }
}

/**
 *  模拟导航到达目的地停止导航后的回调函数
 */
- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"模拟导航到达目的地停止导航");
}

/**
 *  导航到达目的地后的回调函数
 */
- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"导航到达目的地后");
}

@end
