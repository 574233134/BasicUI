//
//  ViewControllerDirection.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/27.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ViewControllerDirection.h"

@interface ViewControllerDirection ()

@end

@implementation ViewControllerDirection

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    NSLog(@"设备方向 %d",[UIDevice currentDevice].orientation);
    
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
    NSLog(@"界面显示方向 %d",[UIApplication sharedApplication].statusBarOrientation);
}




@end
