//
//  RoundRectView.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "RoundRectView.h"

@implementation RoundRectView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    
    //创建UIBezierPath
    UIBezierPath *apath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 40, 200, 100)
                                                byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight
                                                      cornerRadii:CGSizeMake(100, 100)];
    apath.lineWidth     = 5.0f;
    apath.lineCapStyle  = kCGLineCapRound;
    apath.lineJoinStyle = kCGLineCapRound;
    
    // 根据坐标连线
    [apath stroke];
}

@end
