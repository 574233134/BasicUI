//
//  PhoneBasicInfo.h
//  BasicUI
//
//  Created by 李梦珂 on 2019/4/15.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneBasicInfo : NSObject

/** 广告标示符（IDFA-identifierForIdentifier */
+ (NSString *)getIDFAString;

/** Vendor标示符 (IDFV-identifierForVendor) */
+ (NSString *)getIDFVString;

+ (NSString *)getUUID;

+ (NSString *)getUDID;

+ (NSString *)getOsVersion;

+ (NSString *)getDeviceModel;

+ (NSString *)getAppName;

+ (NSString *)getAppBuild;

+ (NSString *)getAppVersion;

+ (NSString *)getIPAdress;

/** 获取当前App的包名信息 */
+ (NSString *)getAppBundleId;

@end

