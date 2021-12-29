//
//  CustomAlertAnimation.m
//  presentTest
//
//  Created by 李梦珂 on 2018/9/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomAlertAnimation.h"
#import "UIView+frame.h"
@implementation CustomAlertAnimation

// 动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.2;
}

// 动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    UIView *toView = toVC.view;
    CGFloat duration = [self transitionDuration:transitionContext];
    
    if (toVC.isBeingPresented)
    {
        [containerView addSubview:toView];
        toView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            toView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancelled];
        }];
        
    }
    
    //Dismissal 已经开始dismiss
    if (fromVC.isBeingDismissed)
    {
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    }
}

@end
