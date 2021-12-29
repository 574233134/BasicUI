//
//  TabbarBaseConfig.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "TabbarBaseConfig.h"
#import "CustomTabBarController.h"
#import "UIColor+hexColor.h"
#import "CustomTabbarItem.h"
#import "UIView+frame.h"
#import "LMKBadgeValue.h"
@implementation TabbarBaseConfig

static id _instance = nil;

+ (instancetype)config
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        [self configNormal];
    });
    return _instance;
}

- (void)configNormal
{
    _norTitleColor = [UIColor colorWithHexString:@"#808080"];
    _selTitleColor = [UIColor colorWithHexString:@"#d81e06"];
    _isClearTabBarTopLine = YES;
    _tabBarTopLineColor = [UIColor lightGrayColor];
    _tabBarBackground = [UIColor whiteColor];
    _imageSize = CGSizeMake(28, 28);
    _badgeTextColor = [UIColor colorWithHexString:@"#FFFFFF"];
    _badgeBackgroundColor = [UIColor colorWithHexString:@"#FF4040"];
}

- (void)setBadgeSize:(CGSize)badgeSize
{
    _badgeSize = badgeSize;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (CustomTabbarItem *btn in arrM)
    {
        btn.badgeValue.badgeL.size = badgeSize;
    }
}

- (void)setBadgeOffset:(CGPoint)badgeOffset
{
    _badgeOffset = badgeOffset;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (CustomTabbarItem *btn in arrM)
    {
        btn.badgeValue.badgeL.x += badgeOffset.x;
        btn.badgeValue.badgeL.y += badgeOffset.y;
    }
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    _badgeTextColor = badgeTextColor;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (CustomTabbarItem *btn in arrM)
    {
        btn.badgeValue.badgeL.textColor = badgeTextColor;
    }
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor
{
    _badgeBackgroundColor = badgeBackgroundColor;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (CustomTabbarItem *btn in arrM)
    {
        btn.badgeValue.badgeL.backgroundColor = badgeBackgroundColor;
    }
}

- (void)setBadgeRadius:(CGFloat)badgeRadius
{
    _badgeRadius = badgeRadius;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (CustomTabbarItem *btn in arrM)
    {
        btn.badgeValue.badgeL.layer.cornerRadius = badgeRadius;
    }
}

- (void)badgeRadius:(CGFloat)radius AtIndex:(NSInteger)index
{
    CustomTabbarItem *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.badgeL.layer.cornerRadius = radius;
}


- (void)showPointBadgeAtIndex:(NSInteger)index
{
    CustomTabbarItem *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.type = LMKBadgeValueTypePoint;
}

- (void)showNewBadgeAtIndex:(NSInteger)index
{
    CustomTabbarItem *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.badgeL.text = @"new";
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.type = LMKBadgeValueTypeNew;
}

- (void)showNumberBadgeValue:(NSString *)badgeValue AtIndex:(NSInteger)index
{
    CustomTabbarItem *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.badgeL.text = badgeValue;
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.type = LMKBadgeValueTypeNumber;
}

- (void)hideBadgeAtIndex:(NSInteger)index
{
    LMKBadgeValue *badgeValue = [self getTabBarButtonAtIndex:index].badgeValue;
    if (badgeValue.type != LMKBadgeValueTypeNew) {
        badgeValue.hidden = YES;
    }
}

- (void)addCustomBtn:(UIButton *)btn AtIndex:(NSInteger)index BtnClickBlock:(BaseConfigCustomBtnBlock)btnClickBlock
{
    btn.tag = index;
    [btn addTarget:self action:@selector(customBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.btnClickBlock = btnClickBlock;
    [self.tabBarController.customTabBar addSubview:btn];
}

- (void)customBtnClick:(UIButton *)sender
{
    if (self.btnClickBlock)
    {
        self.btnClickBlock(sender, sender.tag);
    }
}

- (CustomTabbarItem *)getTabBarButtonAtIndex:(NSInteger)index
{
    NSArray *subViews = self.tabBarController.customTabBar.subviews;
    int j=0;
    for (int i = 0; i < subViews.count && j <subViews.count; i++)
    {
        UIView *tabBarButton = subViews[i];
        if ([tabBarButton isKindOfClass:[CustomTabbarItem class]]) {
            if (j == index) {
                CustomTabbarItem *tabBarBtn = (CustomTabbarItem *)tabBarButton;
                return tabBarBtn;
            }
            j++;
        }
        
    }
    return nil;
}

- (NSMutableArray *)getTabBarButtons
{
    NSArray *subViews = self.tabBarController.customTabBar.subviews;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < subViews.count; i++)
    {
        UIView *tabBarButton = subViews[i];
        if ([tabBarButton isKindOfClass:[CustomTabbarItem class]])
        {
            CustomTabbarItem *tabBarBtn = (CustomTabbarItem *)tabBarButton;
            [tempArr addObject:tabBarBtn];
        }
    }
    return tempArr;
}

- (void)setNorTitleColor:(UIColor *)norTitleColor
{
    _norTitleColor = norTitleColor;
    for (int i=0; i<self.tabBarController.viewControllers.count; i++) {
        CustomTabbarItem *item = [self getTabBarButtonAtIndex:i];
        if (i!=self.tabBarController.selectedIndex) {
            item.title.textColor = norTitleColor;
        }
    }
    
}

- (void)setSelTitleColor:(UIColor *)selTitleColor
{
    _selTitleColor = selTitleColor;
    for (int i=0; i<self.tabBarController.viewControllers.count; i++) {
        CustomTabbarItem *item = [self getTabBarButtonAtIndex:i];
        if (i==self.tabBarController.selectedIndex) {
            item.title.textColor = selTitleColor;
        }
    }
}


@end
