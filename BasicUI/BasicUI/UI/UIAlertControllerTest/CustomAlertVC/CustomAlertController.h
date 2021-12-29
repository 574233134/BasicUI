//
//  CustomAlertController.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/26.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertLayout.h"
#import "CustomAlertAction.h"

typedef NS_ENUM(NSInteger, CustomAlertControllerStyle) {
    CustomAlertControllerStyleAlert = 0,  // 中心位置
    CustomAlertControllerStyleActionSheet  // 底部位置
};


NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertController : UIViewController

@property (nonatomic, strong, nonnull) CustomAlertLayout *layout; // alertController字体和颜色设置
    
@property (nonatomic, assign) CustomAlertControllerStyle style; // 警告框类型
    
+ (instancetype _Nullable )alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message style:(CustomAlertControllerStyle)style;  // 与系统方法类似
    
    //修改色值和字体之后 使用此方法
- (void)layoutSettings;
    
- (void)addAction:(CustomAlertAction *_Nonnull)action;  // 添加动作

- (void)dismiss;
    
@end

NS_ASSUME_NONNULL_END
