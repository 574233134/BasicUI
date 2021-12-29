//
//  PhoneBasicInfo.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/4/15.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "PhoneBasicInfo.h"
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import <OpenUDID.h>
#import "LMKNetWorkInfo.h"
@implementation PhoneBasicInfo

+ (NSString *)getIDFAString
{
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return adId;
}

+ (NSString *)getIDFVString
{
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return idfv;
}

// 获得的UUID(Universally Unique Identifier)值系统没有存储, 而且每次调用得到UUID，系统都会返回一个新的唯一标示符。如果你希望存储这个标示符，那么需要自己将其存储到NSUserDefaults, Keychain, Pasteboard或其它地方。
+(NSString *)getUUID
{
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    
    // NSUUID在iOS 6中才出现，这跟CFUUID几乎完全一样，只不过它是Objective-C接口。
    NSString *uuid = [[NSUUID UUID] UUIDString];

    return cfuuidString;
}


+ (NSString *)getUDID
{
    NSString *udid = [OpenUDID value];
    return udid ? udid : @"";
}

+ (NSString *)getOsVersion
{
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *) getDeviceModel
{
    return [UIDevice currentDevice].model;
}

+ (NSString *)getAppName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
}

+ (NSString *)getAppBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+(NSString *)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getIPAdress
{
    return  [LMKNetWorkInfo wiFiRouterAddress];
}

+ (NSString *)getAppBundleId
{
    NSBundle *currentBundle = [NSBundle mainBundle];
    NSDictionary *infoDictionary = [currentBundle infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleIdentifier"];
}
@end
