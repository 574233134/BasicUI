//
//  LmkInteractiveTransitioning.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^GestureConifg)(void);

typedef NS_ENUM(NSUInteger, LMKInteractiveTransitionGestureDirection)
{
    //手势的方向
    LMKInteractiveTransitionGestureDirectionLeft = 0,
    LMKInteractiveTransitionGestureDirectionRight,
    LMKInteractiveTransitionGestureDirectionUp,
    LMKInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, LMKInteractiveTransitionType)
{
    //手势控制哪种转场
    LMKInteractiveTransitionTypePresent = 0,
    LMKInteractiveTransitionTypeDismiss,
    LMKInteractiveTransitionTypePush,
    LMKInteractiveTransitionTypePop,
};

@interface LmkInteractiveTransitioning : UIPercentDrivenInteractiveTransition

/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign) BOOL interation;
/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg presentConifg;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg pushConifg;

//初始化方法
+ (instancetype)interactiveTransitionWithTransitionType:(LMKInteractiveTransitionType)type GestureDirection:(LMKInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(LMKInteractiveTransitionType)type GestureDirection:(LMKInteractiveTransitionGestureDirection)direction;

/** 给传入的控制器添加手势*/
- (void)addPanGestureForViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
