//
//  CustomAlertLayout.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/26.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CustomAlertLayoutStyle){
    CustomAlertLayoutStyleAlert = 0,
    CustomAlertLayoutStyleActionSheet
};

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DEFAULT_COLOR [UIColor colorWithRed:0 green:0.48 blue:1 alpha:1]
#define DEFAULT_LINECOLOR [UIColor colorWithRed:0 green:0 blue:0.31 alpha:0.05]
#define WIDTHSCALE(awidth) [UIScreen mainScreen].bounds.size.width / 375 * awidth
#define HEIGHTSCALE(aheight) [[UIScreen mainScreen] bounds].size.height / 667 * aheight
#define ALERT_WIDTH 270
#define left_X 10  //actionSheetView的x坐标
#define label_X 16  //lable的x坐标
#define MAX_Y 30    //actionSheet最大高度时的Y坐标

@interface CustomAlertLayout : NSObject

@property (nonatomic, strong, nullable) UIColor *lineColor; // 分割线颜色  default R:0 G:0 B:0.31 A:0.05
    
@property (nonatomic, strong, nullable) UIColor *topViewBackgroundColor;// alertView分割线上部视图的背景颜色 default whiteColor
    
@property (nonatomic, strong, nullable) UIFont *titleFont;// titleFont 默认为17 加粗
    
@property (nonatomic, strong, nullable) UIFont *messageFont; // messageFont 默认为13 常规
    
@property (nonatomic, strong, nullable) UIColor *titleColor; // 默认 blackColor
    
@property (nonatomic, strong, nullable) UIColor *messageColor; // 默认 blackColor
    
@property (nonatomic, strong, nullable) UIColor *defaultActionTitleColor;// default 按钮字体颜色 默认蓝色

@property (nonatomic, strong, nullable) UIColor *cancelActionTitleColor;// cancel 按钮字体颜色 默认蓝色
    
@property (nonatomic, strong, nullable) UIColor *doneActionTitleColor;// done 按钮字体颜色 默认蓝色
    
@property (nonatomic, strong, nullable) UIFont *defaultActionTitleFont;// default 按钮字体大小 默认为17
 
@property (nonatomic, strong, nullable) UIFont *cancelActionTitleFont;// cancel 按钮字体大小 默认为17
    
@property (nonatomic, strong, nullable) UIFont *doneActionTitleFont;// done 按钮字体大小 默认为17
 
@property (nonatomic, strong, nullable) UIColor *defaultActionBackgroundColor;// default 按钮背景颜色 default whiteColor

@property (nonatomic, strong, nullable) UIColor *cancelActionBackgroundColor;// cancel 按钮背景颜色 default whiteColor
    
@property (nonatomic, strong, nullable) UIColor *doneActionBackgroundColor;// done 按钮背景颜色 default whiteColor
    
- (instancetype _Nonnull )initWithStyle:(CustomAlertLayoutStyle )style;
    
@end

