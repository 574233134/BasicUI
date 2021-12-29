//
//  LMKViewAnimation.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/20.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "LMKViewAnimation.h"
#import "UIView+frame.h"
@interface LMKViewAnimation ()

@property (strong, nonatomic) IBOutlet UIView *animationView;

@property (strong, nonatomic) IBOutlet UIView *parentView;

@property (assign, nonatomic) CGRect animationFrame;

@end

@implementation LMKViewAnimation

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"UIView 动画";
    self.animationFrame = self.animationView.frame;
}


- (IBAction)moveAnimation:(UIButton *)sender
{
    CGFloat y = self.animationView.y;
    [UIView animateWithDuration:1 animations:^{
        [UIView setAnimationRepeatCount:5];//只是设置了动画的重复次数，并没有循环执行
        CGRect frame = self.animationView.frame;
        frame.origin.y = 300;
        self.animationView.frame = frame;
    } completion:^(BOOL finished) {
        
        if (finished) {
           self.animationView.y = y;
        }
    }];
}


- (IBAction)rotationAnimation:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationRepeatCount:4];
    [UIView setAnimationDelegate:self];//设置代理
    [UIView setAnimationDidStopSelector:@selector(animationStop)];//设置代理方法，动画停止调用
    self.animationView.transform= CGAffineTransformMakeRotation(3.14*1);
    [UIView commitAnimations];
}

- (void)animationStop
{
    NSLog(@"动画结束");
}

- (IBAction)Zoom:(UIButton *)sender
{
    [UIView animateWithDuration:1 animations:^{
         self.animationView.transform = CGAffineTransformScale(self.animationView.transform, 0.5, 0.5);
    } completion:^(BOOL finished) {
        if (finished)
        {
            self.animationView.transform = CGAffineTransformIdentity;//CGAffineTransformScale(self.myView.transform, 1, 1);
        }
    }];
}


#pragma mark - 视图切换过渡动画
- (IBAction)transitionAction:(UIButton *)sender
{
    [self transition1];
}

// 方法一
- (void)transition1
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.parentView cache:YES];
    [self.parentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [UIView commitAnimations];
}

// 方法二
- (void)transition2
{
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionFlipFromRight;
    [UIView transitionWithView:self.parentView duration:1 options:options animations:^{
        [UIView setAnimationRepeatCount:10];
        
        [self.parentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        
    } completion:^(BOOL finished) {
        NSLog(@"finished: %d",finished);
        
    }];
}

// 方法三
- (void)transition3
{
    [UIView animateWithDuration:1 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.parentView cache:YES];
        [self.parentView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    }];

}



@end
