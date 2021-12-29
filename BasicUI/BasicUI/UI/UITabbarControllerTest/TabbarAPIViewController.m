//
//  TabbarAPIViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/21.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "TabbarAPIViewController.h"

@interface TabbarAPIViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation TabbarAPIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Tabbar API";
    [self loadData];
    [self creatTableView];
    
}

- (void)loadData
{
    self.dataArray = [NSArray arrayWithObjects:
                      @"设置tinColor为黄色",
                      @"设置barTincColor为棕色",
                      @"设置未选中项的tinColor为灰色(ios10.0以后)",
                      @"设置Tabbar背景图片",
                      @"设置selectionIndicatorImage",
                      @"设置shadowImage",
                      @"设置itemPositioning(Automatic)",
                      @"设置itemWidth(40)",
                      @"设置itemSpacing(40)",
                      @"设置BarStyle(UIBarStyleBlackOpaque)",
                      @"设置translucent为NO",
                      nil];
    
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0: // 设置tinColor 为黄色，默认tabbars上面u选中Item的图片及文字是蓝色，此属性可将图片和文字颜色变为黄色
        {
            self.tabBarController.tabBar.tintColor = [UIColor yellowColor];
        }
            break;
        case 1: // 更改tabbar的背景色
        {
            self.tabBarController.tabBar.barTintColor = [UIColor brownColor];
        }
            break;
        case 2: // 设置未选中Item图片及文字的颜色
        {
            if (@available(iOS 10.0, *)) {
                self.tabBarController.tabBar.unselectedItemTintColor = [UIColor grayColor];
            } else {
                // Fallback on earlier versions
            }
        }
            break;
        case 3: // 设置tabbar背景图片
        {
            self.tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"Header"];
        }
            break;
        case 4: // 设置选中Item 的背景悬浮image
        {
            self.tabBarController.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"btn_image_normal"];
        }
            break;
            
        case 5: // 设置shadowImage
        {
            self.tabBarController.tabBar.shadowImage = [UIImage imageNamed:@"btn_image_heightlighted"];
        }
            break;
        case 6: // 设置itemPositioning
        {
            /**
             * UITabBarItemPositioning
             * 1. UITabBarItemPositioningAutomatic,
             * 2. UITabBarItemPositioningFill,
             * 3. UITabBarItemPositioningCentered,
             */
            
            self.tabBarController.tabBar.itemPositioning = UITabBarItemPositioningAutomatic;
        }
            break;
        case 7: // 设置itemWidth
        {
            self.tabBarController.tabBar.itemWidth = 60;
    
        }
            break;
        case 8: // 设置itemSpacing
        {
            self.tabBarController.tabBar.itemSpacing = 40;
        }
            break;
        case 9: // 设置BarStyle,默认为UIBarStyleDefault
        {
            self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
        }
            break;
        case 10: // 设置translucent为NO
        {
            self.tabBarController.tabBar.translucent = NO;
        }
            break;
        default:
            break;
    }
}
@end
