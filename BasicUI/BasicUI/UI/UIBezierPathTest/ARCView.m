
//
//  ARCView.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ARCView.h"

@implementation ARCView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    
    //创建UIBezierPath
    UIBezierPath *apath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 200)
                                                         radius:100 startAngle:M_PI / 2
                                                       endAngle:M_PI
                                                      clockwise:YES];
    apath.lineWidth     = 5.0f;
    apath.lineCapStyle  = kCGLineCapRound;
    apath.lineJoinStyle = kCGLineCapRound;
    
    //更具坐标连线
    [apath stroke];
}

@end
