//
//  CustomTabBar.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomTabBar.h"
#import "CustomTabbarItem.h"
#import "UIView+frame.h"
#import "TabbarBaseConfig.h"
#import "CustomTabBarController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BasicUIDemo.h"
@interface CustomTabBar ()

/** 存放 CustomTabbarItem 数组 */
@property (nonatomic, strong) NSMutableArray *saveTabBarBtnArr;
/** 正常状态下image数组 */
@property (nonatomic, strong) NSMutableArray *norImageArr;
/** 选中状态下image数组 */
@property (nonatomic, strong) NSMutableArray *selImageArr;
/** 标题数组 */
@property (nonatomic, strong) NSMutableArray *titleArr;

@end

@implementation CustomTabBar

- (instancetype)initWithFrame:(CGRect)frame norImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(TabbarBaseConfig *)config
{
    self = [super initWithFrame:frame];
    if (self)
    {
        for (int i = 0; i < titleArr.count; i++)
        {
            CustomTabbarItem *tbBtn = [[CustomTabbarItem alloc] init];
            tbBtn.imageView.image = [UIImage imageNamed:norImageArr[i]];
            tbBtn.title.text = titleArr[i];
            tbBtn.title.textColor = [[TabbarBaseConfig config] norTitleColor];
            tbBtn.typeLayout = config.typeLayout;
            tbBtn.tag = i;
            [self addSubview:tbBtn];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [tbBtn addGestureRecognizer:tap];
            
            [self.saveTabBarBtnArr addObject:tbBtn];
        }
        
        self.titleArr = [NSMutableArray arrayWithArray:titleArr];
        self.norImageArr = [NSMutableArray arrayWithArray:norImageArr];
        self.selImageArr = [NSMutableArray arrayWithArray:selImageArr];
        //背景颜色处理
        self.backgroundColor = [[TabbarBaseConfig config] tabBarBackground];
        
        //顶部线条处理
        if (config.isClearTabBarTopLine)
        {
            [self topLineIsClearColor:YES];
        }
        else
        {
            [self topLineIsClearColor:NO];
        }
    }
    return self;
}

#pragma mark - 数组懒加载
- (NSMutableArray *)norImageArr
{
    if (!_norImageArr)
    {
        _norImageArr = [NSMutableArray array];
    }
    return _norImageArr;
}

- (NSMutableArray *)selImageArr
{
    if (!_selImageArr)
    {
        _selImageArr = [NSMutableArray array];
    }
    return _selImageArr;
}

- (NSMutableArray *)titleArr
{
    if (!_titleArr)
    {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (NSMutableArray *)saveTabBarBtnArr
{
    if (!_saveTabBarBtnArr)
    {
        _saveTabBarBtnArr = [NSMutableArray array];
    }
    return _saveTabBarBtnArr;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (UIView *tabBarButton in self.subviews)
    {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            [tabBarButton removeFromSuperview];
        }
        if ([tabBarButton isKindOfClass:[CustomTabbarItem class]] || [tabBarButton isKindOfClass:[UIButton class]]) {
            [tempArr addObject:tabBarButton];
        }
    }
    
    //进行排序
    for (int i = 0; i < tempArr.count; i++)
    {
        UIView *view = tempArr[i];
        if ([view isKindOfClass:[UIButton class]])
        {
            [tempArr insertObject:view atIndex:view.tag];
            [tempArr removeLastObject];
            break;
        }
    }
    
    CGFloat viewW = self.width / tempArr.count;
    CGFloat viewH = 49;
    CGFloat viewY = 0;
    for (int i = 0; i < tempArr.count; i++)
    {
        CGFloat viewX = i * viewW;
        UIView *view = tempArr[i];
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    [self setUpSelectedIndex:tag];
    [self setSelectedIndex:tag];
    [TabbarBaseConfig config].tabBarController.selectedIndex = tag;
    if ([self.myDelegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [self.myDelegate tabBar:self didSelectIndex:tag];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    [self setUpSelectedIndex:selectedIndex];
}

#pragma mark - 设置选中的index进行操作
- (void)setUpSelectedIndex:(NSInteger)selectedIndex
{
    for (int i = 0; i < self.saveTabBarBtnArr.count; i++)
    {
        CustomTabbarItem *tbBtn = self.saveTabBarBtnArr[i];
        if (i == selectedIndex)
        {
            tbBtn.title.textColor = [[TabbarBaseConfig config] selTitleColor];
            if ([self isURLImage:self.selImageArr[i]])
            {
                [tbBtn.imageView sd_setImageWithURL:[NSURL URLWithString:self.selImageArr[i]]];
            }
            else
            {
                tbBtn.imageView.image = [UIImage imageNamed:self.selImageArr[i]];
            }
        }
        else
        {
            tbBtn.title.textColor = [[TabbarBaseConfig config] norTitleColor];
            if ([self isURLImage:self.norImageArr[i]])
            {
                [tbBtn.imageView sd_setImageWithURL:[NSURL URLWithString:self.norImageArr[i]]];
            }
            else
            {
                tbBtn.imageView.image = [UIImage imageNamed:self.norImageArr[i]];
            }
            [tbBtn.imageView.layer removeAllAnimations];
        }
    }
}

- (void)updateNorImageArr:(NSArray *)norImageArr
{
    if (norImageArr.count == self.norImageArr.count) {
        self.norImageArr = [NSMutableArray arrayWithArray:norImageArr];
    }
    [self setUpSelectedIndex:self.selectedIndex];
}

- (void)updateSelImageArr:(NSArray *)selImageArr
{
    if (selImageArr.count == self.selImageArr.count) {
        self.selImageArr = [NSMutableArray arrayWithArray:selImageArr];
    }
    [self setUpSelectedIndex:self.selectedIndex];
}


- (void)updateTitle:(NSString *)title AtIndex:(NSInteger)index
{
    CustomTabbarItem *item = self.saveTabBarBtnArr[index];
    item.title.text = title;
    [self.titleArr setObject:title atIndexedSubscript:index];
}

- (void)updateSelImage:(NSString *)image AtIndex:(NSInteger)index
{
    [self.selImageArr setObject:image atIndexedSubscript:index];
    CustomTabbarItem *tbBtn = self.saveTabBarBtnArr[index];
    if (self.selectedIndex == index) {
        if ([self isURLImage:self.selImageArr[index]])
        {
            [tbBtn.imageView sd_setImageWithURL:[NSURL URLWithString:self.selImageArr[index]]];
        }
        else
        {
            tbBtn.imageView.image = [UIImage imageNamed:self.selImageArr[index]];
        }
    }
}

- (void)updateNorImage:(NSString *)image AtIndex:(NSInteger)index
{
    [self.norImageArr setObject:image atIndexedSubscript:index];
    CustomTabbarItem *tbBtn = self.saveTabBarBtnArr[index];
    if (self.selectedIndex != index) {
        if ([self isURLImage:self.norImageArr[index]])
        {
            [tbBtn.imageView sd_setImageWithURL:[NSURL URLWithString:self.norImageArr[index]]];
        }
        else
        {
            tbBtn.imageView.image = [UIImage imageNamed:self.norImageArr[index]];
        }
    }
}

- (BOOL)isURLImage:(NSString *)imageURL
{
    if ([[imageURL lowercaseString] hasPrefix:@"http"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - 顶部线条处理(清除颜色)
- (void)topLineIsClearColor:(BOOL)isClearColor
{
    UIColor *color = [UIColor clearColor];
    if (!isClearColor)
    {
        color = [[TabbarBaseConfig config] tabBarTopLineColor];
    }
    CGRect rect = CGRectMake(0, 0, self.width, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:img];
}

- (void)setTabbrHidden:(BOOL)isHidden animated:(BOOL)animated
{
    if (animated) {
        if (isHidden == NO) {
            self.hidden = NO;
        }
        [UIView animateWithDuration:0.3 animations:^{
            CGFloat H = [TabbarBaseConfig config].tabBarController.view.frame.size.height;
            if (isHidden) {
                self.frame = CGRectMake(self.frame.origin.x, H, self.frame.size.width, self.frame.size.height);
            }
            else
            {
                self.frame = CGRectMake(self.frame.origin.x, H - TARBARHEIGHT, self.frame.size.width, self.frame.size.height);
            }
        } completion:^(BOOL finished) {
            if (isHidden == YES) {
                self.hidden = YES;
            }
        }];
    }
    else
    {
        CGFloat H = [TabbarBaseConfig config].tabBarController.view.frame.size.height;
        if (isHidden) {
            self.frame = CGRectMake(self.frame.origin.x, H, self.frame.size.width, self.frame.size.height);
        }
        else
        {
            self.frame = CGRectMake(self.frame.origin.x, H - TARBARHEIGHT, self.frame.size.width, self.frame.size.height);
        }
        self.hidden = isHidden;
    }
}
@end
