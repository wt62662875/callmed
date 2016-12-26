//
//  NotificationModel.h
//  callmed
//
//  Created by sam on 16/8/3.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BaseModel.h"


#define PUSH_TYPE_ORDER_TO_DRIVERS  1  //推送订单给所有司机等司机抢单
#define PUSH_TYPE_ORDER_TO_DRIVER  2  //推送订单给抢到单的司机来确认订单
#define PUSH_TYPE_ORDER_TO_MEMBER  3 //推送抢到订单的司机给乘客
#define PUSH_TYPE_ORDER_START_TO_MEMBER  4 //推送乘客司机点了开始行程
#define PUSH_TYPE_ORDER_END_TO_MEMBER  5 //推送乘客司机点了结束行程
#define PUSH_TYPE_ORDER_CANCEL_TO_MEMBER  6 //推送乘客司机取消行程
#define PUSH_TYPE_ORDER_CANCEL_TO_DRIVER  7 //推送司机乘客取消行程
#define PUSH_TYPE_ORDER_PAYED_TO_DRIVER  8 //推送司机乘客已经付款
#define PUSH_TYPE_ORDER_REACH_TO_MEMBER  9 //推送乘客司机到达目的地
#define PUSH_TYPE_ORDER_MANUAL_TO_MEMBER  10 //推送乘客他的订单没有人接单
#define PUSH_TYPE_ORDER_CREATE_TO_DRIVER  11 //推送创建新订单给司机， 主要是为了其他途径乘客创建的订单， 比如快吧扫码， IC卡后台创建的订单
#define PUSH_TYPE_NOTIFY_TO_DRIVER  20  //推送通知消息司机，无业务处理
#define PUSH_TYPE_NOTIFY_TO_MEMBER  21 //推送通知消息给乘客， 无业务处理


@interface NotificationModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *ids;
@property (nonatomic,copy) NSString<Optional> *appoint;
@property (nonatomic,copy) NSString<Optional> *appointDate;
@property (nonatomic,copy) NSString<Optional> *oType;
@property (nonatomic,copy) NSString<Optional> *sLocation;
@property (nonatomic,copy) NSString<Optional> *eLocation;
@property (nonatomic,copy) NSString<Optional> *distance;
@property (nonatomic,copy) NSString<Optional> *fee;
@property (nonatomic,copy) NSString<Optional> *sLongitude;
@property (nonatomic,copy) NSString<Optional> *sLatitude;
@property (nonatomic,copy) NSString<Optional> *eLongitude;
@property (nonatomic,copy) NSString<Optional> *eLatitude;
@property (nonatomic,copy) NSString<Optional> *gender;
@property (nonatomic,copy) NSString<Optional> *phoneNo;
@property (nonatomic,copy) NSString<Optional> *type;
@property (nonatomic,copy) NSString<Optional> *no;
@property (nonatomic,copy) NSString<Optional> *bizType;
@property (nonatomic,copy) NSString<Optional> *ts;
@property (nonatomic,copy) NSString<Optional> *state;
@property (nonatomic,copy) NSString<Optional> *orderPerson;
@property (nonatomic,copy) NSString<Optional> *memberId;
@property (nonatomic,copy) NSString<Optional> *memberName;
@property (nonatomic,copy) NSString<Optional> *cancelReason;

- (BOOL) isTimeout;
@end
