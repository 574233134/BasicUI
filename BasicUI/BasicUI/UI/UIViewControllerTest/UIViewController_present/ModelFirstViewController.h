//
//  ModelFirstViewController.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/25.
//  Copyright © 2018 李梦珂. All rights reserved.
//


/*
 一：❤️弹出时的动画风格：transtion（跳转）
 typedef NS_ENUM(NSInteger, UIModalTransitionStyle) {
 
 UIModalTransitionStyleCoverVertical = 0, //默认的格式
 UIModalTransitionStyleFlipHorizontal __TVOS_PROHIBITED,
 UIModalTransitionStyleCrossDissolve,
 UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
 
 };
 底部滑入，水平翻转进入，交叉溶解以及翻页这四种，在iPhone上也有效。
 
 二：呈现风格
  常见的四种
 （1）UIModalPresentationFullScreen ：全屏显示（默认）
 
 （2）UIModalPresentationPageSheet　　宽度：竖屏时的宽度（768）  高度：当前屏幕的高度（填充整个高度）
 
 （3）UIModalPresentationFormSheet ：占据屏幕中间的一小块（比较常用）
 
 （4）UIModalPresentationCurrentContext ：跟随父控制器的呈现样式
 
 ❗️❗️呈现方式暂未看到效果
 
 
 三、 属性
 modalPresentationCapturesStatusBarAppearance 这个属性是控制是否显示状态栏  未看到效果❗️❗️
 
 */

#import <UIKit/UIKit.h>

@interface ModelFirstViewController : UIViewController

@end
