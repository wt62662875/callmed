//
//  GlobalData.h
//  callmec
//
//  Created by sam on 16/6/22.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "UserModel.h"
#import "OrderModel.h"
#import "CMLocation.h"
#import "WalletInfoModel.h"

@protocol TargetActionDelegate <NSObject>

@optional - (void) buttonTarget:(id)sender;
@optional - (void) buttonSelectedIndex:(NSInteger)index;
@optional - (void) valueChanged:(id)sender;
@optional - (void) buttonSelected:(UIView*)view Index:(NSInteger)index;
@optional - (void) buttonTarget:(UIView*)view withObj:(NSObject*)obj;
@end

@interface GlobalData : NSObject

@property (nonatomic,strong) UserModel *user;

@property (nonatomic,strong) WalletInfoModel *wallet;

@property (nonatomic,readonly) NSString *channel_id;

@property (nonatomic,assign) AFNetworkReachabilityStatus netStatus;

@property (nonatomic,copy) NSString *city;

@property (nonatomic,copy) NSString *clientId;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic,assign) CGFloat distances;

//@property (nonatomic,assign) BOOL recordEnable;

@property (nonatomic,strong) NSMutableDictionary *dictDistance;

@property (nonatomic,strong) CMLocation *location;

//@property (nonatomic,strong) OrderModel *fastBus;
@property (nonatomic,strong) NSMutableDictionary *fastBusDict;
+ (instancetype)sharedInstance;

+ (NSString*) getUUID;

- (NSString*) getChannelId;

@end
