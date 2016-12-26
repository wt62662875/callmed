//
//  HttpShareEngine.m
//  LotteryForZCW
//
//  Created by dodo on 14-7-10.
//  Copyright (c) 2014年 ZCW. All rights reserved.
//

#import "HttpShareEngine.h"
#import "DES3Util.h"
#import "GeTuiSdk.h"

NSString *const SessionInvalidNotification = @"SessionInvalidNotification";
NSString *const SessionInvalidTipKey = @"SessionInvalidTipKey";

@implementation HttpShareEngine

+ (HttpShareEngine *)sharedInstance
{
    static HttpShareEngine *instance;
    @synchronized(self)
    {
        if (!instance) {
            instance = [[HttpShareEngine alloc]init];
            [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                //网络变化的通知
                NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
                [GlobalData sharedInstance].netStatus = status;;
            }];
            // 开始监测网络
            [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        }
    }
    return instance;
}

+ (void)uploadImageWithHost:(NSString *)url
                     method:(NSString *)method
                  imageData:(NSData *)imageData
                       name:(NSString *)imageName
                   fileName:(NSString *)fileName
                   MIMEType:(NSString *)mimeType
                 parameters:(id)parameters
                    success:(QuerySuccessModelBlock)success
                    failure:(QueryErrorBlock)failure
{
    [HttpShareEngine uploadImageWithHost:url method:method imageData:imageData name:imageName fileName:fileName MIMEType:mimeType parameters:parameters progesss:nil success:success failure:failure];
}

+ (void) uploadImage:(NSData*)data parameters:(id)parameters
            progesss:(QueryProgress)progress
             success:(QuerySuccessModelBlock)success
             failure:(QueryErrorBlock)failure
{
    /*
     
     [HttpShareEngine uploadImageWithHost:kUploadImgUrl
     method:nil
     imageData:data
     name:@"headimgpic"
     fileName:[NSString stringWithFormat:@"image_%ld_%f.jpg",data.length,[NSDate.date timeIntervalSince1970]]
     MIMEType:@"image/jpeg"
     parameters:nil
     success:^(id result)
     
     */
    [HttpShareEngine uploadImageWithHost:nil
                                  method:nil
                               imageData:data
                                    name:@"headimgpic"
                                fileName:[NSString stringWithFormat:@"image_%ld_%f.jpg",(unsigned long)data.length,[NSDate.date timeIntervalSince1970]]
                                MIMEType:@"image/jpeg"
                              parameters:parameters
                                progesss:progress
                                 success:success
                                 failure:failure];
}
//上传图片请求
+ (void)uploadImageWithHost:(NSString *)url
                     method:(NSString *)method
                  imageData:(NSData *)imageData
                       name:(NSString *)imageName
                   fileName:(NSString *)fileName
                   MIMEType:(NSString *)mimeType
                 parameters:(id)parameters
                   progesss:(QueryProgress)prog
                    success:(QuerySuccessModelBlock)success
                    failure:(QueryErrorBlock)failure {
    
    if (url==nil) {
        url = @"";
    }
    NSString *ST=nil;
    @try {
        ST =[GlobalData sharedInstance].user.session;
    }
    @catch (NSException *exception) {
        NSLog(@"exception %@",exception);
    }
    @finally {
        
    }
    //App2/Upload/Images
    [[AFHTTPSessionManager manager] POST:url parameters:@{@"ST":ST?ST:@""} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:imageName fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * uploadProgress) {
        if (prog) {
            prog(uploadProgress);
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *data = responseObject[@"data"];
        if (data &&data.length>0)
        {
            id dic =[DES3Util AES128Decrypt:data];
            if (dic) {
                success(dic);
            }else{
                success(dic);
            }
        }else{
            failure(-100,responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(((NSHTTPURLResponse*)task.response).statusCode,[NSHTTPURLResponse localizedStringForStatusCode:((NSHTTPURLResponse*)task.response).statusCode]);
    }];
}



//上传多张图片请求
+ (id)uploadImageSWithHost:(NSString *)url
                    method:(NSString *)method
            imageDataArray:(NSArray *)imageDataArray
                   success:(QuerySuccessModelBlock)success
                   failure:(QueryErrorBlock)failure {
    if (url==nil) {
        url = @"";
    }
    NSString *ST=nil;
    @try {
        ST =[GlobalData sharedInstance].user.session;
    }
    @catch (NSException *exception) {
        NSLog(@"exception %@",exception);
    }
    @finally {
        
    }
    
    //App2/Upload/Images
    [[AFHTTPSessionManager manager] POST:url parameters:@{@"ST":ST?ST:@""} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        // 上传 多张图片
        for(NSInteger i = 0; i < imageDataArray.count; i++)
        {
            NSData * imageData = [imageDataArray objectAtIndex: i];
            // 上传的参数名
            NSString * Name = [NSString stringWithFormat:@"image%zi", i+1];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
            
            [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/png"];
        }
        
        
        
    } progress:^(NSProgress * uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *data = responseObject[@"data"];
        if (data) {
            id dic =[DES3Util AES128Decrypt:data];
            success(dic);
        }else{
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(((NSHTTPURLResponse*)task.response).statusCode,[NSHTTPURLResponse localizedStringForStatusCode:((NSHTTPURLResponse*)task.response).statusCode]);
    }];
    
    return nil;
}



/**
 *  网络请求通用接口
 *
 *  @param infoParams   请求参数
 *  @param method       请求接口名
 *  @param successBlock 成功回调
 *  @param errorBlock   失败回调
 */
- (void)callWithParams:(NSDictionary* )infoParams
                method:(NSString *)method
          OnCompletion:(QuerySuccessBlock)successBlock
               onError:(QueryErrorBlock)errorBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // 这里id是随机的 app自己定义的
    [dic setObject:method forKey:@"methods"];
    [HttpShareEngine createHeaderParams:dic];   //请求头参数
    if (infoParams != nil) {                    //请求提交参数
        if (![infoParams objectForKey:@"ST"]) {
            NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:infoParams];
            [param setObject:[GlobalData sharedInstance].user.session forKey:@"ST"];
            [dic setObject:param forKey:@"params"];
        }else{
            [dic setObject:infoParams forKey:@"params"];
        }
    }
    NSLog(@"param:%@ %@",kserviceURL_Test,[dic lk_JSONString]);
    //    NSLog(@"param:%@",dic);
    [[HttpAFNetworkEngine sharedManager] callWithParams:dic serviceUrl:kserviceURL_Test OnCompletion:^(NSDictionary *resultDictionary) {
        
        @try {
            NSInteger status = [resultDictionary[@"status"] integerValue];
            //resultDictionary 接口所有返回内容都会在这里  tatus  1成功 0 错误
            if (status == 0) {//正常返回
                if (resultDictionary[@"data"]) {
                    id data = [DES3Util AES128Decrypt:resultDictionary[@"data"]];
                    NSLog(@"%@", [data lk_JSONString]);
                    if (data) {
                        if (successBlock) {
                            successBlock(data);
                        }
                    }else{
                        if (errorBlock) {
                            errorBlock(-1,@"无法解析数据，获取数据失败");
                        }
                    }
                }else{
                    if (successBlock) {
                        successBlock(resultDictionary);
                    }
                }
            } else if (status) {          // 返回错误
                // session invalid
                //  code  错误代码 只有错误的饿时候才会有值，否则为空  code : ,
                NSInteger code = [resultDictionary[@"code"] integerValue];
                if (code == 4007) {  //ST无效
                    [[NSNotificationCenter defaultCenter] postNotificationName:SessionInvalidNotification object:nil userInfo:@{@"msg": resultDictionary[@"msg"] ?: @"请重新登录"}];
                    [[GlobalData sharedInstance].user logout];
                }
                if (errorBlock) {
                    errorBlock(code, resultDictionary[@"msg"]);
                }
            } else {
                if (errorBlock) {
                    errorBlock(-1, @"返回json数据不符合规格");
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"出现异常了:%@",exception);
            errorBlock(-1,[NSString stringWithFormat:@"%@",exception]);
        }
        @finally {
            
        }
    } onError:errorBlock];
}


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


- (void)callWithRawParams:(NSDictionary *)infoParams
                   method:(NSString *)method
             OnCompletion:(QuerySuccessBlock)successBlock
                  onError:(QueryErrorBlock)errorBlock {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:method forKey:@"methods"];   // 请求接口
    [HttpShareEngine createHeaderParams:dic];   // 请求头
    if (infoParams!=nil) {
        if (![infoParams objectForKey:@"ST"]) {
            NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:infoParams];
            [param setObject:[GlobalData sharedInstance].user.session forKey:@"ST"];
            [dic setObject:param forKey:@"params"];
        }else{
            [dic setObject:infoParams forKey:@"params"];
        }
    }
    [[HttpAFNetworkEngine sharedManager] callWithParams:dic
                                             serviceUrl:kserviceURL
                                           OnCompletion:^(NSDictionary *resultDictionary) {
                                               
                                               NSDictionary *result = resultDictionary[@"result"];
                                               if ([result[@"code"] integerValue] == 0) {
                                                   successBlock(resultDictionary);
                                               } else {
                                                   errorBlock([result[@"code"] integerValue], result[@"msg"]);
                                               }
                                           } onError:errorBlock];
}

- (void)callWithParams:(NSDictionary* )infoParams
                method:(NSString *)method
            serviceUrl:(NSString *)serviceUrl
          OnCompletion:(QuerySuccessListBlock)successBlock
               onError:(QueryErrorBlock)errorBlock
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:method forKey:@"methods"];//请求接口
    [HttpShareEngine createHeaderParams:dic];//请求头参数
    if (infoParams != nil) {
        if (![infoParams objectForKey:@"ST"]) {
            NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:infoParams];
            [param setObject:[GlobalData sharedInstance].user.session forKey:@"ST"];
            [dic setObject:param forKey:@"params"];
        }else{
            [dic setObject:infoParams forKey:@"params"];
        }
    }
    
    NSLog(@"param:%@",kserviceURL);
    NSLog(@"request param:%@",dic);
    [[HttpAFNetworkEngine sharedManager] callWithParams:dic serviceUrl:kserviceURL OnCompletion:^(NSDictionary *resultDictionary) {
        @try {
            // status  1成功 0 错误
            NSInteger status = [resultDictionary[@"status"] integerValue];
            //  resultDictionary 接口所有返回内容都会在这里
            if (status == 0) {//正常返回
                if (resultDictionary[@"data"]) {
                    id data = [DES3Util AES128Decrypt:resultDictionary[@"data"]];
                    NSLog(@"request data:%@", [data lk_JSONString]);
                    if (data) {
                        if (successBlock) {
                            NSArray *data_list = (NSArray*)data;
                            successBlock(data_list,0,(int)[data_list count]);
                        }
                    }else{
                        if (errorBlock) {
                            errorBlock(-1,@"无法解析数据，获取数据失败");
                        }
                    }
                }else{
                    if (successBlock) {
                        NSArray *data_list = [NSMutableArray array];
                        successBlock(data_list,0,(int)[data_list count]);
                    }
                }
            } else if (status) {          // 返回错误
                // session invalid
                //  code  错误代码 只有错误的饿时候才会有值，否则为空  code : ,
                NSInteger code = [resultDictionary[@"code"] integerValue];
                if (code == 4007) {  //ST无效
                    [[NSNotificationCenter defaultCenter] postNotificationName:SessionInvalidNotification object:nil userInfo:@{@"msg": resultDictionary[@"msg"] ?: @"请重新登录"}];
                    [[GlobalData sharedInstance].user logout];
                }
                if (errorBlock) {
                    errorBlock(code, resultDictionary[@"msg"]);
                }
            } else {
                if (errorBlock) {
                    errorBlock(-1, @"返回json数据不符合规格");
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@ 接口 出现异常了:%@",method,exception);
            errorBlock(-1,[NSString stringWithFormat:@"%@",exception]);
        }
        @finally {
            
        }
    } onError:errorBlock];
}

/** 创建公共的头信息接口 */
+ (void) createHeaderParams:(NSMutableDictionary *)dict
{
    [dict setObject:[NSString stringWithFormat:@"id%d",(arc4random()*100)] forKey:@"id"];
    NSString * UUID = [GlobalData getUUID];
    if (UUID) {
        NSMutableDictionary * headerMuDict = [NSMutableDictionary dictionary];
        NSString * valueString = @"nil";
        [headerMuDict setObject:valueString forKey:@"sdk_int"];
        [headerMuDict setObject:valueString forKey:@"brand"];
        [headerMuDict setObject:valueString forKey:@"model"];
        [headerMuDict setObject:valueString forKey:@"imsi"];
        [headerMuDict setObject:valueString forKey:@"manufacturer"];
        [headerMuDict setObject:valueString forKey:@"imei"];
        [headerMuDict setObject:[GlobalData sharedInstance].channel_id forKey:@"channel_id"];
        [dict setObject:headerMuDict forKey:@"header"];
    }
    
    [dict setObject:kclient_id forKey:@"client_id"];// 设置访问设备的类型 kclient_id  @"2"  2代表的是iOS
    
    // 设置版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [dict setObject:app_Version forKey:@"verson"];
}

+ (NSMutableDictionary*) createHeaderParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    return params;
}

+ (void)upLoadVoice:(NSData *)recordData voiceTime:(CGFloat)voiceTime succ:(QuerySuccessBlock)success fail:(QueryErrorBlock)failBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置请求格式
    manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    // 设置接收格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 将字典的类型的数据转化为
    //    NSString *infoParamsJson = [infoParams lk_JSONString];
    //[self addCustomHeader:manager headerDic:[HttpShareEngine creatHeaders:infoParamsJson method:method]];
    
    [manager POST:@"" parameters:@{@"source":@2, @"time":@(voiceTime)} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:recordData name:@"voice" fileName:@"voice.amr" mimeType:@"audio/amr"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功！");
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传失败！");
        if (failBlock) {
            failBlock(((NSHTTPURLResponse*)task.response).statusCode,
                      [NSHTTPURLResponse localizedStringForStatusCode:((NSHTTPURLResponse*)task.response).statusCode]);
        }
        
    }];
}

+ (void) downloadFile:(NSString*)url savePath:(NSString*)path
{
    if (!url) {
        
        NSLog(@"download url:%@ is nil",url);
        return;
    }
    NSString *temp = [SandBoxHelper sandBoxMediaVoicePath];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        NSLog(@"downloadProgress:%@",downloadProgress);
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response)
                                      {
                                          NSString *paths = [NSString stringWithFormat:@"%@/%@",temp,@"aa.mp3"];
                                          [SandBoxHelper hasLive:temp];
                                          NSLog(@"filepath:%@",paths);
                                          return [NSURL fileURLWithPath:paths];
                                      } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                          NSLog(@"下载完成%@ erro%@",filePath,error);
                                      }];
    [task resume];
}

+ (void) downloadVoiceFile:(NSString *)url progress:(QueryProgress)p success:(DownloadSuccess)success fail:(DownloadFail)fail
{
    if (url &&![url hasPrefix:@"http"]) {
        if([url hasSuffix:@".amr"])
        {
            NSString *urls = [url stringByReplacingOccurrencesOfString:@".amr" withString:@".wav"];
            success(urls);
        }else{
            success(url);
        }
        
        return;
    }
    NSString *temp = [SandBoxHelper sandBoxMediaVoicePath];
    [SandBoxHelper hasLive:temp];
    NSString *urls = url.copy;
    urls = [urls stringByReplacingOccurrencesOfString:@"/" withString:@""];
    urls = [urls stringByReplacingOccurrencesOfString:@":" withString:@""];
    urls = [urls stringByReplacingOccurrencesOfString:@"." withString:@""];
    urls = [urls stringByReplacingOccurrencesOfString:@"&" withString:@""];
    urls = [urls stringByReplacingOccurrencesOfString:@"?" withString:@""];
    urls = [urls stringByReplacingOccurrencesOfString:@"=" withString:@""];
    
    NSString *paths = [NSString stringWithFormat:@"%@/%@%@",temp,urls,@".arm"];
    if([SandBoxHelper fileExits:paths])
    {
        success(paths);
    }else{
        [HttpShareEngine downloadFile:url savePath:paths progress:p success:success fail:fail];
    }
}

+ (void) downloadFile:(NSString *)url savePath:(NSString *)path progress:(QueryProgress)p success:(DownloadSuccess)success fail:(DownloadFail)fail
{
    if (!url) {
        NSLog(@"download url:%@ is nil",url);
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        if(p)p(downloadProgress);
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response){
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"下载完成%@",filePath);
        if (error) {
            fail(-100,@"下载失败");
        }else{
            if (success) {
                success(path);
            }
        }
    }];
    [task resume];
}


+ (void) callWithFormParamsSync:(NSDictionary*)params withMethod:(NSString*)method succ:(QuerySuccessBlock)success fail:(QueryErrorBlock)failb
{
    NSString *url = [kserviceURL stringByAppendingString:method];
    NSLog(@"url:%@",url);
    [HttpAFNetworkEngine callWithFormParam:params serviceUrl:url OnCompletion:^(NSDictionary *resultDictionary){
        if (resultDictionary)
        {
            NSDictionary *result = (NSDictionary*)resultDictionary;
            if ([@"0" isEqualToString:[NSString stringWithFormat:@"%@",[result objectForKey:@"error"]]])
            {
                if (success) {
                    success(resultDictionary);
                }
            }else if([@"501" isEqualToString:[NSString stringWithFormat:@"%@",[result objectForKey:@"error"]]]){
                //[[GlobalData sharedInstance].user logout];
                [HttpShareEngine refreshToken];
                if (failb) {
                    failb([[result objectForKey:@"error"] integerValue],@"");
                }
            }else{
                if (failb) {
                    failb([[result objectForKey:@"error"] integerValue],[result objectForKey:@"message"]);
                }
            }
        }
    } onError:failb];
}
+ (void) callWithFormParams:(NSDictionary*)params withMethod:(NSString*)method succ:(QuerySuccessBlock)success fail:(QueryErrorBlock)failb
{
    NSString *url = [kserviceURL stringByAppendingString:method];
    NSLog(@"url:%@",url);
    NSLog(@"%@",params);
    [HttpAFNetworkEngine callWithFormParam:params serviceUrl:url OnCompletion:^(NSDictionary *resultDictionary){
        if (resultDictionary)
        {
            NSDictionary *result = (NSDictionary*)resultDictionary;
            NSLog(@"%@",result);
            if ([@"0" isEqualToString:[NSString stringWithFormat:@"%@",[result objectForKey:@"error"]]])
            {
                if (success) {
                    success(resultDictionary);
                }
            }else if([@"501" isEqualToString:[NSString stringWithFormat:@"%@",[result objectForKey:@"error"]]]){
                //[[GlobalData sharedInstance].user logout];
                [HttpShareEngine refreshToken];
                if (failb) {
                    failb([[result objectForKey:@"error"] integerValue],@"");
                }
            }else{
                if (failb) {
                    failb([[result objectForKey:@"error"] integerValue],[result objectForKey:@"message"]);
                }
            }
        }
    } onError:failb];
}


+ (void) callWithFormParams:(NSDictionary*)params withMethod:(NSString*)method succList:(QuerySuccessListBlock)list fail:(QueryErrorBlock)failb
{
    NSString *url = [kserviceURL stringByAppendingString:method];
    NSLog(@"url:%@ param:%@",url,params);
    [HttpAFNetworkEngine callWithFormParam:params serviceUrl:url OnCompletion:^(NSDictionary *resultDictionary){
        if (resultDictionary)
        {
            NSDictionary *result = (NSDictionary*)resultDictionary;
            NSLog(@"result:%@",result);
            if ([@"0" isEqualToString:[NSString stringWithFormat:@"%@",[result objectForKey:@"error"]]])
            {
                NSArray *dataList =[resultDictionary objectForKey:@"rows"];
                if (list) {
                    list(dataList,0,(int)dataList.count);
                }
            }else if([@"501" isEqualToString:[NSString stringWithFormat:@"%@",[result objectForKey:@"error"]]]){
                //[[GlobalData sharedInstance].user logout];
                [HttpShareEngine refreshToken];
                if (failb) {
                    failb([[result objectForKey:@"error"] integerValue],@"");
                }
            }else{
                if (failb) {
                    failb([[result objectForKey:@"error"] integerValue],[result objectForKey:@"message"]);
                }
            }
        }
    } onError:failb];
}

+ (void) callWithUrlParams:(NSDictionary*)params withMethod:(NSString*)method succ:(QuerySuccessBlock)success fail:(QueryErrorBlock)failb
{
    
    NSString *url = [kserviceURL stringByAppendingString:method];
    NSLog(@"url:%@",url);
    [HttpAFNetworkEngine callWithUrl:params serviceUrl:url OnCompletion:^(NSDictionary *resultDictionary){
        if (resultDictionary)
        {
            NSDictionary *result = (NSDictionary*)resultDictionary;
            if ([@"0" isEqualToString:[NSString stringWithFormat:@"%@",[result objectForKey:@"error"]]])
            {
                if (success) {
                    success(resultDictionary);
                }
            }else if([@"501" isEqualToString:[NSString stringWithFormat:@"%@",[result objectForKey:@"error"]]]){
                //[[GlobalData sharedInstance].user logout];
                [HttpShareEngine refreshToken];
                if (failb) {
                    failb([[result objectForKey:@"error"] integerValue],@"");
                }
            }else{
                if (failb) {
                    failb([[result objectForKey:@"error"] integerValue],[result objectForKey:@"message"]);
                }
            }
        }
    } onError:failb];
    
}

+ (void) callWithUrlParams:(NSDictionary*)params withMethod:(NSString*)method succList:(QuerySuccessListBlock)list fail:(QueryErrorBlock)failb
{
    NSString *url = [kserviceURL stringByAppendingString:method];
    NSLog(@"url:%@ param:%@",url,params);
    [HttpAFNetworkEngine callWithUrl:params serviceUrl:url OnCompletion:^(NSDictionary *resultDictionary){
        if (resultDictionary)
        {
            NSDictionary *result = (NSDictionary*)resultDictionary;
            NSLog(@"result:%@",result);
            if ([@"0" isEqualToString:[NSString stringWithFormat:@"%@",[result objectForKey:@"error"]]])
            {
                NSArray *dataList =[resultDictionary objectForKey:@"rows"];
                if (list) {
                    list(dataList,0,(int)dataList.count);
                }
            }else if([@"501" isEqualToString:[NSString stringWithFormat:@"%@",[result objectForKey:@"error"]]]){
                //[[GlobalData sharedInstance].user logout];
                [HttpShareEngine refreshToken];
                if (failb) {
                    failb([[result objectForKey:@"error"] integerValue],[result objectForKey:@"message"]);
                }
            }else{
                if (failb) {
                    failb([[result objectForKey:@"error"] integerValue],[result objectForKey:@"message"]);
                }
            }
        }
    } onError:failb];
}


+ (void) refreshToken
{
    /*
     // 如果token过期, 可以刷新token, 事实是重新登录
     Ext.Ajax.request({
     url : 'cRefreshToken',
     params : {
     loginName:'135888789456', // login name or phone or no
     loginPwd:'1234'
     },
     method : 'POST',
     success : function(response, opts) {
     
     }
     });
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *number = [SandBoxHelper fetchLoginNumber];
    if (number) {
        [params setObject:number forKey:@"loginName"];
    }
    NSString *random = [SandBoxHelper fetchLoginRandomCode];
    if (random) {
        [params setObject:random forKey:@"loginPwd"];
    }
    
    NSString *url = [kserviceURL stringByAppendingString:@"dRefreshToken"];
    [HttpAFNetworkEngine callWithUrl:params serviceUrl:url OnCompletion:^(NSDictionary *resultDictionary){
        if (resultDictionary)
        {
            NSDictionary *result = (NSDictionary*)resultDictionary;
            if ([@"0" isEqualToString:[NSString stringWithFormat:@"%@",[result objectForKey:@"error"]]])
            {
                UserInfoModel *userInfo = [[UserInfoModel alloc] initWithDictionary:[resultDictionary objectForKey:@"data"] error:nil];
                if (userInfo) {
                    NSString *token = [resultDictionary objectForKey:@"token"];
                    [GlobalData sharedInstance].user.session = token;
                    [GlobalData sharedInstance].user.isLogin = YES;
                    [GlobalData sharedInstance].user.userInfo = userInfo;
                    [[GlobalData sharedInstance].user save];
                    [GeTuiSdk bindAlias:[GlobalData sharedInstance].user.userInfo.phoneNo];
                }else{
                    [MBProgressHUD showAndHideWithMessage:@"解析失败" forHUD:nil];
                }
                
            }else{
                [[GlobalData sharedInstance].user logout];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_NEED_SIGN object:nil];
            }
        }
    } onError:^(NSInteger errorCode, NSString *errorMessage) {
        
    }];
}
@end
