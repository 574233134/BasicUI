//
//  NewViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/1.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义返回按钮";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    [self creatBackButton];
    
}

// 创建返回按钮
- (void)creatBackButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backToPreVC)];
    self.navigationItem.leftBarButtonItem = item;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"push" style:UIBarButtonItemStyleDone target:self action:@selector(pushToNewVC)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)backToPreVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushToNewVC
{
    NewViewController *vc = [[NewViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
