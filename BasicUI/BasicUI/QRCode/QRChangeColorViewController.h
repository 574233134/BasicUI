//
//  QRChangeColorViewController.h
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/19.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeColorComplete)(BOOL ischange,UIImage * _Nullable resultImage,UIColor *frontColor,UIColor *bgColor);

NS_ASSUME_NONNULL_BEGIN

@interface QRChangeColorViewController : UIViewController

@property (nonatomic, strong)UIImage *qrImage;

@property (nonatomic, strong)UIImage *resultImage;

@property (nonatomic, copy)ChangeColorComplete completeBlock;

@property (nonatomic, strong)UIColor *frontColor;

@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, strong)UIImage *centerIcon;

@end

NS_ASSUME_NONNULL_END
