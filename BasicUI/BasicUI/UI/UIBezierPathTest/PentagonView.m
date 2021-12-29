//
//  PentagonView.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "PentagonView.h"

@implementation PentagonView

- (void)drawRect:(CGRect)rect
{
    // 设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    
    //创建UIBezierPath
    UIBezierPath *apath = ({
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth     = 5.0f;              //设置线条宽度
        path.lineCapStyle  = kCGLineCapRound;   //设置拐角
        path.lineJoinStyle = kCGLineCapRound;  //终点处理
        //设置起始点
        [path moveToPoint:CGPointMake(100, 0)];
        
        //增加线条
        [path addLineToPoint:CGPointMake(200, 40)];
        [path addLineToPoint:CGPointMake(160, 140)];
        [path addLineToPoint:CGPointMake(40, 140)];
        [path addLineToPoint:CGPointMake(0, 40)];
        
        //关闭路径
        [path closePath];
        
        path;
    });
    
    //根据坐标连线
    [apath stroke];
}

@end
