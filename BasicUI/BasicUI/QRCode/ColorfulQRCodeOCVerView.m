//
//  ColorfulQRCodeOCVerView.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/19.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "ColorfulQRCodeOCVerView.h"


@interface ColorfulQRCodeOCVerView()
@property (strong, nonatomic) CALayer *maskLayer;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@end

@implementation ColorfulQRCodeOCVerView


- (CALayer *)maskLayer {
    if (_maskLayer == nil) {
        _maskLayer = [CALayer new];
        [self.layer addSublayer:_maskLayer];
    }
    return _maskLayer;
}

- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
       _gradientLayer = [CAGradientLayer new];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1, 1);
        _gradientLayer.locations = @[@0.2, @0.4, @0.6,@0.8];
        _gradientLayer.colors = [NSArray arrayWithObjects:
                           (__bridge id)[UIColor redColor].CGColor,
                           (__bridge id)[UIColor orangeColor].CGColor,
                           (__bridge id)[UIColor blueColor].CGColor,
                           (__bridge id)[UIColor purpleColor].CGColor ,
                           nil];
        [self.layer addSublayer: _gradientLayer];
        _gradientLayer.frame = self.bounds;
    }
    return _gradientLayer;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = UIColor.whiteColor;
}

- (void)syncFrame {
    self.maskLayer.frame = self.bounds;
    self.gradientLayer.frame = self.bounds;
}

// 设置黑白二维码图片
- (void)setQRCodeImage:(UIImage *)qrcodeImage {
    UIImage *maskImage = [self genQRCodeImageMask: qrcodeImage];
    self.maskLayer.contents = (__bridge id)maskImage.CGImage;
    self.maskLayer.frame = self.bounds;
    self.gradientLayer.mask = self.maskLayer;
}

- (UIImage *)genQRCodeImageMask:(UIImage *)image {
    if (image != nil) {
        int bitsPerComponent = 8;
        int bytesPerPixel = 4;
        int width = image.size.width;
        int height = image.size.height;
        unsigned char * imageData = (unsigned char *)malloc(width * height * bytesPerPixel);
        // 将原始黑白二维码图片绘制到像素格式为ARGB的图片上，绘制后的像素数据在imageData中。
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef imageContext = CGBitmapContextCreate(imageData, width, height, bitsPerComponent, bytesPerPixel * width, colorSpace, kCGImageAlphaPremultipliedFirst);
        UIGraphicsPushContext(imageContext);
        CGContextTranslateCTM(imageContext, 0, height);
        CGContextScaleCTM(imageContext, 1, -1);
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        CGColorSpaceRelease(colorSpace);
        
        // 根据每个像素R通道的值修改Alpha通道的值，当Red大于100，则将Alpha置为0，反之置为255
        for (int row = 0; row < height; ++row) {
            for (int col = 0; col < width; ++col) {
                int offset = row * width * bytesPerPixel + col * bytesPerPixel;
                unsigned char r = imageData[offset + 1];
                unsigned char alpha = r > 100 ? 0 : 255;
                imageData[offset] = alpha;
            }
        }
        
        CGImageRef cgMaskImage = CGBitmapContextCreateImage(imageContext);
        UIImage *maskImage = [UIImage imageWithCGImage:cgMaskImage];
        CFRelease(cgMaskImage);
        UIGraphicsPopContext();
        CFRelease(imageContext);
        
        free(imageData);
        return maskImage;
    }
    return nil;
}

@end
