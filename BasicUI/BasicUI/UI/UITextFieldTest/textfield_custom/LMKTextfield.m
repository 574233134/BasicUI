//
//  LMKTextfield.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "LMKTextfield.h"

@implementation LMKTextfield


#pragma mark - 重写textfield方法
- (CGRect)borderRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + bounds.size.width - 50, bounds.origin.y + bounds.size.height -20, 16, 16);

}

// 文本区域位置
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset =CGRectMake(bounds.origin.x+35, bounds.origin.y, bounds.size.width-10, bounds.size.height);
    return inset;
}

// 设置placehoder位置
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+35, bounds.origin.y+2, bounds.size.width-10, bounds.size.height);
    return inset;
}

// 编辑文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset =CGRectMake(bounds.origin.x+35, bounds.origin.y, bounds.size.width-10, bounds.size.height);
    
    return inset;
}

// 清除按钮的位置
- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x+ bounds.size.width-50, bounds.origin.y+ bounds.size.height-20,16,16);
}

// 左视图位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect inset =CGRectMake(bounds.origin.x+15, bounds.origin.y+9,15,13);
    
    return inset;
}

// 右视图位置
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + bounds.size.width - 50, bounds.origin.y + bounds.size.height -20, 16, 16);

}

// 改变绘文字属性.重写时调用super可以按默认图形属性绘制,若自己完全重写绘制函数，就不用调用super了.
- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:rect];
}

// 重写改变绘制占位符属性.重写时调用super可以按默认图形属性绘制,若自己完全重写绘制函数，就不用调用super了
- (void)drawPlaceholderInRect:(CGRect)rect
{
    [super drawPlaceholderInRect:rect];
}

@end
