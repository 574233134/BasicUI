//
//  CircleView.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (void)drawRect:(CGRect)rect
{
    //设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    
    //创建UIBezierPath
    UIBezierPath *apath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 40, 200, 100)];
    apath.lineWidth     = 5.0f;
    apath.lineCapStyle  = kCGLineCapRound;
    apath.lineJoinStyle = kCGLineCapRound;
    
    //更具坐标连线
    [apath stroke];
}
@end
