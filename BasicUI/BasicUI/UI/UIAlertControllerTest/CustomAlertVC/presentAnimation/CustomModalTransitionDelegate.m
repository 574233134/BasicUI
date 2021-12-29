//
//  CustomModalTransitionDelegate.m
//  presentTest
//
//  Created by 李梦珂 on 2018/9/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomModalTransitionDelegate.h"
#import "CustomAlertPresentationController.h"
#import "CustomAlertAnimation.h"
@implementation CustomModalTransitionDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [CustomAlertAnimation new];
   
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [CustomAlertAnimation new];

}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0)
{
    return [[CustomAlertPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
}
@end
