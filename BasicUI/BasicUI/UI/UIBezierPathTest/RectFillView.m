//
//  RectFillView.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "RectFillView.h"

@implementation RectFillView

- (void)drawRect:(CGRect)rect
{
    //设置线条颜色
    UIColor *color = [UIColor redColor];
    [color set];
    
    //创建UIBezierPath
    UIBezierPath *apath = [UIBezierPath bezierPathWithRect:CGRectMake(10, 40, 200, 100)];
    
    //更具坐标连线
    [apath fill];
}

@end
