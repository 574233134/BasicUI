//
//  CustomSwitch.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CustomSwitchShapeOval,
    CustomSwitchShapeRectangle,
    CustomSwitchShapeRectangleNoCorner
} CustomSwitchShape;

NS_ASSUME_NONNULL_BEGIN

@interface CustomSwitch : UIControl <UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL on;

@property (nonatomic, assign) CustomSwitchShape shape;


@property (nonatomic, strong) UIColor *onTintColor;


@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, strong) UIColor *thumbTintColor;

@property (nonatomic, assign) BOOL shadow;

@property (nonatomic, strong) UIColor *tintBorderColor;

@property (nonatomic, strong) UIColor *onTintBorderColor;


@property (nonatomic, strong) UILabel *onBackLabel;  // 打开时候的文字Label
@property (nonatomic, strong) UILabel *offBackLabel; // 关闭时候的文字Label

- (BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
