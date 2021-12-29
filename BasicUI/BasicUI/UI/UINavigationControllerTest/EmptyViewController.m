//
//  EmptyViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/17.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "EmptyViewController.h"

@interface EmptyViewController ()

@end

@implementation EmptyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.navigationController.viewControllers.count>1)
    {
        [self customBackButton];
    }
    else
    {
        self.title = @"点击返回";
    }
    
}

- (IBAction)pushNextVC:(UIButton *)sender
{
    EmptyViewController *vc =[EmptyViewController new];
    vc.title = [NSString stringWithFormat:@"第%u个界面",self.navigationController.viewControllers.count];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)customBackButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popToRoot)];
    self.navigationItem.leftBarButtonItem = item;

}

- (IBAction)popVc:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.navigationController.viewControllers.count == 1)
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)popToRoot
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
