//
//  Pay.m
//  crownbee
//
//  Created by Likid on 10/15/15.
//  Copyright © 2015 crownbee. All rights reserved.
//

#import "Pay.h"

#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "WXApi.h"
#import "payRequsestHandler.h"

NSString *const YASNtfPaySuccess = @"YASNtfPaySuccess";
NSString *const YASNtfPayFailure = @"YASNtfPayFailure";

NSString *const YASPayResultKey = @"YASPayResultKey";
NSString *const YASPayTypeKey = @"YASPayTypeKey";

@implementation AlipayModel

@end

@interface Pay ()

@property (copy, nonatomic) LKObjectBlock success;
@property (copy, nonatomic) QueryErrorBlock failure;

@end

@implementation Pay

+ (Pay *)sharedInstance {
    static id _sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)dealloc {
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addNotificationObservers];
    }
    return self;
}

- (void)addNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(paySuccess:)
                                                 name:YASNtfPaySuccess
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(payFailure:)
                                                 name:YASNtfPayFailure
                                               object:nil];
}

- (void)paySuccess:(NSNotification *)notification {
    if (self.success) {
        self.success(notification.userInfo);
    }
}

- (void)payFailure:(NSNotification *)notification {
    if (self.failure) {
        NSError *error = notification.userInfo[YASPayResultKey];
        self.failure(error.code, error.localizedFailureReason);
    }
}

+ (void)payWithAmount:(CGFloat)amount
                 type:(PayType)type
              success:(LKObjectBlock)success
              failure:(QueryErrorBlock)failure {

    [self sharedInstance].success = success;
    [self sharedInstance].failure = failure;
    /*
     params.put("ST", st);
     params.put("amount", amount);
     object.put("methods", "app/Account/alipayRecharge");
     */
    NSString *session =@"session" ;//[GlobalData sharedInstance].user;
    NSAssert(session, @"");

    [[HttpShareEngine sharedInstance] callWithParams:@{
        @"ST" : session,
        @"amount" : [NSString stringWithFormat:@"%.2f", amount],
    } method:type == PayTypeAlipay ? @"App2/UserRecharge/Alipay" : @"App2/UserRecharge/Weixin"
                                        OnCompletion:^(NSDictionary *resultDictionary) {
                                            if (type == PayTypeAlipay) {
                                                [self payWithAlipay:resultDictionary amount:amount];
                                            } else {
                                                [self payWithWechat:resultDictionary amount:amount];
                                            }
                                        } onError:failure];
}

+ (void)supportWithParam:(NSMutableDictionary*)params withAmount:(CGFloat)amount payType:(PayType)type success:(LKObjectBlock)success failure:(QueryErrorBlock)fail
{

    [self sharedInstance].success = success;
    [self sharedInstance].failure = fail;
    
    NSString *method = @"App2/ProjectSupport/submit";
    NSString *payTypeString = nil;
    switch (type) {
        case PayTypeWallet:
            //        method = @"App2/Support/walletpay";
            payTypeString =@"walletPay";
            break;
        case PayTypeAlipay:
            payTypeString = @"alipay";
            //        method = @"App2/Support/alipay";
            break;
        case PayTypeWechat:
            payTypeString = @"weixin";
            //        method = @"App2/Support/alipay";
            break;
        default:
            break;
    }
    
//    NSMutableDictionary *params = @{
//                                    @"anonymous" : isHideUserName,
//                                    @"hide_content" : isHideContent,
//                                    @"hide_money" : isHideAmout,
//                                    @"support_money" : [NSString stringWithFormat:@"%.2f", amount],
//                                    @"content" : content ?: @"",
//                                    @"project_id" : projectId,
//                                    @"reward":reward
//                                    }.mutableCopy;
    
    if (payTypeString) {
        [params setObject:payTypeString forKey:@"type"];
    }
    
    [[HttpShareEngine sharedInstance] callWithParams:params
                                              method:method
                                        OnCompletion:^(NSDictionary *resultDictionary) {
                                            if (type == PayTypeAlipay) {
                                                [self payWithAlipay:resultDictionary amount:amount];
                                            } else if (type == PayTypeWechat) {
                                                [self payWithWechat:resultDictionary amount:amount];
                                            } else {
                                                [self sharedInstance].success(resultDictionary);
                                            }
                                        } onError:fail];


}
+ (void)supportWithAmount:(CGFloat)amount
                     type:(PayType)type
                projectId:(NSString *)projectId
                  content:(NSString *)content
           isHideUserName:(NSString *)isHideUserName
            isHideContent:(NSString *)isHideContent
              isHideAmout:(NSString *)isHideAmout
               withReward:(NSString*)reward
                  success:(LKObjectBlock)success
                  failure:(QueryErrorBlock)failure {

    [self sharedInstance].success = success;
    [self sharedInstance].failure = failure;

    NSString *method = @"App2/ProjectSupport/submit";
    NSString *payTypeString = nil;
    switch (type) {
    case PayTypeWallet:
//        method = @"App2/Support/walletpay";
        payTypeString =@"walletPay";
        break;
    case PayTypeAlipay:
        payTypeString = @"alipay";
//        method = @"App2/Support/alipay";
        break;
    case PayTypeWechat:
        payTypeString = @"weixin";
//        method = @"App2/Support/alipay";
        break;
    default:
        break;
    }

    NSMutableDictionary *params = @{
        @"anonymous" : isHideUserName,
        @"hide_content" : isHideContent,
        @"hide_money" : isHideAmout,
        @"support_money" : [NSString stringWithFormat:@"%.2f", amount],
        @"content" : content ? content: @"",
        @"project_id" : projectId,
        @"reward":reward
    }.mutableCopy;

    if (payTypeString) {
        [params setObject:payTypeString forKey:@"type"];
    }

    [[HttpShareEngine sharedInstance] callWithParams:params
                                              method:method
                                        OnCompletion:^(NSDictionary *resultDictionary) {
                                            if (type == PayTypeAlipay) {
                                                [self payWithAlipay:resultDictionary amount:amount];
                                            } else if (type == PayTypeWechat) {
                                                [self payWithWechat:resultDictionary amount:amount];
                                            } else {
                                                [self sharedInstance].success(resultDictionary);
                                            }
                                        } onError:failure];
}

#pragma mark - Alipay

+ (void)payWithAlipay:(NSDictionary *)resultDictionary amount:(CGFloat)amount {

    id payJSON = resultDictionary;
    AlipayModel *payModel = [[AlipayModel alloc] initWithDictionary:payJSON error:nil];
    // 平台返回的数据不准
    // 单位，元
    payModel.total_fee = [NSString stringWithFormat:@"%.2f", amount];
    [self alipay:payModel];
}

+ (void)alipay:(AlipayModel *)model {
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911534538623";
    NSString *seller = @"tsoonweb@163.com";
    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANFdL75D2U7U7tYLVyHI/tAtpo3+KWs3rcfeZ/"
        @"B1SE562Yk3eGgajwaD0pXccMNKGUYr5E5nb81Dz5VulWcWNxPPFQn5b1Whu0Zp5vhMXnl10r8W8sHH4Khtys6otIN"
        @"mOtYnSev8J7MYewN/x1ZtSZKuR49MQ7J5qJsjdeWI8lC/AgMBAAECgYEAuA2iATQIgCL1bDo/+TWHvV/" @"EgiOkKdui7Ih6+4s/"
        @"a67YOqcHNQ3UGrgckx5eC3DC00uWw85vHRa2EPpMYXnIJAwRjZfrgtlmjQzicqQXJUPy94kaZzs75jux+"
        @"4okJEosYVwHG89EJCBAAU9GG/xZfTS62iynGIl/"
        @"bWWcBwmJjkECQQD2wqUrfE23r8Bpr1b6Smp7IESMvbDC0J2pjngdvXQgoZGIiV1Eb+RGtoDPapv5Wbs36i2qV2d+"
        @"VqW5HKCnQ0ZPAkEA2TQS4Uy66mKn43G+GjMVvwEFmV5KYFeVJMMrwK/"
        @"QFfjEVFm0BcCpadY0uE8911QRcoH2yiE8GAP7hl8BzC8ikQJBAJGejkBaS7bRlbgIjEiKL8pXYXy42J4u5EvSUpoi"
        @"WmyDTFIJ1itz6H++ZceBf2goBu7ZWHeEuwN4eLYD6d6rOcsCQA1RBf9OJv+LwONO6+"
        @"rLSwAE3gUDJOg3Nmukk6Aip01RjSfmwATCRSC6A01xfkcfXlp44VqPIxIN3HPmi0OreCECQQC7zs+O1iXb+oJa7+"
        @"s7SGbuEXgDXBEDi+zOxR3VJrs1eGd6ohkjAdGALxVuX6oPV9c3B3vDrJyOHyC6opsTPX8E";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/

    // partner和seller获取失败,提示
    if ([partner length] == 0 || [seller length] == 0 || [privateKey length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }

    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = model.out_trade_no;  //订单ID（由商家自行制定）
    order.productName = model.subject;   //商品标题
    order.productDescription = @"testD"; //商品描述
    order.amount = model.total_fee;      //商品价格
    order.notifyURL = model.notify_url;

    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";

    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"comtuoxunzhaofengcrownbee";

    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@", orderSpec);

    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];

    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderSpec, signedString, @"RSA"];

        [[AlipaySDK defaultService] payOrder:orderString
                                  fromScheme:appScheme
                                    callback:^(NSDictionary *resultDic) {
                                        [self processPayCallback:resultDic type:PayTypeAlipay];
                                    }];
    }
}

+ (void)processPayCallback:(id)result type:(PayType)type {
    NSLog(@"pay resultDic: %@", result);

    NSError *error = nil;
    YASPayResultStatus status = YASPayFailed;

    if (type == PayTypeAlipay) {
        NSDictionary *alipayResult = result;

        YASAlipayResultStatus alipayResultStatus = [alipayResult[@"resultStatus"] integerValue];
        if (alipayResultStatus != YASAlipaySuccess) {
            NSString *reason = @"";
            if (alipayResultStatus == YASAlipayCanceled) {
                reason = @"已取消"; // 用户主动取消，不进行处理
                status = YASPayCanceled;
            } else {
                status = YASPayFailed;
                reason = @"订单支付异常";
            }

            NSDictionary *userInfo = @{
                NSLocalizedFailureReasonErrorKey : reason,
                NSLocalizedDescriptionKey : alipayResult.description,
            };
            error = [NSError errorWithDomain:@"" code:alipayResultStatus userInfo:userInfo];

        } else {
            status = YASPaySuccess;
        }
    } else if (type == PayTypeWechat) {
        PayResp *resp = result;

        NSString *reason = @"";

        switch (resp.errCode) {
        case WXSuccess: {
            status = YASPaySuccess;
        } break;
        case WXErrCodeUserCancel: {
            status = YASPayCanceled;
            reason = @"已取消"; // 用户主动取消，不进行处理
        } break;
        default:
            status = YASPayFailed;
            reason = @"订单支付异常";
            break;
        }

        NSDictionary *userInfo = @{
            NSLocalizedFailureReasonErrorKey : reason,
            NSLocalizedDescriptionKey : resp.errStr ?: @"",
        };
        error = [NSError errorWithDomain:@"" code:status userInfo:userInfo];
    }

    if (status == YASPaySuccess) {
        [[NSNotificationCenter defaultCenter] postNotificationName:YASNtfPaySuccess
                                                            object:nil
                                                          userInfo:@{
                                                              YASPayResultKey : result,
                                                              YASPayTypeKey : @(type),
                                                          }];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:YASNtfPayFailure
                                                            object:nil
                                                          userInfo:@{
                                                              YASPayResultKey : error,
                                                              YASPayTypeKey : @(type),
                                                          }];
    }
}

#pragma mark - Wechat

+ (void)payWithWechat:(NSDictionary *)resultDictionary amount:(CGFloat)amount {
    id payJSON = resultDictionary;
    AlipayModel *payModel = [[AlipayModel alloc] initWithDictionary:payJSON error:nil];
    // 平台返回的数据不准
    // 单位，分
    NSInteger price = ceilf(amount * 100);
    payModel.total_fee = [NSString stringWithFormat:@"%ld", (long)price];
    [self wechatPay:payModel];
}

+ (void)wechatPay:(AlipayModel *)model {
    if ([WXApi isWXAppInstalled] == NO) {
        [self sharedInstance].failure(-1, @"尚未安装微信");
        return;
    }
    
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现

    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc] init];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];

    //}}}

    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo:model];

    if (dict == nil) {
        //错误提示
        NSString *debug = [req getDebugifo];

        [self processPayCallback:debug type:PayTypeWechat];

        NSLog(@"%@\n\n", debug);
    } else {
        NSLog(@"%@\n\n", [req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];

        NSMutableString *stamp = [dict objectForKey:@"timestamp"];

        //调起微信支付
        PayReq *req = [[PayReq alloc] init];
        req.openID = [dict objectForKey:@"appid"];
        req.partnerId = [dict objectForKey:@"partnerid"];
        req.prepayId = [dict objectForKey:@"prepayid"];
        req.nonceStr = [dict objectForKey:@"noncestr"];
        req.timeStamp = stamp.intValue;
        req.package = [dict objectForKey:@"package"];
        req.sign = [dict objectForKey:@"sign"];

        [WXApi sendReq:req];
    }
}

@end
