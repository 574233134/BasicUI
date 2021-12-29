//
//  CustomAlertAction.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/26.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomAlertAction,CustomAlertLayout;
typedef NS_ENUM(NSInteger,CustomAlertActionStyle) {
    CustomAlertActionStyleDefault = 0,
    CustomAlertActionStyleCancel,
    CustomAlertActionStyleDone
};

typedef void(^CustomAlertActionHandler)(CustomAlertAction *_Nonnull);

@interface CustomAlertAction : UIButton
@property (nonatomic, copy, nullable) NSString *title; // 按钮title
    
@property (nonatomic, assign) CustomAlertActionStyle style; // action类型
    
@property (nonatomic, copy, nullable) CustomAlertActionHandler handler;
    
//设置按钮UI属性
- (void)setActionLayout:(CustomAlertLayout *_Nonnull)layout;
    
//获取actionLayout
- (CustomAlertLayout *_Nonnull)getActionLayout;
    
    
+ (instancetype _Nonnull )actionWithTitle:(nullable NSString *)title style:(CustomAlertActionStyle)style handler:(void (^ __nullable)(CustomAlertAction * _Nonnull action))hanlder;

    
@end

