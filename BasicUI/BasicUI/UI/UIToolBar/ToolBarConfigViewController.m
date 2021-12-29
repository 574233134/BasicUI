//
//  NavigationToolBarConfigViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/17.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "ToolBarConfigViewController.h"

@interface ToolBarConfigViewController ()

@end

@implementation ToolBarConfigViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setToolbarHidden:NO];
    [self initToolBarConfig];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO];
}

- (void)initToolBarConfig
{
    // 设置toolBar颜色
    [self.navigationController.toolbar setBarTintColor:[UIColor redColor]];
    
    // 加号图标
    UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
    // 书籍图标
    UIBarButtonItem *two = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
    
    // 编辑文字图标
    UIBarButtonItem *four = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
    // 播放图标
    UIBarButtonItem *five = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:nil action:nil];
    
    // 可变距离 （该Item 用于调整toolbar中每个Item的间距）
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // 占位空白 （代替一个图标）
    UIBarButtonItem *emptyItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    // 添加可变距离
    [self setToolbarItems:[NSArray arrayWithObjects:flexItem, one, flexItem, two, flexItem, emptyItem, flexItem, four,flexItem,five,flexItem,nil]];
}


- (IBAction)customTabbarItem:(UIButton *)sender
{
    UIBarButtonItem *oneItem = [[UIBarButtonItem alloc]initWithTitle:@"first" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIBarButtonItem *towItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"umbrellaIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setToolbarItems:[NSArray arrayWithObjects:flexItem, oneItem, flexItem, towItem, flexItem,nil]];
}

// toolBar风格
- (IBAction)toolBarStyle:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            [self.navigationController.toolbar setBarStyle:UIBarStyleDefault];
            break;
        case 1:
            [self.navigationController.toolbar setBarStyle:UIBarStyleBlack];
            break;
        case 2:
            [self.navigationController.toolbar setBarStyle:UIBarStyleBlackOpaque];
            break;
        case 3:
            [self.navigationController.toolbar setBarStyle:UIBarStyleBlackTranslucent];
            break;
            
        default:
            break;
    }
}

- (IBAction)itemColor:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
        {
            [self.navigationController.toolbar setTintColor:[UIColor blackColor]];
        }
            break;
        case 1:
        {
            [self.navigationController.toolbar setTintColor:[UIColor redColor]];
        }
            break;
        case 2:
        {
            [self.navigationController.toolbar setTintColor:[UIColor whiteColor]];
        }
            break;
            
            
        default:
            break;
    }
}

- (IBAction)isSetBGPhoto:(UISwitch *)sender
{
    if(sender.on)
    {
        [self.navigationController.toolbar setBackgroundImage:[UIImage imageNamed:@"Header"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else
    {
         [self.navigationController.toolbar setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
}


@end
