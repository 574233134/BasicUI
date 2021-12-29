//
//  CustomActionSheetAnimation.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomActionSheetAnimation.h"
#import "UIView+frame.h"
@implementation CustomActionSheetAnimation

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
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    CGFloat duration = [self transitionDuration:transitionContext];
    
    if (toVC.isBeingPresented)
    {
        [containerView addSubview:toView];
        CGFloat yValue = containerView.height - toView.height;
        toView.y = containerView.height;
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            toView.y = yValue;
        } completion:^(BOOL finished) {
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancelled];
        }];
        
    }
    
    //Dismissal 转场中不要将 toView 添加到 containerView
    if (fromVC.isBeingDismissed)
    {
        [UIView animateWithDuration:duration animations:^{
            fromView.y = containerView.height;
        } completion:^(BOOL finished) {
            BOOL isCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!isCancelled];
        }];
    }
}


@end
