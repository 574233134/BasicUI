//
//  CustomTabBarController.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomTabBarController : UITabBarController

- (instancetype)initWithTabBarControllers:(NSArray *)controllers NorImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config: (TabbarBaseConfig *)config;

/** tabBar */
@property (nonatomic, strong) CustomTabBar *customTabBar;

@end

NS_ASSUME_NONNULL_END
