//
//  CustomTabBar.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarBaseConfig.h"
NS_ASSUME_NONNULL_BEGIN
@class CustomTabBar;
@protocol CustomTabBarDelegate <NSObject>

- (void)tabBar:(CustomTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex;

@end

@interface CustomTabBar : UITabBar

@property(strong, nonatomic) UIImageView *backGroundView;

@property(weak, nonatomic)id <CustomTabBarDelegate> myDelegate;
@property(assign, nonatomic) NSInteger selectedIndex; // 选中的位置（默认为0）

- (instancetype)initWithFrame: (CGRect)frame norImageArr: (NSArray *)norImageArr SelImageArr: (NSArray *)selImageArr TitleArr: (NSArray *)titleArr Config: (TabbarBaseConfig * )config;

- (void)updateNorImageArr:(NSArray *)norImageArr;

- (void)updateSelImageArr:(NSArray *)selImageArr;

- (void)updateTitle:(NSString *)title AtIndex:(NSInteger)index;

- (void)updateSelImage:(NSString *)image AtIndex:(NSInteger)index;

- (void)updateNorImage:(NSString *)image AtIndex:(NSInteger)index;

- (void)setTabbrHidden:(BOOL)isHidden animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
