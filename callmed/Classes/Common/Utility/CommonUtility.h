//
//  CommonUtility.h
//  SearchV3Demo
//
//  Created by songjian on 13-8-22.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface CommonUtility : NSObject

+ (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token;

+ (NSString*) convertDateToString:(NSDate*)date;

+ (NSString*) convertDateToString:(NSDate*)data withFormat:(NSString*)formater;

+ (NSInteger) compareDateToNow:(NSDate*)date;

+ (NSInteger) compareDateStringToNow:(NSString*)date withFormat:(NSString*)formater;

+ (NSArray *)pathForCoordinateString:(NSString *)coordinateString;

+ (NSString*) getOrderDescription:(NSString*)state;

+ (NSString*) getDriverOrderDescription:(NSString*)state;

+ (NSString*) userHeaderImageUrl:(NSString*)ids;

+ (NSString*) driverHeaderImageUrl:(NSString*)ids;

+ (NSString*) driverPictureUrl:(NSString*)ids withType:(NSString*)type;

+ (NSString*) convertLenght:(NSString*)param;

+ (NSString*)versions;
+ (NSString*)builds;

+ (void) callTelphone:(NSString*)number;
+(void) callMessage:(NSString *)number;

+ (void) updateLocationWithLongitude:(NSString*)lo latitude:(NSString*)la success:(QuerySuccessBlock)suc failed:(QueryErrorBlock)fail;

+ (BOOL) validateParams:(NSString*)params withRegular:(NSString*)regular;
+ (BOOL) validateNumber:(NSString*)params;
+ (BOOL) validateSizeForm:(NSString*)params;
+ (BOOL) validatePhoneNumber:(NSString*)param;


+ (void) changeVolumn;


+ (BOOL) sd_removeImageCacheWithURL:(NSString*)url;
@end
