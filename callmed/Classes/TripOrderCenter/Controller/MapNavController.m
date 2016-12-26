//
//  MapNavController.m
//  callmed
//
//  Created by sam on 16/8/31.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "MapNavController.h"

@interface MapNavController()<AMapNaviDriveViewDelegate>
@property (nonatomic, strong) AMapNaviPoint* startPoint;
@property (nonatomic, strong) AMapNaviPoint* endPoint;
@property (nonatomic,strong) AMapNaviDriveView *driverNavView;
@end

@implementation MapNavController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        [JCAlertView showOneButtonWithTitle:@"温馨提示" Message:@"定位功能不可用" ButtonType:JCAlertViewButtonTypeCancel ButtonTitle:@"知道了" Click:^{
            
        }];
    }
}

- (void) viewWillLayoutSubviews
{
    _driverNavView.frame = self.view.bounds;
}

- (void) initView
{
    [self.headerView setHidden:YES];
    
    if (_model) {
        _startPoint = [AMapNaviPoint locationWithLatitude:[GlobalData sharedInstance].coordinate.latitude longitude:[GlobalData sharedInstance].coordinate.longitude];
        if ([@"5" isEqualToString:_model.state]) {
            _endPoint   = [AMapNaviPoint locationWithLatitude:[_model.elatitude floatValue] longitude:[_model.elongitude floatValue]];
        }else{
            _endPoint   = [AMapNaviPoint locationWithLatitude:[_model.slatitude floatValue] longitude:[_model.slongitude floatValue]];
        }
    }
    
    
    _driverNavView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
    _driverNavView.delegate = self;
    [self.view addSubview:_driverNavView];
//    [_driverNavView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(20);
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//    }];
    
    [self.naviManager addDataRepresentative:_driverNavView];
    [self startGpsCaculate];
}

#pragma mark - TargetDelegate
- (void) buttonTarget:(id)sender
{
    if (self.leftButton == sender) {
        [self closeAllTask];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if(self.rightButton == sender){
        [self startGpsCaculate];
    }

}

- (void) startGpsCaculate
{
    [self calculateRoute];
}

- (void)calculateRoute
{
    NSArray *startPoints = @[_startPoint];
    NSArray *endPoints   = @[_endPoint];
    [self.naviManager calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints:nil drivingStrategy:0];
}


#pragma mark - AMapNaviDriveViewDelegate
/**
 *  导航界面关闭按钮点击时的回调函数
 */
- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView{
    [self closeAllTask];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  导航界面更多按钮点击时的回调函数
 */
- (void)driveViewMoreButtonClicked:(AMapNaviDriveView *)driveView{

}

/**
 *  导航界面转向指示View点击时的回调函数
 */
- (void)driveViewTrunIndicatorViewTapped:(AMapNaviDriveView *)driveView{

}

/**
 *  导航界面显示模式改变后的回调函数
 *
 *  @param showMode 显示模式
 */
- (void)driveView:(AMapNaviDriveView *)driveView didChangeShowMode:(AMapNaviDriveViewShowMode)showMode{

}

/**
 *  获取导航界面上路线显示样式的回调函数
 *
 *  @param naviRoute 当前界面的路线信息
 *  @return AMapNaviRoutePolylineOption 路线显示样式
 */
- (AMapNaviRoutePolylineOption *)driveView:(AMapNaviDriveView *)driveView needUpdatePolylineOptionForRoute:(AMapNaviRoute *)naviRoute
{
    AMapNaviRoutePolylineOption *polyline = [[AMapNaviRoutePolylineOption alloc] init];
    polyline.lineWidth = 5;
    return polyline;
}

- (void) closeAllTask
{
    [self.naviManager stopNavi];
    [self.iFlySpeechSynthesizer stopSpeaking];
    self.iFlySpeechSynthesizer.delegate = nil;
}
@end
