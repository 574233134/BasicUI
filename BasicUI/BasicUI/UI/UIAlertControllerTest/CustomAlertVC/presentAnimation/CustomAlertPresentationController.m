//
//  CustomAlertPresentationController.m
//  presentTest
//
//  Created by 李梦珂 on 2018/9/29.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomAlertPresentationController.h"

@implementation CustomAlertPresentationController

// 即将推出模态视图时调用
-(void)presentationTransitionWillBegin
{
    _dimmingView = [[UIView alloc]init];
    [self.containerView addSubview:_dimmingView];
    _dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    _dimmingView.frame = self.containerView.frame;

    __weak typeof (self) weakSelf = self;
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        weakSelf.dimmingView.bounds = weakSelf.containerView.bounds;
    } completion:nil];
}

// 模态视图即将消失时调用
-(void)dismissalTransitionWillBegin
{
    __weak typeof (self) weakSelf = self;
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        weakSelf.dimmingView.alpha = 0.0;
    } completion:nil];
}

@end
