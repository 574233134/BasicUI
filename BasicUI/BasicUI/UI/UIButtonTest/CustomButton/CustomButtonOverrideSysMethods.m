//
//  CustomButtonOverrideSysMethods.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/17.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomButtonOverrideSysMethods.h"

@implementation CustomButtonOverrideSysMethods

// 设置backGroundImage 时会调该方法 参数为btn的bounds
- (CGRect)backgroundRectForBounds:(CGRect)bounds
{
    CGFloat originx = bounds.origin.x;
    CGFloat originy = bounds.origin.y;
    CGFloat originWidth = bounds.size.width;
    CGFloat originHeight = bounds.size.height;
    return CGRectMake(originx+5, originy+5, originWidth-10, originHeight-10);
}

// 任何情况都会调用此方法  参数为button的bounds
- (CGRect)contentRectForBounds:(CGRect)bounds
{
    CGFloat originx = bounds.origin.x;
    CGFloat originy = bounds.origin.y;
    CGFloat originWidth = bounds.size.width;
    CGFloat originHeight = bounds.size.height;
    return CGRectMake(originx+5, originy+5, originWidth-10, originHeight-10);
    
}

// 当button 使用setTitle 方法时会调用以下方法得到imageView 的位置(在此方法中不可调用self.titleLabel 会引起崩溃)
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat originx = contentRect.origin.x;
    CGFloat originy = contentRect.origin.y;
    CGFloat originWidth = contentRect.size.width;
    CGFloat originHeight = contentRect.size.height;
    return CGRectMake(originx+originWidth*0.25, originy, originWidth*0.75, originHeight);
}

// 当button 使用setImage 方法时会调用以下方法得到imageView 的位置(在此方法中不可调用self.imageView 会引起崩溃)
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat originx = contentRect.origin.x;
    CGFloat originy = contentRect.origin.y;
    CGFloat originWidth = contentRect.size.width;
    CGFloat originHeight = contentRect.size.height;
    return CGRectMake(originx, originy, originWidth*0.25, originHeight);
}

@end
