//
//  HttpDifinde.h
//  callmed
//
//  Created by Sam.yan on 16/10/12.
//  Copyright © 2016年 callmed. All rights reserved.
//

#ifndef HttpDifinde_h
#define HttpDifinde_h

@protocol CallBackDelegate <NSObject>

@optional
- (void) callback:(id)sender;
- (void) reloadData;
@end

// 失败回调
typedef void (^QueryErrorBlock)(NSInteger errorCode, NSString *errorMessage);

// 查询成功回调
typedef void (^QuerySuccessBlock)(NSDictionary* resultDictionary);

// 查询成功回调
typedef void (^QuerySuccessModelBlock)(id result);//结果是model

typedef void (^QueryProgress)(NSProgress *progress);//上传进度
//  查询列表查询成功回调
typedef void (^QuerySuccessListBlock)(NSArray* result,int pageCount,int recordCount);

typedef void (^LKSimpleBlock)();

typedef void (^LKObjectBlock)(id object);

typedef void (^DownloadSuccess)(NSString *filename);
typedef void (^DownloadFail)(NSInteger code,NSString *message);

#define kclient_id  @"2"


#define kserviceBase kservice   // 只要改变kserviceBase后面的值，就可以达到下面的全改

#define kserviceURL_Test @"http://work.huwochuxing.com/"
/*kserviceBase @"/app.php"*/
#define kserviceURL @"http://work.huwochuxing.com/"
/*kserviceBase @"/app.php"*/


#define kWebError  @"服务器繁忙"

#define GlobelColor [UIColor colorWithRed:228/255.0 green:63/255.0 blue:42/255.0 alpha:1]

#endif /* HttpDifinde_h */
