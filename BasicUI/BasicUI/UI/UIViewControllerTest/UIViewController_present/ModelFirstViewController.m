//
//  ModelFirstViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/25.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ModelFirstViewController.h"
#import "ModelSecendViewController.h"
@interface ModelFirstViewController ()

@property (assign, nonatomic)UIModalTransitionStyle style;

@end

@implementation ModelFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.modalPresentationStyle = UIModalPresentationPageSheet;
    self.modalPresentationCapturesStatusBarAppearance = YES;
}


- (IBAction)present:(UIButton *)sender
{
    ModelSecendViewController *secendVC =[[ModelSecendViewController alloc]init];
    secendVC.modalTransitionStyle = self.style;
    [self presentViewController:secendVC animated:YES completion:nil];
}


- (IBAction)transitionStyle:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.style = UIModalTransitionStyleCoverVertical;
            break;
        case 1:
            self.style = UIModalTransitionStyleFlipHorizontal;
            break;
            
        case 2:
            self.style = UIModalTransitionStyleCrossDissolve;
            break;
            
        case 3:
            self.style = UIModalTransitionStylePartialCurl;
            break;
            
        default:
            break;
    }
}

@end
