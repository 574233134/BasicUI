//
//  CustomAlertView.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/26.
//  Copyright © 2018年 李梦珂. All rights reserved.
//


#import <UIKit/UIKit.h>
@class CustomAlertAction,CustomAlertLayout;

@protocol CustomAlertViewDelegate <NSObject>

- (void)didClickAlertAction;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertView : UIView
    
@property (nonatomic, strong, nonnull) CustomAlertLayout *layout;
    
@property (nonatomic, strong, nonnull) UIView *labelView; // 上部视图(包含titleLabel和messageLabel)
    
@property (nonatomic, strong, readonly) NSArray <CustomAlertAction *>* _Nullable actions;

@property (weak, nonatomic) id <CustomAlertViewDelegate> clickActionDelegate;

+ (instancetype _Nullable)alertViewWith:(nullable NSString *)title message:(nullable NSString *)message;
    
- (void)addAction:(CustomAlertAction *_Nullable)action;


    
@end

NS_ASSUME_NONNULL_END
