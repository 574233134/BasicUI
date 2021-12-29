//
//  CustomLabel.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/10.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

/**
 * 以下两个Label的方法不可以直接调用，需要重写
 */

/**
 * 自定义Label文字与边框间距
 * 当重写了这个方法之后，使用时应该调用sizeToFit这个方法，不然的话，这个方法不会被调用。
 */
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    UIEdgeInsets insets = self.edgeInsets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    
    return rect;
}

/**
 * label具有UIViewContentModeRedraw的默认内容模式,如果不想更改直接调用父类的方法
 */
- (void)drawTextInRect:(CGRect)rect
{
    NSAttributedString *attributedString = self.attributedText;
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 1);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.attributedText = attributedString;
    [super drawTextInRect:rect];
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

- (void)expicalWords:(NSString *)keyWords color:(UIColor *)color
{
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSString *temp = nil;
    for (int i=0; i<noteStr.length; i++)
    {
        temp = [self.text substringWithRange:NSMakeRange(i,1)];
        if ([keyWords containsString:temp])
        {
            // 改变颜色
            [noteStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(i,1)];
        }
    }
    [self setAttributedText:noteStr];
}

- (void)containWords:(NSString *)keyWords color:(UIColor *)color
{
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange searchRange = NSMakeRange(0, self.text.length);
    while (searchRange.location != NSNotFound)
    {
        searchRange = [self.text rangeOfString:keyWords options:0 range:searchRange];
        
        NSLog(@"%@",NSStringFromRange(searchRange));
        
        if(searchRange.location != NSNotFound)
        {
            [noteStr addAttribute:NSForegroundColorAttributeName value:color range:searchRange];
            searchRange = NSMakeRange(searchRange.location+1, self.text.length-searchRange.location-1);
        }
    }
    [self setAttributedText:noteStr];
}

#pragma mark - 自适应宽度或高度
- (CGFloat)calculateRowWidthString:(NSString *)string withHeight:(CGFloat)height andFont:(UIFont *)font
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
}

- (CGFloat)calculateRowHeightString:(NSString *)string withWidth:(CGFloat)width andFont:(UIFont *)font
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}

@end
