//
//  GenerateQRCodeViewController.h
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/19.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

//容错率
typedef NS_ENUM(NSInteger, SGQR_CURRENTIONLEVEL) {
    SGQR_CURRENTIONLEVEL_L,
    SGQR_CURRENTIONLEVEL_M,
    SGQR_CURRENTIONLEVEL_Q,
    SGQR_CURRENTIONLEVEL_H,
};

NS_ASSUME_NONNULL_BEGIN

@interface GenerateQRCodeViewController : UIViewController

@property (nonatomic,assign) SGQR_CURRENTIONLEVEL currentLevel;

@end

NS_ASSUME_NONNULL_END
