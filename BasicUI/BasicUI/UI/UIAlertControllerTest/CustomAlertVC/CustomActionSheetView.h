//
//  CustomActionSheetView.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/26.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomAlertLayout,CustomAlertAction;

@protocol CustomActionSheetViewDelegete <NSObject>

- (void)didClickActionSheet;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CustomActionSheetView : UIView

@property (nonatomic, strong, nonnull) CustomAlertLayout *layout;
    
@property (nonatomic, strong, nonnull) UIView *labelView; // 上部视图包含titleLabel和messageLabel

@property (weak, nonatomic) id <CustomActionSheetViewDelegete> clickActionSheetDelegate;
    
+ (instancetype _Nullable)actionSheetViewWith:(nullable NSString *)title message:(nullable NSString *)message;
    
- (void)addAction:(CustomAlertAction *_Nullable)action;
    
@end

NS_ASSUME_NONNULL_END
