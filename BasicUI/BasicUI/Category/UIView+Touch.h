//
//  UIView+Touch.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Touch)

// 是否能够响应touch事件
@property (nonatomic, assign) BOOL unTouch;

// 不响应touch事件的区域
@property (nonatomic, assign) CGRect unTouchRect;

@end
