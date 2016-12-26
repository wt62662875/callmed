//
//  OrderDistance.m
//  callmed
//
//  Created by sam on 16/9/4.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "OrderDistance.h"

@implementation OrderDistance

- (NSString*) distance{
    
    return [NSString stringWithFormat:@"%f",_distancef];
}

- (NSString*) km
{
    return [NSString stringWithFormat:@"%0.1f",_distancef/1000];
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"ids:%@ distance:%@ location:%@",
            _ids,
            self.distance,
            [NSString stringWithFormat:@"latitude:%f longitude:%f",
             _location?_location.coordinate.latitude:0.0f,
             _location?_location.coordinate.longitude:0.0f]];
}

- (NSMutableArray*) pointsArray
{
    if (_pointsArray) {
        return _pointsArray;
    }else{
        _pointsArray = [NSMutableArray array];
    }
    return _pointsArray;
}

- (NSMutableArray*) pickPoints
{
    if (_pointsArray && _pointsArray.count>16) {
        
        NSInteger rate = _pointsArray.count/16;
        NSMutableArray *outData = [NSMutableArray array];
        
        for (int i=0;i<16;i++) {
            NSInteger index = i*rate;
            if (index>_pointsArray.count) {
                break;
            }else{
                CLLocation *cloation = _pointsArray[index];
                [outData addObject:cloation];
            }
        }
        return outData;
    }
    return nil;
}
@end
