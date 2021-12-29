//
//  ColorfulQRCodeOCVerView.h
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/19.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorfulQRCodeOCVerView : UIView
- (void)syncFrame;
- (void)setQRCodeImage:(UIImage *)qrcodeImage;
- (UIImage *)genQRCodeImageMask:(UIImage *)image;
@end
