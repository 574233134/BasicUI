//
//  NSTimer+controlAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/19.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "NSTimer+controlAction.h"

@implementation NSTimer (controlAction)

- (void)pause
{
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resume
{
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time
{
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}
@end
