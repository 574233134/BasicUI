//
//  ARCView.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//
/**
 
  弧线
 + (instancetype)bezierPathWithArcCenter:(CGPoint)center　　　　//圆心坐标
 
 　　　　　　　　　　　　　　　　　　radius:(CGFloat)radius　　　　//半径
 
 　　　　　　　　　　　　　　　　startAngle:(CGFloat)startAngle　　//弧形开始的角度
 
 　　　　　　　　　　　　　　　　 endAngle:(CGFloat)endAngle　　  //弧形结束的角度
 
 　　　　　　　　　　　　　　　　 clockwise:(BOOL)clockwise;         //正向还是反向画弧

 */
#import <UIKit/UIKit.h>

@interface ARCView : UIView

@end
