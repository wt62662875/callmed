//
//  CataItemModel.m
//  callmec
//
//  Created by sam on 16/8/8.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "CataItemModel.h"

@implementation CataItemModel

- (void) setDataArray:(NSMutableArray *)dataArray
{
    if (dataArray) {
        if (!_dataArray) {
            _dataArray = [NSMutableArray array];
        }
        [_dataArray removeAllObjects];
        for (NSDictionary *dict in dataArray) {
            AuthItemModel *model = [[AuthItemModel alloc] initWithDictionary:dict error:nil];
            [_dataArray addObject:model];
        }
    }
}
@end
