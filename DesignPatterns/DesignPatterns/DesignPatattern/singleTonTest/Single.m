//
//  Single.m
//  DesignPatterns
//
//  Created by Lin on 2019/3/11.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "Single.h"

@implementation Single
static  Single *sharedSingleClassName = nil;

+ (Single *)sharedSingleClassName
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleClassName = [[Single alloc] init];
    });
    return sharedSingleClassName;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (sharedSingleClassName == nil)
        {
            sharedSingleClassName = [super allocWithZone:zone];
        }
        return sharedSingleClassName;

    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
@end
