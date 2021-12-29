//
//  DelegatePatternDemo.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/15.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "DelegatePatternDemo.h"
#import "DelegateUsageViewController.h"
@interface DelegatePatternDemo ()<DelegateUsageViewControllerDelegate>

@property (strong, nonatomic)DelegateUsageViewController *usageVC;

@property (strong, nonatomic) IBOutlet UILabel *titleDisplay;


@end

@implementation DelegatePatternDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"代理模式";
    self.usageVC = [[DelegateUsageViewController alloc]init];
    self.usageVC.delegate = self;
}

- (void)didSelectTitle:(NSString *)title
{
    self.titleDisplay.text = title;
}

- (IBAction)intoDelegateVC:(UIButton *)sender
{
    [self.navigationController pushViewController:self.usageVC animated:YES];
}





@end
