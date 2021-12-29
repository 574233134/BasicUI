//
//  UIImage+SGExtend.h
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/19.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SGExtend)


//生成水印图片
+ (UIImage *)sg_createWatermarkWithSize:(CGSize)size text: (NSString *)text textFont: (UIFont *)textFont textColor: (UIColor *)textColor textInterval:(CGSize)textInterval textRotation:(CGFloat)textRotation;

+ (UIImage *)sg_getImageFromView:(UIView *)view;

+ (UIImage *)sg_getImageFromView:(UIView *)view scale:(CGFloat)scale;

+ (UIImage *)sg_createImageWithSize:(CGSize)size color:(UIColor *)color;

//创建一个给当前图片增加水印的图片
-(UIImage *)sg_addWatermarkWithText: (NSString *)text textFont: (UIFont *)textFont textColor: (UIColor *)textColor textInterval:(CGSize)textInterval textRotation:(CGFloat)textRotation;

//根据当前图片生成一个新尺寸的图片
- (UIImage *)sg_reSize:(CGSize)size;

- (UIImage *)sg_coverImage:(UIImage *)image imageFrame:(CGRect)frame;

- (UIImage *)sg_coverView:(UIView *)view;

- (UIImage *)sg_clearWithRect:(CGRect)rect;

//获取图片主色调
-(UIColor*)getMostColor;

@end

NS_ASSUME_NONNULL_END
