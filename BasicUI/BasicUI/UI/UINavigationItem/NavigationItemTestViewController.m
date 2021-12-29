//
//  NavigationItemTestViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/12.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "NavigationItemTestViewController.h"

@interface NavigationItemTestViewController ()

@property (strong, nonatomic)  UINavigationItem *testnavigationItem;

@end

@implementation NavigationItemTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"navigationItem练习";
    _testnavigationItem = self.navigationItem;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"push" style:UIBarButtonItemStylePlain target:self action:@selector(pushToNext)];
    _testnavigationItem.rightBarButtonItem = item;
}

- (void)pushToNext
{
    NavigationItemTestViewController *testVC = [[NavigationItemTestViewController alloc]init];
    [self.navigationController pushViewController:testVC animated:YES];
}

/**
 * 1. title 用来设置当前控制器的标题
 */
- (IBAction)setItemTitle:(UIButton *)sender
{
    _testnavigationItem.title = @"navigationItem";
}

/**
 * 2. titleView 标题View
 */
- (IBAction)setTitleView:(UIButton *)sender
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Header"]];
    _testnavigationItem.titleView = imageView;
}

/**
 * 2. prompt 设置导航栏上方说明文字
 */
- (IBAction)setPrompt:(UIButton *)sender
{
    _testnavigationItem.prompt = @"我是说明文字";
}

/**
 * 3. backBarButtonItem 设置导航栏返回按钮（下一个界面的返回按钮）
 */
- (IBAction)setBackBtn:(UIButton *)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(backToPre)];
    _testnavigationItem.backBarButtonItem = backItem;
}

- (void)backToPre
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 4. hidesBackButton 是否隐藏返回按钮（包括返回按钮及title）
 */
- (IBAction)isHiddenBackBtn:(UISwitch *)sender
{
    _testnavigationItem.hidesBackButton = sender.on;
}

/**
 * 5. leftBarButtonItem 设置navigationItem最左侧按钮
 */
- (IBAction)setLeftBtnItem:(UIButton *)sender
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"左侧按钮" style:UIBarButtonItemStyleDone target:self action:@selector(backToPre)];
    _testnavigationItem.leftBarButtonItem = leftItem;
}

/**
 * 6. leftBarButtonItem 设置导航栏左侧items数组
 */
- (IBAction)setLeftBtnItems:(UIButton *)sender
{
    UIBarButtonItem *leftItem1 = [[UIBarButtonItem alloc]initWithTitle:@"leftBtn1" style:UIBarButtonItemStyleDone target:self action:@selector(backToPre)];
    UIBarButtonItem *leftItem2 = [[UIBarButtonItem alloc]initWithTitle:@"leftBtn2" style:UIBarButtonItemStyleDone target:self action:@selector(backToPre)];
    _testnavigationItem.leftBarButtonItems  = [NSArray arrayWithObjects:leftItem1,leftItem2 ,nil];
}

/**
 * 7. rightBarButtonItem 设置navigationItem最右侧按钮
 */
- (IBAction)setRightBtnItem:(UIButton *)sender
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"push" style:UIBarButtonItemStylePlain target:self action:@selector(pushToNext)];
    _testnavigationItem.rightBarButtonItem = item;
}

/**
 * 8. rightBarButtonItems 设置导航栏右侧items数组
 */
- (IBAction)setBackBtnItems:(UIButton *)sender
{
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"push1" style:UIBarButtonItemStylePlain target:self action:@selector(pushToNext)];
     UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"push2" style:UIBarButtonItemStylePlain target:self action:@selector(pushToNext)];
    _testnavigationItem.rightBarButtonItems = @[item1,item2];
}

/**
 * 9. largeTitleDisplayMode 类型为UINavigationItemLargeTitleDisplayMode API_AVAILABLE(ios(11.0))
 *    该属性只有在导航栏展示大标题时才起作用，默认模式为Automatic
 *
 * 10. searchController 类型UISearchController API_AVAILABLE(ios(11.0))
 *    当导航栏中包含搜索控制器的searchBar        时，可以通过该属性拿到搜索控制器
 *
 * 11. hidesSearchBarWhenScrolling 在滑动时是否隐藏搜索框 API_AVAILABLE(ios(11.0)) 默认为yes
 */

@end
