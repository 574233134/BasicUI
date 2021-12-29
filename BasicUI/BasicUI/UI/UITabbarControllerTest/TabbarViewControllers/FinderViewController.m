//
//  FinderViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/19.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "FinderViewController.h"

@interface FinderViewController ()

@end

@implementation FinderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发现";
    self.view.backgroundColor = [UIColor cyanColor];

}

- (IBAction)disMissTabbar:(UIButton *)sender
{
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
}


@end
