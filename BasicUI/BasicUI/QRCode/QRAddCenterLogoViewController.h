//
//  QRAddCenterLogoViewController.h
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/19.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddLogoComplete)(BOOL ischange,UIImage * _Nullable resultImage,UIImage *centerIcon);

NS_ASSUME_NONNULL_BEGIN

@interface QRAddCenterLogoViewController : UIViewController

@property (nonatomic, strong)UIImage *qrImage;

@property (nonatomic, strong)UIImage *resultImage;

@property (nonatomic, copy)AddLogoComplete completeBlock;

@property (nonatomic, strong)UIColor *frontColor;

@property (nonatomic, strong) UIColor *backgroundColor;

@end

NS_ASSUME_NONNULL_END
