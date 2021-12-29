//
//  BasicUIDemo.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/15.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#ifndef BasicUIDemo_h
#define BasicUIDemo_h

#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define iSiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iSiPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define iSiPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iSiPhoneXS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define iSBANG_Screen (iSiPhoneX || iSiPhoneXR || iSiPhoneXS || iSiPhoneXS_MAX)

#define STATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)

#define NARBARHEIGHT (44+STATUSBAR_HEIGHT)

#define TARBARHEIGHT (iSBANG_Screen ? 83 : 49)

#ifdef DEBUG
#define LMKLog(...) NSLog((@"lmk %s [%d] %@"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define LMKLog(...) do { } while(0)
#endif

#endif /* BasicUIDemo_h */
