//
//  HitTestViewTwo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/21.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "HitTestViewTwo.h"

@implementation HitTestViewTwo

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        // 转换坐标系
        CGPoint newPoint = [self.responderView convertPoint:point fromView:self];
        // 判断触摸点是否在需要相应的View上
        if (CGRectContainsPoint(self.responderView.bounds, newPoint))
        {
            view = self.responderView;
        }
    }
    return view;
}

@end
