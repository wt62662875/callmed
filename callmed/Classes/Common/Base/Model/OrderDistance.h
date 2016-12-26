//
//  OrderDistance.h
//  callmed
//
//  Created by sam on 16/9/4.
//  Copyright © 2016年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDistance : NSObject

@property (nonatomic,copy) NSString *ids;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,assign) CGFloat distancef;
@property (nonatomic,copy) CLLocation *location;
@property (nonatomic,copy) CLLocation *slocation;
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSString *km;
@property (nonatomic,copy) NSDate *date;
@property (nonatomic,copy) NSMutableArray *pointsArray;

- (NSMutableArray*) pickPoints;
@end
