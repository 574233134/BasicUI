//
//  UIView+Touch.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "UIView+Touch.h"
#import <objc/runtime.h>

@implementation UIView (Touch)

static const char * UN_TOUCH_KEY = "UN_TOUCH";
static const char * UN_TOUCH_RECT_KEY = "UN_TOUCH_RECT";

+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod([UIView class], @selector(pointInside:withEvent:)), class_getInstanceMethod([UIView class], @selector(cus_pointInside:withEvent:)));
}

- (void)setUnTouch:(BOOL)unTouch
{
    objc_setAssociatedObject(self, UN_TOUCH_KEY, [NSNumber numberWithInt:unTouch], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)unTouch
{
    return objc_getAssociatedObject(self, UN_TOUCH_KEY) ? [objc_getAssociatedObject(self, UN_TOUCH_KEY) boolValue] : NO;
}

- (void)setUnTouchRect:(CGRect)unTouchRect
{
    objc_setAssociatedObject(self, UN_TOUCH_RECT_KEY, [NSValue valueWithCGRect:unTouchRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)unTouchRect
{
    return objc_getAssociatedObject(self, UN_TOUCH_RECT_KEY) ? [objc_getAssociatedObject(self, UN_TOUCH_RECT_KEY) CGRectValue] : CGRectZero;
}

- (BOOL)cus_pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.unTouch) return NO;
    if (self.unTouchRect.origin.x == 0 && self.unTouchRect.origin.y == 0 && self.unTouchRect.size.width == 0 && self.unTouchRect.size.height == 0)
    {
        return [self cus_pointInside:point withEvent:event];
    }
    else
    {
        if (CGRectContainsPoint(self.unTouchRect, point))
            return NO;
        else
            return [self cus_pointInside:point withEvent:event];
    }
}

@end
