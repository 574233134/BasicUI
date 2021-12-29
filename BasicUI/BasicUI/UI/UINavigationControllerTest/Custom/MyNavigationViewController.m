//
//  MyNavigationViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/17.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "MyNavigationViewController.h"

@interface MyNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation MyNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        [self loadConfig];
    }
    return self;
}

- (void)loadConfig
{
    //--------------------------------- UINavigationControllr属性设置 -----------------------------------
    // 设置navigationBar是否为透明
    self.navigationBar.translucent = NO;
    
    // 设置toolBar是否为透明
    self.toolbar.translucent = NO;
    
    // 如果存在模态视图，返回模态视图控制器。否则，返回顶部视图控制器。
//    UIViewController *vc = self.visibleViewController;
    
    // 设置导航栏是否显示
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // 设置navigation的toolbar显示出来     错误使用：[self.toolbar setHidden:NO];该方法不会让toolbar显示出来
    [self setToolbarHidden:NO animated:YES];

    // 是否响应上滑手势（滑动可以隐藏或显示bar）
    self.hidesBarsOnSwipe = YES;
    
    
    [self navigationBarConfig];
    [self toolBarConfig];
    
}

- (void)navigationBarConfig
{
    //--------------------------------- Navigationbar 属性设置  ---------------------------------------
    // 设置navigationbar的颜色和风格
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1]];
    [self.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    // 设置navigationbar标题的字体属性
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 设置navigaionbaritem的颜色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
}

//--------------------------------- Toolbar 属性设置  ---------------------------------------
- (void)toolBarConfig
{
    // 设置toolbar的颜色
    [[UIToolbar appearance] setBarTintColor:[UIColor blueColor]]; // 方式1
    [self.toolbar setBarTintColor:[UIColor redColor]];// 方式2
    
    // 设置toolbar的风格
    [[UIToolbar appearance] setBarStyle:UIBarStyleBlackOpaque];
    
    // 设置toolbar上面item的颜色
    [self.toolbar setTintColor:[UIColor whiteColor]];
    
}

#pragma mark - UINavigationController Delegate

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 0)
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1)
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

// UIGestureRecognizer Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

@end
