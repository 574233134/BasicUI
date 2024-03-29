//
//  LMKNetWorkInfo.h
//  BasicUI
//
//  Created by 李梦珂 on 2019/4/15.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LMKNetWorkInfo : NSObject
// Network Information

// Get Current IP Address
+ (nullable NSString *)currentIPAddress;

// Get Current MAC Address
+ (nullable NSString *)currentMACAddress;

// Get the External IP Address
+ (nullable NSString *)externalIPAddress;

// Get Cell IP Address
+ (nullable NSString *)cellIPAddress;

// Get Cell IPv6 Address
+ (nullable NSString *)cellIPv6Address;

// Get Cell MAC Address
+ (nullable NSString *)cellMACAddress;

// Get Cell Netmask Address
+ (nullable NSString *)cellNetmaskAddress;

// Get Cell Broadcast Address
+ (nullable NSString *)cellBroadcastAddress;

// Get WiFi IP Address
+ (nullable NSString *)wiFiIPAddress;

// Get WiFi IPv6 Address
+ (nullable NSString *)wiFiIPv6Address;

// Get WiFi MAC Address
+ (nullable NSString *)wiFiMACAddress;

// Get WiFi Netmask Address
+ (nullable NSString *)wiFiNetmaskAddress;

// Get WiFi Broadcast Address
+ (nullable NSString *)wiFiBroadcastAddress;

// Get WiFi Router Address
+ (nullable NSString *)wiFiRouterAddress;

// Connected to WiFi?
+ (BOOL)connectedToWiFi;

// Connected to Cellular Network?
+ (BOOL)connectedToCellNetwork;

// Connected to WiFi?
+ (BOOL)connectedToWiFiIPv6;

// Connected to Cellular Network?
+ (BOOL)connectedToCellNetworkIPv6;
@end

NS_ASSUME_NONNULL_END
