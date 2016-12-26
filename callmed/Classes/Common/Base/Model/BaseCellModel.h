//
//  BaseCellModel.h
//  callmec
//
//  Created by sam on 16/7/9.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BaseModel.h"

@interface BaseCellModel : BaseModel
@property (nonatomic,copy) NSString *ids;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString<Optional> *type;
@property (nonatomic,copy) NSString<Optional> *hasChanged;
@property (nonatomic,assign) BOOL hasMore;
@property (nonatomic,assign) BOOL isEnable;
@end
