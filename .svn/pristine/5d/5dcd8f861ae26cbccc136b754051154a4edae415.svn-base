//
//  OrderModel.h
//  callmec
//
//  Created by sam on 16/7/7.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BaseModel.h"
#import "NotificationModel.h"

#define STATE_ORDER_NEW  @"1"               // 新增, 提交后等待司机抢单
#define STATE_ORDER_CONFIRM_PENDNG  @"2"    // 提交后司机抢到单后， 等待司机确认
#define STATE_ORDER_EXECUTE_PENDING  @"3"   // 司机确认订单 , 等待行程开始
#define STATE_ORDER_EXECUTE  @"4"           // 订单执行中, 司机开始点行程开始
#define STATE_ORDER_PAY_PENDING  @"5"       // 订单执行完毕, 司机开始点了行程结束, 等待乘客付款
#define STATE_ORDER_FINISHED  @"6"          // 订单付款成功,该订单完成,如果订单付款失败， 继续回退到等待付款
#define STATE_ORDER_COMMENTED  @"7"         // 订单完成后，被评论
#define STATE_ORDER_CANCEL  @"-1"           // 订单被取消，乘客或者司机点了取消订单
#define STATE_ORDER_CLOSED  @"100"          // 订单关闭，司机或者乘客点了关闭订单，这种一般是在取消后，双方确认后，订单由司机改成关闭状态

@class NotificationModel;
@interface OrderModel : BaseModel

@property (nonatomic,copy) NSString<Optional>* actFee;
@property (nonatomic,copy) NSString<Optional>* createDate;
@property (nonatomic,copy) NSString<Optional>* appointDate;
@property (nonatomic,copy) NSString<Optional>* elocation;
@property (nonatomic,copy) NSString<Optional>* elatitude;
@property (nonatomic,copy) NSString<Optional>* elongitude;

@property (nonatomic,copy) NSString<Optional>* memberShipPhoneNo;
@property (nonatomic,copy) NSString<Optional>* no;
@property (nonatomic,copy) NSString<Optional>* slocation;
@property (nonatomic,copy) NSString<Optional>* state;
@property (nonatomic,copy) NSString<Optional>* type;
@property (nonatomic,copy) NSString<Optional>* ids;
@property (nonatomic,copy) NSString<Optional>* appoint;
@property (nonatomic,copy) NSString<Optional>* carDesc;
@property (nonatomic,copy) NSString<Optional>* carNo;
@property (nonatomic,copy) NSString<Optional>* carPoolNum;
@property (nonatomic,copy) NSString<Optional>* dPhoneNo;
@property (nonatomic,copy) NSString<Optional>* dRealName;
@property (nonatomic,copy) NSString<Optional>* descriptions;
@property (nonatomic,copy) NSString<Optional>* distance;
@property (nonatomic,copy) NSString<Optional>* driverId;
@property (nonatomic,copy) NSString<Optional>* fee;
@property (nonatomic,copy) NSString<Optional>* lineDesc;
@property (nonatomic,copy) NSString<Optional>* lineElat;
@property (nonatomic,copy) NSString<Optional>* lineElong;
@property (nonatomic,copy) NSString<Optional>* lineId;
@property (nonatomic,copy) NSString<Optional>* lineName;
@property (nonatomic,copy) NSString<Optional>* lineSlat;
@property (nonatomic,copy) NSString<Optional>* lineSlong;
@property (nonatomic,copy) NSString<Optional>* mPhoneNo;
@property (nonatomic,copy) NSString<Optional>* mRealName;
@property (nonatomic,copy) NSString<Optional>* orderPerson;
@property (nonatomic,copy) NSString<Optional>* otherFee;
@property (nonatomic,copy) NSString<Optional>* slatitude;
@property (nonatomic,copy) NSString<Optional>* slongitude;
@property (nonatomic,copy) NSString<Optional>* carId;
@property (nonatomic,copy) NSString<Optional>* carType;
@property (nonatomic,copy) NSString<Optional>* dLongitude;
@property (nonatomic,copy) NSString<Optional>* dServiceNum;
@property (nonatomic,copy) NSString<Optional>* dType;
@property (nonatomic,copy) NSString<Optional>* dLatitude;
@property (nonatomic,copy) NSString<Optional>* dLevel;
@property (nonatomic,copy) NSString<Optional>* startDate;
@property (nonatomic,copy) NSString<Optional>* dGender;
@property (nonatomic,copy) NSString<Optional>* memberId;
@property (nonatomic,copy) NSString<Optional>* memberName;


@property (nonatomic,copy) NSString<Optional>* receiver;
@property (nonatomic,copy) NSString<Optional>* receiverFixed;
@property (nonatomic,copy) NSString<Optional>* receiverPhone;

@property (nonatomic,copy) NSString<Optional>* goodsInfo;
@property (nonatomic,copy) NSString<Optional>* goodsName;
@property (nonatomic,copy) NSString<Optional>* goodsNum;
@property (nonatomic,copy) NSString<Optional>* goodsWeight;
@property (nonatomic,copy) NSArray<Optional>* goodsScale;
@property (nonatomic,copy) NSString<Optional>* chartered;

//@property (nonatomic,copy) NSString<Optional>* receiver;
//@property (nonatomic,copy) NSString<Optional>* receiver;
//@property (nonatomic,copy) NSString<Optional>* receiver;
//@property (nonatomic,copy) NSString<Optional>* receiver;
//@property (nonatomic,copy) NSString<Optional>* receiver;
/*
 actFee = 18;
 appoint = 1;
 appointDate = "2016-07-27 22:00";
 carDesc = "";
 carNo = "\U4e91AA8888";
 carPoolNum = 3;
 createDate = "2016-07-27 21:57";
 dPhoneNo = 13560360291;
 dRealName = "\U5f20\U4e09";
 description = "\U6295\U8d44\U8005";
 distance = 12000;
 driverId = 9;
 elocation = "";
 fee = 33;
 id = 551;
 lineDesc = "\U6d4b\U8bd5\U7ebf\U8def";
 lineElat = "25.5916113044";
 lineElong = "100.2297690606";
 lineId = 1;
 lineName = " \U6606\U660e-\U5927\U7406";
 lineSlat = "25.049153";
 lineSlong = "102.714601";
 mPhoneNo = 13570901783;
 mRealName = sam;
 no = PC20160727215730339;
 orderPerson = 3;
 otherFee = 0;
 slatitude = "23.148876";
 slocation = "\U5e7f\U5dde\U7ad9";
 slongitude = "113.257629";
 state = 6;
 type = 2;
 */

+ (OrderModel*) convertFrom:(NotificationModel*)model;

+ (void) fetchMyOrderListById:(NSString*)ids types:(NSString*)type page:(NSInteger)page succes:(QuerySuccessListBlock)suc failed:(QueryErrorBlock)fail;
+ (void) fetchOrderListById:(NSString*)ids types:(NSString*)type page:(NSInteger)page succes:(QuerySuccessListBlock)suc failed:(QueryErrorBlock)fail;

/**
 获取订单列表
 */
+ (void) fetchOrderListByUserId:(NSString*)ids fristId:(NSString *)fid types:(NSString *)type page:(NSInteger)page succes:(QuerySuccessListBlock)suc failed:(QueryErrorBlock)fail;

+ (void) fetchCarPoolingOrderListById:(NSString*)ids types:(NSString*)type page:(NSInteger)page succes:(QuerySuccessListBlock)suc failed:(QueryErrorBlock)fail;

+ (void) driverAcceptOrder:(NSString*)orderId driverId:(NSString*)driverId succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;

+ (void) driverArrival:(NSString*)orderId succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;

+ (void) driverStartTrip:(NSString*)orderId succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;
+ (void) driverStartPackageTrip:(NSMutableDictionary*)params succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;

+ (void) driverOverTrip:(NSMutableDictionary*)params succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;

+ (void)caculateOrderInfo:(NSString*)orderId withType:(NSString*)type distance:(NSString*)distance succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;

+ (void)caculateOrderInfoByParams:(NSMutableDictionary*)params succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;

+ (void) driverRobOrderId:(NSString*)orderId driver:(NSString*)driverId succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;
+ (void) driverDenyOrderById:(NSString*)orderId driver:(NSString*)driverId succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;

+ (void) driverOrderNumberBydriverId:(NSString*)driverId latesd:(NSString*)latest succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;
+ (void)dConfirmPreByOrderId:(NSString*)orderId driver:(NSString*)driverId succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;
+ (void)dDenyPreByOrderId:(NSString*)orderId driver:(NSString*)driverId succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;
+ (void)dCancelPreByOrderId:(NSString*)ids reason:(NSString*)reason succes:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;
@end
