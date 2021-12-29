//
//  CustomSearchTextField.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomSearchTextField.h"

@implementation CustomSearchTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.canTouch = YES;
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL result = [super pointInside:point withEvent:event];
    if (_canTouch)
    {
        return result;
    }
    else
    {
        return NO;
    }
}


@end
