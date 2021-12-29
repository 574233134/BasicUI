//
//  QRcodeManger.h
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/21.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QRcodeManger : NSObject

+ (UIImage *)generateQRCode:(NSString *)info size:(CGSize)size;

+ (UIImage *)generateQRCode:(NSString *)info size:(CGSize)size frontColor:(UIColor *)frontColor bgColor:(UIColor *)bgColor centerIcon:(UIImage *)icon;

+(UIImage *)generateQRImageWithCode:(NSString *)code size:(CGFloat)size frontImage:(UIImage *)frontImage bgColor:(UIColor *)bgColor;


+ (UIImage *)changeQRColor:(UIImage *)qrImage qrcolor:(UIColor *)qrColor bgColor:(UIColor *)bgColor;

+ (UIImage *)addCenterIcon:(UIImage *)qrImage icon:(UIImage *)centerIcon size:(CGFloat)size;

+ (UIImage *)getHDImage:(UIImage *)img size:(CGSize)size;
@end
