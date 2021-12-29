//
//  HomeViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/19.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "HomeViewController.h"
#import "TabbarAPIViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
//    self.tabBarController.tabBarItem
    self.view.backgroundColor = [UIColor redColor];
}

- (IBAction)dismissTabbarVC:(UIButton *)sender
{
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)TabbarPropertyAndDelegate:(UIButton *)sender
{
    TabbarAPIViewController *tabbarAPIVC = [[TabbarAPIViewController alloc]init];
    [self.navigationController pushViewController:tabbarAPIVC animated:YES];
}

@end
