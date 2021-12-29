//
//  QRcodeManger.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/21.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "QRcodeManger.h"
#import "UIImage+SGExtend.h"
// 纠错率  0.07  0.15  0.25  0.3
#define SGQR_CURRENTIONLEVEL 0.3
@implementation QRcodeManger

+ (UIImage *)generateQRCode:(NSString *)info size:(CGSize)size
{
    return [self generateQRCode:info size:size frontColor:nil bgColor:nil centerIcon:nil];
}

+ (UIImage *)generateQRCode:(NSString *)info size:(CGSize)size frontColor:(UIColor *)frontColor bgColor:(UIColor *)bgColor centerIcon:(UIImage *)icon;
{
    // 1. 生成滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜默认设置
    [filter setDefaults];
    /**
    * 3.设置数据(通过滤镜对象的KVC)
    */
    //把信息转化为NSData
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    //滤镜对象kvc存值
    [filter setValue:infoData forKeyPath:@"inputMessage"];
     [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    /**
    * 4.生成二维码
    */
    CIImage *outImage = [filter outputImage];
    UIImage *image = [UIImage imageWithCIImage:outImage];
    if (frontColor || bgColor) {
        image=[self changeQRColor:image qrcolor:frontColor bgColor:bgColor];
    }
    image = [self getHDImage:image size:size];
    if (icon) {
        image = [self addCenterIcon:image icon:icon size:size.height];
    }
    
    return image;
}

/*
inputImage,     需要设定颜色的图片
inputColor0,    前景色 - 二维码的颜色
inputColor1     背景色 - 二维码背景的颜色
*/
+ (UIImage *)changeQRColor:(UIImage *)qrImage qrcolor:(UIColor *)qrColor bgColor:(UIColor *)bgColor
{
    if (qrImage == nil) {
        return nil;
    }
    if (qrColor == nil && bgColor == nil) {
        return qrImage;
    }
    // 创建颜色过滤器
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    // 设置默认值
    [colorFilter setDefaults];
    [colorFilter setValue:qrImage.CIImage forKey:@"inputImage"];
    
    if (qrColor) {
        [colorFilter setValue:[CIColor colorWithCGColor:qrColor.CGColor] forKey:@"inputColor0"];
    }
    if (bgColor) {
        [colorFilter setValue:[CIColor colorWithCGColor:bgColor.CGColor] forKey:@"inputColor1"];
    }
    CIImage *outImage = [colorFilter outputImage];
    UIImage *image = [UIImage imageWithCIImage:outImage];
    return image;
}

+ (UIImage *)addCenterIcon:(UIImage *)qrImage icon:(UIImage *)centerIcon size:(CGFloat)size
{
    if (qrImage == nil || size == 0) {
        return nil;
    }
    UIImage *icon = [self clipCornerRadius:centerIcon withSize:CGSizeMake(centerIcon.size.width, centerIcon.size.height)];
    CGFloat iconScale = (size * size) / (qrImage.size.width * qrImage.size.height);

    if (centerIcon && iconScale > 0 && iconScale < SGQR_CURRENTIONLEVEL) {
        UIImage *image = [qrImage sg_coverImage:icon imageFrame:CGRectMake(qrImage.size.width / 2.0 - size / 2.0, qrImage.size.height / 2.0 - size / 2.0, size, size)];
        return image;
    }
    
    return qrImage;
}

+ (UIImage *)clipCornerRadius:(UIImage *)image withSize:(CGSize) size{
    
    // 白色border的宽度
    CGFloat outerWidth = size.width/15.0;
    // 黑色border的宽度
    CGFloat innerWidth = outerWidth/10.0;
    // 设置圆角
    CGFloat corenerRadius = size.width/5.0;
    // 为context创建一个区域
    CGRect areaRect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *areaPath = [UIBezierPath bezierPathWithRoundedRect:areaRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corenerRadius, corenerRadius)];
    // 因为UIBezierpath划线是双向扩展的 初始位置就不会是（0，0）
    // origin position
    CGFloat outerOrigin = outerWidth/2.0;
    CGFloat innerOrigin = innerWidth/2.0 + outerOrigin/1.2;
    CGRect outerRect = CGRectInset(areaRect, outerOrigin, outerOrigin);
    CGRect innerRect = CGRectInset(outerRect, innerOrigin, innerOrigin);
    //  外层path
    UIBezierPath *outerPath = [UIBezierPath bezierPathWithRoundedRect:outerRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(outerRect.size.width/5.0, outerRect.size.width/5.0)];
    //  内层path
    UIBezierPath *innerPath = [UIBezierPath bezierPathWithRoundedRect:innerRect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(innerRect.size.width/5.0, innerRect.size.width/5.0)];
    // 创建上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);{
        // 翻转context
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1, -1);
        // 1.先对画布进行裁切
        CGContextAddPath(context, areaPath.CGPath);
        CGContextClip(context);
        // 2.填充背景颜色
        CGContextAddPath(context, areaPath.CGPath);
        UIColor *fillColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillPath(context);
        // 3.执行绘制logo
        CGContextDrawImage(context, innerRect, image.CGImage);
        // 4.添加并绘制白色边框
        CGContextAddPath(context, outerPath.CGPath);
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, outerWidth);
        CGContextStrokePath(context);
        // 5.白色边框的基础上进行绘制黑色分割线
        CGContextAddPath(context, innerPath.CGPath);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextSetLineWidth(context, innerWidth);
        CGContextStrokePath(context);
    }CGContextRestoreGState(context);
    UIImage *radiusImage  = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return radiusImage;
}


+(UIImage *)generateQRImageWithCode:(NSString *)code size:(CGFloat)size frontImage:(UIImage *)frontImage bgColor:(UIColor *)bgColor
{
    UIImage *image = [self generateQRCode:code size:CGSizeMake(size, size) frontColor:[UIColor clearColor] bgColor:bgColor centerIcon:nil];
    if (image) {
        image = [[frontImage sg_reSize:CGSizeMake(size, size)] sg_coverImage:image imageFrame:CGRectMake(0, 0, size, size)];
    }
    
    return image;
}



// 高清图
+ (UIImage *)getHDImage:(UIImage *)img size:(CGSize)size
{
    CIImage *originImage = img.CIImage;
    CIImage *transformCIImage = [originImage imageByApplyingTransform:CGAffineTransformMakeScale(size.width / originImage.extent.size.width, size.height / originImage.extent.size.height)];

    UIImage *image = [UIImage imageWithCIImage:transformCIImage];
    return image;
}
@end
