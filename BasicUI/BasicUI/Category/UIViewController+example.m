//
//  UIViewController+example.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/12.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "UIViewController+example.h"
#import <objc/runtime.h>

@implementation UIViewController (example)

static char MethodKey;
- (void)setMethod:(NSString *)method
{
    objc_setAssociatedObject(self, &MethodKey, method, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)method
{
    return objc_getAssociatedObject(self, &MethodKey);
}

@end
