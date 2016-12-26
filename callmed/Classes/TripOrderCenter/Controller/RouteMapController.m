//
//  RouteMapController.m
//  callmed
//
//  Created by sam on 16/9/5.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "RouteMapController.h"
#import "LeftIconLabel.h"
#import "CMSearchManager.h"
#import "MovingAnnotationView.h"

@interface RouteMapController()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) LeftIconLabel *startLabel;
@property (nonatomic, strong) LeftIconLabel *endLabel;
@end

@implementation RouteMapController


- (void) viewDidLoad
{
    [super viewDidLoad];
    [self initMapView];
    [self initView];
}

- (void) initView
{
    [self setTitle:@"路线规划"];
    _containerView =[[UIView alloc] init];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    [self initTopViews];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void) initTopViews
{
    _startLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_startLabel setImageUrl:@"icon_qidian_dot_4"];
    [_startLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_startLabel];
    [_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView).offset(10);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(30);
    }];
    if (_startLocation) {
        [_startLabel setTitle:_startLocation.name];
    }
    _endLabel = [[LeftIconLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_endLabel setImageUrl:@"icon_qidian_dot_3"];
    [_endLabel setTitleFont:[UIFont systemFontOfSize:15]];
    [_containerView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_startLabel.mas_bottom);
        make.left.equalTo(_containerView).offset(10);
        make.height.mas_equalTo(30);
    }];
    if (_endLocation) {
        [_endLabel setTitle:_endLocation.name];
        [self caculateRoute];
    }
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


- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [self clearMapView];
}

- (void)actionLocating:(UIButton *)sender
{
    NSLog(@"actionLocating");
    [self resetMapToCenter:self.mapView.userLocation.location.coordinate];
}

- (void) resetMapToCenter:(CLLocationCoordinate2D)coordinate
{
    self.mapView.centerCoordinate = coordinate;
    //self.mapView.zoomLevel = 17;
    
    // 使得userLocationView在最前。
//    [self.mapView selectAnnotation:self.mapView.userLocation animated:YES];
}
- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:nil
                                                             reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        annotationView.draggable = YES;
        [annotationView setDragState:(MAAnnotationViewDragStateDragging)];
        //(MAAnnotationViewDragState)
        UIImage *image = [UIImage imageNamed:@"icon_marker_1"];
        annotationView.image = image;
        annotationView.centerOffset = CGPointMake(0, -22);
        annotationView.canShowCallout = YES;
        annotationView.center = self.mapView.center;
        return annotationView;
    }else if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"driverReuseIndetifier";
        
        MovingAnnotationView *annotationView = (MovingAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MovingAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:pointReuseIndetifier];
        }
        
        NSString *image_s= @"icon_marker_1";
        MAPointAnnotation *man = (MAPointAnnotation*)annotation;
        if ([@"上车地点" isEqualToString:man.title]) {
            image_s=@"icon_marker_1";
        }else if([@"下车地点" isEqualToString:man.title]){
            image_s=@"icon_marker_2";
        }else{
            image_s=@"icon_marker_1";
        }
        
        UIImage *image = [UIImage imageNamed:image_s];
        annotationView.image = image;
        annotationView.centerOffset = CGPointMake(0, 0);
        annotationView.canShowCallout = YES;
        
        return annotationView;
    }else{
        
        static NSString *userLocationStyleReuseIndetifier = @"common_user_indetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        UIImage *image = [UIImage imageNamed:@"icon_marker_2"];
        annotationView.image = image;
        annotationView.centerOffset = CGPointMake(0,0);
        annotationView.canShowCallout = NO;
        return annotationView;
    }
    
    return nil;
}

- (MAOverlayRenderer*) mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineRenderer *render = [[MAPolylineRenderer alloc] initWithOverlay:overlay];
        render.lineWidth = 4;
        render.strokeColor = RGBHex(@"#05fd11");
        render.fillColor =  RGBHex(@"#05fd11");
        render.lineJoinType = kMALineJoinRound;//连接类型
        return render;
    }
    return nil;
}

- (void) caculateRoute
{
    if (!_startLocation || !_endLocation) {
        NSLog(@"开始地点或者结束地点没有设置");
        return;
    }
    //__weak __typeof(&*self) weakSelf = self;
    [[CMSearchManager sharedInstance] searchForStartLocation:_startLocation end:_endLocation completionBlock:^(id request, id response, NSError *error) {
        AMapRouteSearchResponse *naviResponse = response;
        
        if (naviResponse.route == nil)
        {
             NSLog(@"获取路径失败");
            return;
        }
        
        AMapPath * path = [naviResponse.route.paths firstObject];
        [self updatePoly:path];
         NSLog(@"AMapPath%@",[NSString stringWithFormat:@"预估费用%.2f元  距离%.1f km  时间%.1f分钟", naviResponse.route.taxiCost, path.distance / 1000.f, path.duration / 60.f, nil]);
    }];
}

- (void) updatePoly:(AMapPath*)_routPath
{
    MAPointAnnotation *endPoint = [[MAPointAnnotation alloc] init];
    endPoint.coordinate = self.endLocation.coordinate;
    endPoint.title=@"下车地点";
    
    MAPointAnnotation *startPoint = [[MAPointAnnotation alloc] init];
    startPoint.coordinate = self.startLocation.coordinate;
    startPoint.title=@"上车地点";
    [self.mapView addAnnotation:startPoint];
    [self.mapView addAnnotation:endPoint];
    
    
    if (_routPath) {
        NSInteger index =0;
        for (AMapStep *steps in _routPath.steps) {
            
            NSArray *routes = [steps.polyline componentsSeparatedByString:@";"];
            NSInteger n =[routes count];
            CLLocationCoordinate2D points[n];
            for (int i = 0; i < n; i++) {
                CLLocationCoordinate2D coords;
                
                NSArray *po = [[routes objectAtIndex:i] componentsSeparatedByString:@","];
                coords.longitude=[[po objectAtIndex:0] floatValue];
                coords.latitude=[[po objectAtIndex:1] floatValue];
                
                CLLocationDegrees lat = coords.latitude;
                CLLocationDegrees longit = coords.longitude;
                points[i]=CLLocationCoordinate2DMake(lat,longit);
            }
            if (index==0) {
                CLLocationCoordinate2D spoints[2];
                spoints[0]=_startLocation.coordinate;
                spoints[1]=points[0];
                MAPolyline *lineOne = [MAPolyline polylineWithCoordinates:spoints count:2];
                
                [self.mapView addOverlay:lineOne];
            }
            
            MAPolyline *lineOne = [MAPolyline polylineWithCoordinates:points count:n];
            [self.mapView addOverlay:lineOne];
            
            index++;
            if (index==_routPath.steps.count) {
                if (n>0) {
                    CLLocationCoordinate2D epoints[2];
                    epoints[0]=_endLocation.coordinate;
                    epoints[1]=points[n-1];
                    MAPolyline *lineOne = [MAPolyline polylineWithCoordinates:epoints count:2];
                    [self.mapView addOverlay:lineOne];
                    NSLog(@"path.steps.count path.steps.count");
                }
            }
        }
    }
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(
                                                               (_startLocation.coordinate.latitude+_endLocation.coordinate.latitude)/2
                                                               , (_startLocation.coordinate.longitude+_endLocation.coordinate.longitude)/2);
    [self resetMapToCenter:center];
}

@end
