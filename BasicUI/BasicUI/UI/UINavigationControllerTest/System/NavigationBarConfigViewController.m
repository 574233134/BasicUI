//
//  NavigationBarConfigViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/17.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "NavigationBarConfigViewController.h"

@interface NavigationBarConfigViewController ()

@end

@implementation NavigationBarConfigViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initConfig
{
    // navigationBar风格
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    
    // navigationBar背景色
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    // 标题的字体属性
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    // 设置navigaionbaritem的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
}

// 是否展示大标题
- (IBAction)showLageTitle:(UISwitch *)sender
{
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = sender.on;
    } else {
        // Fallback on earlier versions
    }
}

// 是否设置背景图
- (IBAction)isSetBGPhoto:(UISwitch *)sender
{
    if (sender.on)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Header"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }
}

// navigationBar风格
- (IBAction)navigationBarStyle:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
            break;
        case 1:
            [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
            break;
        case 2:
            [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
            break;
        case 3:
            [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
            break;
            
        default:
            break;
    }
}

// 标题颜色
- (IBAction)titleColor:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
        {
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        }
            break;
        case 1:
        {
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        }
            break;
        case 2:
        {
           [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        }
            break;

            
        default:
            break;
    }
}

// item 颜色
- (IBAction)itemColor:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
        {
            [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
        }
            break;
        case 1:
        {
            [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
        }
            break;
        case 2:
        {
            [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        }
            break;
            
            
        default:
            break;
    }
}

// navigationBar背景色
- (IBAction)barColor:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
        {
            [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
        }
            break;
        case 1:
        {
            [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
        }
            break;
        case 2:
        {
             [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
        }
            break;
        case 3:
        {
             [self.navigationController.navigationBar setBarTintColor:[UIColor purpleColor]];

        }
            break;
            
        default:
            break;
    }
}


@end
