//
//  LMKScaleTransition.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/21.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "LMKScaleTransition.h"

@implementation LMKScaleTransition 

// 动画时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * containerView = [transitionContext containerView];
    UIView * fromView = fromVC.view;
    UIView * toView = toVC.view;
    [containerView addSubview:toView];
    
    [[transitionContext containerView] bringSubviewToFront:fromView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromView.alpha = 0.0;
        fromView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformMakeScale(1, 1);
        [transitionContext completeTransition:YES];
    }];
}

@end
