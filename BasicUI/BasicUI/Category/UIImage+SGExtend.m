//
//  UIImage+SGExtend.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/19.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "UIImage+SGExtend.h"


@implementation UIImage (SGExtend)

-(UIImage *)sg_addWatermarkWithText: (NSString *)text textFont: (UIFont *)textFont textColor: (UIColor *)textColor textInterval:(CGSize)textInterval textRotation:(CGFloat)textRotation
{
    UIColor *color = textColor;
    if (color == nil) {
        color = [self getMostColor];
    }
    UIImage *watermark = [UIImage sg_createWatermarkWithSize:self.size text:text textFont:textFont textColor:color textInterval:textInterval textRotation:textRotation];
    UIImage *finalImg = [self sg_coverImage:watermark imageFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    return finalImg;
}

+ (UIImage *)sg_createWatermarkWithSize:(CGSize)size text: (NSString *)text textFont: (UIFont *)textFont textColor: (UIColor *)textColor textInterval:(CGSize)textInterval textRotation:(CGFloat)textRotation
{
    if (size.width == 0 || size.width == 0 || text == nil || textFont == nil || textColor == nil) {
        return nil;
    }
    UIColor *color = textColor;
    if (color == nil) {
        color = [UIColor grayColor];
    }
    UIFont *font = textFont;
    if (font == nil) {
        font = [UIFont systemFontOfSize:20];
    }
    //绘制区域，宽高和原始图片宽高一样
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);

    //开始旋转上下文矩阵，绘制水印文字
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将绘制原点（0，0）调整到源image的中心
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(size.width/2, size.height/2));
    //以绘制原点为中心旋转
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(textRotation));
    //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-size.width/2, -size.height/2));
    
    //计算对角线长度
    CGFloat sqrtLength = sqrt(size.width * size.width + size.height * size.height);
    NSDictionary *attr = @{
                           NSFontAttributeName: font,
                           NSForegroundColorAttributeName :color,
                           };
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[text copy] attributes:attr];
    CGFloat strWidth = attrStr.size.width;
    CGFloat strHeight = attrStr.size.height;
    
    //计算需要绘制的列数和行数
    int horCount = sqrtLength / (strWidth + textInterval.width) + 1;
    int verCount = sqrtLength / (strHeight + textInterval.height) + 1;
    
    //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
    CGFloat orignX = -(sqrtLength-size.width)/2;
    CGFloat orignY = -(sqrtLength-size.height)/2;
    
    //在每列绘制时X坐标叠加
    CGFloat tempOrignX = orignX;
    //在每行绘制时Y坐标叠加
    CGFloat tempOrignY = orignY;
    for (int i = 0; i < horCount * verCount; i++) {
        [text drawInRect:CGRectMake(tempOrignX, tempOrignY, strWidth, strHeight) withAttributes:attr];
        if (i % horCount == 0 && i != 0) {
            tempOrignX = orignX;
            tempOrignY += (strHeight + textInterval.height);
        }else{
            tempOrignX += (strWidth + textInterval.width);
        }
    }
    //根据上下文制作成图片
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImg;
}

+ (UIImage *)sg_createImageWithSize:(CGSize)size color:(UIColor *)color
{
    if (color == nil || size.width == 0 || size.height == 0) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 50);
    [color setStroke];
    [color setFill];
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextDrawPath(context, kCGPathFillStroke);//若设置模式为kCGPathFill，只显示填充 //kCGPathFillStroke画线和填充都显示
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImg;
}

- (UIImage *)sg_reSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImg;
}
- (UIImage *)sg_coverImage:(UIImage *)image imageFrame:(CGRect)frame
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [image drawInRect:frame];
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImg;
}
- (UIImage *)sg_coverView:(UIView *)view
{
    UIImage *coverImage = [UIImage sg_getImageFromView:view];
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [coverImage drawInRect:view.frame];
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImg;
}
+ (UIImage *)sg_getImageFromView:(UIView *)view
{
    return [UIImage sg_getImageFromView:view scale:UIScreen.mainScreen.scale];
}
+ (UIImage *)sg_getImageFromView:(UIView *)view scale:(CGFloat)scale
{
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, UIScreen.mainScreen.scale);
    //2.获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3.截屏
    [view.layer renderInContext:ctx];
    
    //[view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    //4、获取新图片
    UIImage * finalImg = UIGraphicsGetImageFromCurrentImageContext();
    //6、关闭上下文
    UIGraphicsEndImageContext();
    return finalImg;
}
- (UIImage *)sg_clearWithRect:(CGRect)rect
{
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);

    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(ctx, rect);
    
    UIImage * finalImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return finalImg;
}

//根据图片获取图片的主色调
-(UIColor*)getMostColor
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(self.size.width/2, self.size.height/2);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, self.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
                
            }
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}



@end
