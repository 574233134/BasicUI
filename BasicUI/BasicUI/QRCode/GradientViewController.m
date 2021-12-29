//
//  GradientViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/22.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "GradientViewController.h"
#import "ColorfulQRCodeOCVerView.h"
#import "QRcodeManger.h"
#import "BasicUIDemo.h"
@interface GradientViewController ()

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"渐变色";
    self.view.backgroundColor = [UIColor whiteColor];
    ColorfulQRCodeOCVerView *view = [[ColorfulQRCodeOCVerView alloc]initWithFrame:CGRectMake(80, 80, SCREEN_WIDTH-160, SCREEN_WIDTH-160)];
    [view syncFrame];
    [view setQRCodeImage:self.qrImage];
    [self.view addSubview:view];

}

@end
