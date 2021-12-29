//
//  CustomTabBarController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomTabBarController.h"

@interface CustomTabBarController ()<CustomTabBarDelegate>

@end

@implementation CustomTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (instancetype)initWithTabBarControllers:(NSArray *)controllers NorImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(TabbarBaseConfig *)config
{
    self.viewControllers = controllers;
    self.customTabBar = [[CustomTabBar alloc] initWithFrame:self.tabBar.frame norImageArr:norImageArr SelImageArr:selImageArr TitleArr:titleArr Config:config];
    [self setValue:self.customTabBar forKeyPath:@"tabBar"];
    [TabbarBaseConfig config].tabBarController = self;
    self.customTabBar.selectedIndex = 0;
    //KVO
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSInteger selectedIndex = [change[@"new"] integerValue];
    self.customTabBar.selectedIndex = selectedIndex;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"selectedIndex"];
}

@end
