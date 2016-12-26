//
//  AspSandBoxHelper.m
//  MiGuFM
//
//  Created by sam on 15/12/1.
//  Copyright © 2015年 sam. All rights reserved.
//

#import "SandBoxHelper.h"

@implementation SandBoxHelper

+ (NSString *) sandBoxHomePath{
    return NSHomeDirectory();
}

+ (NSString *) sandBoxAppPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    NSString *path =[paths objectAtIndex:0];
    [SandBoxHelper hasLive:path];
    return path;
}

+ (NSString *) sandBoxDocPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path =[paths objectAtIndex:0];
    [SandBoxHelper hasLive:path];
    return path;
}

+ (NSString *) sandBoxLibPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/conf"];
    [SandBoxHelper hasLive:path];
    return path;
}

+ (NSString *) sandBoxLibCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)  sandBoxMediaVoicePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString *path =[[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches/Media/voice"];
    [SandBoxHelper hasLive:path];
    return path;

}

+ (NSString *) sandBoxTmpPath
{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}

+(void) saveProvisionCity:(NSDictionary*)city
{
    [city writeToFile:[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/province_city.plist"] atomically:YES];
}

+(NSDictionary*)fetchProvisionCity
{

   return [[NSMutableDictionary alloc] initWithContentsOfFile:[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/province_city.plist"]];
}

+ (BOOL)hasLive:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return NO;
}

+ (BOOL) fileExits:(NSString*)path
{
    return[[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (void) fileDelete:(NSString*)path
{
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if(error)
    {
        NSLog(@"%@",error);
    }else{
        NSLog(@"删除成功!");
    }
}

+(void) saveConfig:(NSDictionary*)config
{
    [config writeToFile:[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/config.plist"] atomically:YES];
}

//+ (ConfigurationInformationModel*) fetchConfig
//{
//    NSDictionary *dict = [SandBoxHelper fetchConfigDictionary];
//    if (dict) {
//        return [[ConfigurationInformationModel alloc] initWithDictionary:dict error:nil];
//    }else{
//        return [[ConfigurationInformationModel alloc] init];
//    }
//}

/**
 *  保存历史搜索记录
 */
+(void) saveHistorySearch:(NSArray*)historySearch
{
    NSString *path = [[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/historySearch.plist"];
    [historySearch writeToFile:path atomically:YES];
}
/**
 *  获取历史搜索记录
 */
+ (NSArray *)fetchHistorySearch
{
    NSString *path = [[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/historySearch.plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
    if (!array) {
        return nil;
    }
    return array;
}



+ (NSDictionary*) fetchConfigDictionary
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/config.plist"]];
    if (!dictionary) {
        return nil;
    }
    return dictionary;
}

+(BOOL) isDownloadHidden
{
//    return NO;
   NSDictionary *dictionary =  [SandBoxHelper fetchConfigDictionary];
    if (!dictionary) {
        return [SandBoxHelper isOrderHidden];
    }else{
        NSDictionary *dic = [dictionary objectForKey:@"download"];
        if (!dic) {
            return [SandBoxHelper isOrderHidden];
        }
        NSInteger value = [[dic objectForKey:@"on"] integerValue];
        if (value==1)
        {
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}

+(BOOL) isBiggerDataHidden
{
    NSDictionary *dictionary =  [SandBoxHelper fetchConfigDictionary];
    if (!dictionary) {
        return YES;
    }else{
        NSDictionary *dic = [dictionary objectForKey:@"bigdata"];
        NSInteger value = [[dic objectForKey:@"on"] integerValue];
        if (value==1)
        {
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}


+(BOOL) isOrderHidden
{
    NSDictionary *dictionary =  [SandBoxHelper fetchConfigDictionary];
    if (!dictionary) {
        return YES;
    }else{
        NSDictionary *dic = [dictionary objectForKey:@"order"];
        NSInteger value = [[dic objectForKey:@"on"] integerValue];
        if (value==1)
        {
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}

+ (NSString *) getShareUrl
{
    NSDictionary *dictionary =  [SandBoxHelper fetchConfigDictionary];

    NSDictionary *dic = [dictionary objectForKey:@"share"];
    return dic[@"host"]?dic[@"host"]:@"";
}

+ (NSMutableDictionary*) defaultConfig
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/default_config.plist"]];
    if (!dictionary) {
        dictionary = [[NSMutableDictionary alloc] init];
        //[dictionary setObject:kDefaultUrl forKey:@"host"];
        [dictionary writeToFile:[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/default_config.plist"] atomically:YES];
    }
    return dictionary;
}

+ (void) saveDefaultConfig:(NSMutableDictionary*)params
{
    if (params) {
        [params writeToFile:[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/default_config.plist"] atomically:YES];
    }
}

+ (NSString*) fetchDefaultHost
{
    return [[SandBoxHelper defaultConfig] objectForKey:@"host"];
}

+(void) saveDefaultHost:(NSString*)host
{
    if (host==nil) {
        NSLog(@"default host address is nil.");
        return;
    }
    NSMutableDictionary *config = [SandBoxHelper defaultConfig];
    [config setObject:host forKey:@"host"];
    [config writeToFile:[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/default_config.plist"] atomically:YES];
}

+(NSString *) fetchNormalQuestion
{
    return [[[SandBoxHelper fetchConfigDictionary] objectForKey:@"question"] objectForKey:@"host"];
}

+(NSString*) fetchBigDataUrl
{
    return [[[SandBoxHelper fetchConfigDictionary] objectForKey:@"bigdata"] objectForKey:@"host"];
}

+(NSString*) fetchOrderUrl
{
    return [[[SandBoxHelper fetchConfigDictionary] objectForKey:@"order"] objectForKey:@"host"];
}

+(NSInteger) fetchPromotCounts
{
    NSString *promote_counts = [[SandBoxHelper defaultConfig] objectForKey:@"promote_counts"];
    if (promote_counts!=nil) {
        return [promote_counts integerValue];
    }
    return 0;
}
+(void) savePromoteCounts:(NSInteger)counts
{
    //promote_counts
    NSMutableDictionary *config = [SandBoxHelper defaultConfig];
    [config setObject:[NSString stringWithFormat:@"%ld",(long)counts] forKey:@"promote_counts"];
    [config writeToFile:[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/default_config.plist"] atomically:YES];
}



+ (NSString*) fetchLoginNumber
{
    NSDictionary *dict = [SandBoxHelper fetchConfigDictionary];
    if (dict) {
        return dict[@"number"];
    }
    return nil;
}

+ (NSString*) fetchLoginRandomCode{
    NSDictionary *dict = [SandBoxHelper fetchConfigDictionary];
    if (dict) {
        return dict[@"random"];
    }
    return nil;
}

+ (void) saveLoginParams:(NSString*)number random:(NSString*)random
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:number forKey:@"number"];
    [param setObject:random forKey:@"random"];
    
    NSDictionary *dict = [SandBoxHelper fetchConfigDictionary];
    if (dict) {
        NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dict];
        [param setObject:number forKey:@"number"];
        [param setObject:random forKey:@"random"];
        
        [SandBoxHelper saveConfig:param];
        
    }else{
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setObject:number forKey:@"number"];
        [param setObject:random forKey:@"random"];
        [SandBoxHelper saveConfig:param];
    }
}

+ (void) saveData:(NSDictionary*)params withFilePath:(NSString*)path
{
    NSString *pa = [NSString stringWithFormat:@"%@%@",[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/"],path];
    [params writeToFile:pa atomically:YES];
}

+ (NSDictionary*)fetchCarPoolingInfo
{
    return [[NSMutableDictionary alloc] initWithContentsOfFile:[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/carpooling.plist"]];
    return nil;
}

+ (void) saveStartLocation:(NSDictionary*)location
{
    if (location) {
        [SandBoxHelper saveData:location withFilePath:@"start_location.plist"];
    }
}

+ (NSDictionary*)fetchStartLocation
{
    NSString *path = [[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/start_location.plist"];
    if ([SandBoxHelper fileExits:path]) {
        return [[NSMutableDictionary alloc] initWithContentsOfFile:[[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/start_location.plist"]];
    }
    return nil;
}

+ (void) cleanLocation
{
    NSString *path = [[SandBoxHelper sandBoxLibPrefPath] stringByAppendingFormat:@"/start_location.plist"];
    if ([SandBoxHelper fileExits:path]) {
        [SandBoxHelper fileDelete:path];
    }
}

+ (void) setVoiceStatus:(BOOL)status
{
    NSMutableDictionary *param = [SandBoxHelper defaultConfig];
    [param setObject:@(status) forKey:@"voice_status"];
    [SandBoxHelper saveDefaultConfig:param];
}

+ (BOOL) getVoiceStatus
{
    NSMutableDictionary *param = [SandBoxHelper defaultConfig];
    if ([param objectForKey:@"voice_status"]==nil) {
        return YES;
    }
    BOOL status = [[param objectForKey:@"voice_status"] boolValue];
    return status;
}
@end
