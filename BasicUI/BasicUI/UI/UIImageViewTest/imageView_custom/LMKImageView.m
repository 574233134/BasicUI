//
//  LMKImageView.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/10.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "LMKImageView.h"
#import "UIView+frame.h"
@implementation LMKImageView

- (void)setCirclePhotoWithImage:(UIImage *)image
{
    if (image == nil)  return;
    CGSize size = image.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    [path addClip];
    
    [image drawAtPoint:CGPointZero];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
   
    self.image = resultImage;
}

- (void)setRectPhotoWithImage:(UIImage *)image
{
    if (image == nil) return;
    self.layer.cornerRadius = 5.0;
    self.clipsToBounds = YES;
    self.image = image;
}

- (void)setSixSidePhotoWithImage:(UIImage *)image
{
    if (image == nil) return;
    
    CGFloat imageViewWH = self.height;
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 2;
    [path moveToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2), (imageViewWH / 4))];
    [path addLineToPoint:CGPointMake((imageViewWH / 2), 0)];
    [path addLineToPoint:CGPointMake(imageViewWH - ((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2)), (imageViewWH / 4))];
    [path addLineToPoint:CGPointMake(imageViewWH - ((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2)), (imageViewWH / 2) + (imageViewWH / 4))];
    [path addLineToPoint:CGPointMake((imageViewWH / 2), imageViewWH)];
    [path addLineToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2), (imageViewWH / 2) + (imageViewWH / 4))];
    [path closePath];
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.lineWidth = 2;
    shapLayer.path = path.CGPath;
    self.layer.mask = shapLayer;
    self.image = image;
}

@end
