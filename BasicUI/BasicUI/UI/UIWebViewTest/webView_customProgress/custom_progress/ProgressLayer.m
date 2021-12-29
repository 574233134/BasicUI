//
//  ProgressLayer.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/19.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ProgressLayer.h"
#import <UIKit/UIKit.h>
#import "BasicUIDemo.h"
#import "NSTimer+controlAction.h"
static NSTimeInterval const timeInterval = 0.003;

@implementation ProgressLayer
{
    CAShapeLayer *_layer;
    NSTimer *_timer;
    CGFloat _plusWidth;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.lineWidth = 2;
    self.strokeColor = [UIColor greenColor].CGColor;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(progressChanged:) userInfo:nil repeats:YES];
    [_timer pause];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 2)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH, 2)];
    
    self.path = path.CGPath;
    self.strokeEnd = 0;
    _plusWidth = 0.01;
}

- (void)progressChanged:(NSTimer *)timer
{
    self.strokeEnd += _plusWidth;
    if (self.strokeEnd > 0.8)
    {
        _plusWidth = 0.002;
    }
}

- (void)startLoad
{
    self.hidden = NO;
    self.strokeEnd = 0.1;
    [_timer resumeWithTimeInterval:timeInterval];
}

- (void)finishedLoad
{
    [self closeTimer];
    self.strokeEnd = 1.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        self.strokeEnd = 0.1;
//        [self removeFromSuperlayer];
    });
}

- (void)dealloc
{
    [self closeTimer];
}

#pragma mark - private
- (void)closeTimer
{
    [_timer invalidate];
    _timer = nil;
}
@end
