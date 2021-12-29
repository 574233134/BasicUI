//
//  ViewControllerDirection.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/27.
//  Copyright © 2018 李梦珂. All rights reserved.
//

/*
 一：UIDeviceOrientation 设备方向
 typedef NS_ENUM(NSInteger, UIDeviceOrientation) {
 UIDeviceOrientationUnknown,
 UIDeviceOrientationPortrait,            // 设备竖直方向, home 键在下
 UIDeviceOrientationPortraitUpsideDown,  // 设备竖直方向, home 键在上
 UIDeviceOrientationLandscapeLeft,       // 设备水平方向, home 键在右
 UIDeviceOrientationLandscapeRight,      // 设备水平方向, home 键在左
 UIDeviceOrientationFaceUp,              // 设备屏幕面向自己
 UIDeviceOrientationFaceDown             // 设备屏幕背朝自己
 };

 
 二：UIInterfaceOrientation 界面方向
 typedef NS_ENUM(NSInteger, UIInterfaceOrientation) {
 UIInterfaceOrientationUnknown            = UIDeviceOrientationUnknown,
 UIInterfaceOrientationPortrait           = UIDeviceOrientationPortrait,
 UIInterfaceOrientationPortraitUpsideDown = UIDeviceOrientationPortraitUpsideDown,
 UIInterfaceOrientationLandscapeLeft      = UIDeviceOrientationLandscapeRight,
 UIInterfaceOrientationLandscapeRight     = UIDeviceOrientationLandscapeLeft
 };

 
 */

#import <UIKit/UIKit.h>

@interface ViewControllerDirection : UIViewController

@end
