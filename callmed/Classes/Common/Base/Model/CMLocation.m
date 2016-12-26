//
//  DDLocation.m
//  TripDemo
//
//  Created by xiaoming han on 15/4/2.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

#import "CMLocation.h"

@implementation CMLocation

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@, cityCode:%@, address:%@, coordinate:%f, %f", self.name, self.cityCode, self.address, self.coordinate.latitude, self.coordinate.longitude];
}

+ (CLLocation*) covertFromCMLoaction:(CMLocation*)location
{
    return [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
}
@end
