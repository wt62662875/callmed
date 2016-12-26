//
//  CommonUtility.m
//  SearchV3Demo
//
//  Created by songjian on 13-8-22.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CommonUtility.h"

static NSDateFormatter *formater;

@implementation CommonUtility
+ (NSString*) convertLenght:(NSString*)param
{
    if ([@"1" isEqualToString:param]) {
        return @"小于1米";
    }else if ([@"1.5" isEqualToString:param]) {
        return @"1-1.5米";
    }else if ([@"1.7" isEqualToString:param]) {
        return @"1.5-1.7米";
    }else if ([@"1.8" isEqualToString:param]) {
        return @"1.5-1.8米";
    }else if ([@"1.78" isEqualToString:param]) {
        return @"1.5-1.78米";
    }
    return param;
}

+ (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil) {
        return NULL;
    }
    if (token == nil) {
        token = @",";
    }
    NSString *str = @"";
    if (![token isEqualToString:@","]) {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    else {
        str = [NSString stringWithString:string];
    }
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL) {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++) {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}

+ (NSArray *)pathForCoordinateString:(NSString *)coordinateString
{
    if (coordinateString.length == 0)
    {
        return nil;
    }
    
    NSUInteger count = 0;
    
    CLLocationCoordinate2D *coordinates = [CommonUtility coordinatesForString:coordinateString
                                                              coordinateCount:&count
                                                                   parseToken:@";"];
    
    NSMutableArray * path = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++)
    {
        CLLocation * loc = [[CLLocation alloc] initWithCoordinate:coordinates[i] altitude:0.0 horizontalAccuracy:0.0 verticalAccuracy:0.0 timestamp:[NSDate date]];
        [path addObject:loc];
    }
    return path;
}

+ (NSString*) getDriverOrderDescription:(NSString*)state
{
    NSInteger stateI = [state integerValue];
    NSString *descript=@"";
    switch (stateI) {
        case -1:
            descript=@"订单已取消";
            break;
        case 1:
            descript=@"新增订单";
            break;
        case 2:
            descript = @"待确认";
            break;
        case 3:
            descript = @"到达乘客位置";
            break;
        case 4:
            descript = @"开始行程";
            break;
        case 5:
            descript = @"行程结束";
            break;
        case 6:
            descript = @"待支付";
            break;
        case 7:
            descript = @"付款成功";
            break;
        case 8:
            descript = @"已评论";
            break;
        case 20:
            descript=@"未完成订单";
            break;
        case 100:
            descript=@"订单关闭";
            break;
        default:
            break;
    }
    return descript;
}
+ (NSString*) getOrderDescription:(NSString*)state
{
    NSInteger stateI = [state integerValue];
    NSString *descript=@"";
    switch (stateI) {
        case -1:
            descript=@"订单已取消";
            break;
        case 1:
            descript=@"新增订单";
            break;
        case 2:
            descript = @"待司机确认";
            break;
        case 3:
            descript = @"确认订单";
            break;
        case 4:
            descript = @"待行程开始";
            break;
        case 5:
            descript = @"行程开始";
            break;
        case 6:
            descript = @"待付款";
            break;
        case 7:
            descript = @"订单完成";
            break;
        case 8:
            descript = @"已评论";
            break;
        case 20:
            descript=@"未完成订单";
            break;
        case 100:
            descript=@"订单关闭";
            break;
        default:
            break;
    }
    /*
     public static int STATE_ORDER_NEW = 1; // 新增, 提交后等待司机抢单
     public static int STATE_ORDER_CONFIRM_PENDNG = 2; // 提交后司机抢到单后， 等待司机确认
     public static int STATE_ORDER_CONFIRMED = 3; //司机确认订单 , 开始出发到目的地
     public static int STATE_ORDER_EXECUTE_PENDING = 4; //司机点了到达目的地, 等待行程开始
     public static int STATE_ORDER_EXECUTE = 5; // 订单执行中, 司机开始点行程开始
     public static int STATE_ORDER_PAY_PENDING = 6; // 订单执行完毕, 司机开始点了行程结束, 等待乘客付款
     public static int STATE_ORDER_FINISHED = 7; // 订单付款成功,该订单完成,如果订单付款失败， 继续回退到等待付款
     public static int STATE_ORDER_COMMENTED = 8; // 订单完成后，被评论
     public static int STATE_ORDER_CANCEL = -1; // 订单被取消，乘客或者司机点了取消订单
     public static int STATE_ORDER_CLOSED = 100; // 订单关闭，司机或者乘客点了关闭订单，这种一般是在取消后，双方确认后，订单由司机改成关闭状态
     public static int STATE_ORDER_UNFINISHED = 20; // 所有未完成的订单, 包括 1, 2, 3, 4, 5, 6
     */
    return descript;
}

+ (NSString*) userHeaderImageUrl:(NSString*)ids
{
    return [NSString stringWithFormat:@"%@getMHeadIcon?id=%@&token=%@",kserviceURL,
            ids,
            [GlobalData sharedInstance].user.session];
}

+ (NSString*) driverHeaderImageUrl:(NSString*)ids
{
    return [NSString stringWithFormat:@"%@getDHeadIcon?id=%@&token=%@",kserviceURL,
            ids,
            [GlobalData sharedInstance].user.session];
}

+ (NSString*) driverPictureUrl:(NSString*)ids withType:(NSString*)type
{
    return [NSString stringWithFormat:@"%@getDPicture?id=%@&token=%@&type=%@",kserviceURL,
            ids,
            [GlobalData sharedInstance].user.session,
            type];
}

+ (void) updateLocationWithLongitude:(NSString*)lo latitude:(NSString*)la success:(QuerySuccessBlock)suc  failed:(QueryErrorBlock)fail
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (lo) {
        [param setObject:lo forKey:@"longitude"];
    }
    if (la) {
        [param setObject:la forKey:@"latitude"];
    }
    if ([[GlobalData sharedInstance].user.userInfo.ids integerValue]>0) {
        [param setObject:[GlobalData sharedInstance].user.userInfo.ids forKey:@"id"];
    }else{
        NSLog(@"UserId is 0 or null");
        return;
    }
    
    [HttpShareEngine callWithFormParams:param withMethod:@"dUpdateLocation" succ:^(NSDictionary *resultDictionary) {
        NSLog(@"更新成功");
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        NSLog(@"%@",errorMessage);
    }];
}

+ (void) callTelphone:(NSString*)number
{
    //number @"tel://8008808888"
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]];
}

+(void) callMessage:(NSString *)number{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",number]]];
}

+ (NSString*) convertDateToString:(NSDate*)date withFormat:(NSString*)formater_str
{
    if (!formater) {
        formater = [[NSDateFormatter alloc] init];
    }
    if (formater_str) {
        [formater setDateFormat:formater_str];
    }
    return [formater stringFromDate:date];
}

+ (NSString*) convertDateToString:(NSDate*)date
{
    return [CommonUtility convertDateToString:date withFormat:@"yyyy-MM-dd hh:mm:ss"];
}

+ (NSInteger) compareDateToNow:(NSDate*)date{

    
    NSUInteger unitFlags = NSSecondCalendarUnit; //NSHourCalendarUnit|NSDayCalendarUnit|
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *cp =[calendar components:unitFlags fromDate:date toDate:[NSDate date] options:NSCalendarWrapComponents];
    return cp.second;
}

+ (NSInteger) compareDateStringToNow:(NSString*)date withFormat:(NSString*)formater
{
    NSDateFormatter *former = [[NSDateFormatter alloc] init];
    if (formater) {
        [former setDateFormat:formater];
    }else{
        [former setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    }
    NSLog(@"ts:date:%@",[former stringFromDate:[NSDate dateWithTimeIntervalSince1970:[date floatValue]/1000]]);
    NSLog(@"now:date:%@",[former stringFromDate:[NSDate date]]);
    if ([CommonUtility validateNumber:date]) {
        return [CommonUtility compareDateToNow:[[NSDate alloc] initWithTimeIntervalSince1970:[date floatValue]/1000]];
    }
    return [CommonUtility compareDateToNow:[former dateFromString:date]];
}


+ (NSString*)versions
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString*)builds
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}


+ (BOOL) validateParams:(NSString*)params withRegular:(NSString*)regular
{
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regular];
    return [numberPre evaluateWithObject:params];
}

+ (BOOL) validateNumber:(NSString*)params
{
    ///(^\d+(\.)?)?\d+$
    NSString *number=@"(^\\d+(\\.)?)?\\d+$";//@"^\\d+\\.?\\d+$";//^\d+\.?\d+$ @"^[0-9]+$"
    return [CommonUtility validateParams:params withRegular:number];
}

+ (BOOL) validateSizeForm:(NSString*)params
{
    NSString *size = @"^\\d+(x|X)\\d+(x|X)\\d+$";
    return [CommonUtility validateParams:params withRegular:size];
}

+ (BOOL) validatePhoneNumber:(NSString*)param
{
    NSString *regular = @"^1[3|4|5|7|8]\\d[0-9]\\d{7}$";
    return [CommonUtility validateParams:param withRegular:regular];
}

+ (void) changeVolumn
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isMessage_notf"] isEqualToString:@"0"]) {
        
    }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"isMessage_notf"] isEqualToString:@"1"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"isVoice_Set"] isEqualToString:@"1"]){
        
        //AudioServicesPlaySystemSound (1007);//声音
        
    }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"isMessage_notf"] isEqualToString:@"1"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"isVibration_Set"] isEqualToString:@"1"])
    {
//        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);//震动
    }
}


+ (BOOL) sd_removeImageCacheWithURL:(NSString*)surl;
{
    NSString *image_url_cache = [surl stringByAppendingString:@"cache_circle"];
    [[SDImageCache sharedImageCache] removeImageForKey:image_url_cache];
    return YES;
}
@end
