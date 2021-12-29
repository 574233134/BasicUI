//
//  CustomModelActionSheetDelegate.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomModelActionSheetDelegate.h"
#import "CustomActionSheetAnimation.h"
#import "CustomAlertPresentationController.h"
@implementation CustomModelActionSheetDelegate

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [CustomActionSheetAnimation new];
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [CustomActionSheetAnimation new];
    
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0)
{
    return [[CustomAlertPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
