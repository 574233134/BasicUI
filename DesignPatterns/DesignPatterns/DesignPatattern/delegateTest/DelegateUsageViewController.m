//
//  DelegateUsageViewController.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/15.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "DelegateUsageViewController.h"

@interface DelegateUsageViewController ()

@property (strong, nonatomic) IBOutlet UISegmentedControl *titleText;

@end

@implementation DelegateUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.delegate respondsToSelector:@selector(didSelectTitle:)])
    {
        [self.delegate didSelectTitle:[NSString stringWithFormat:@"title%lu",self.titleText.selectedSegmentIndex+1]];
    }
}

@end
