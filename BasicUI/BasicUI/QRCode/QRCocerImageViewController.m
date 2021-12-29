//
//  QRCocerImageViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/22.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "QRCocerImageViewController.h"
#import "BasicUIDemo.h"
#import "QRcodeManger.h"
#import "UIImage+SGExtend.h"
#import "UIView+frame.h"
@interface QRCocerImageViewController ()
@property (nonatomic, strong)UIImageView *codeImageView;
@property (nonatomic, strong)UIImageView *codeImageView2;
@end

@implementation QRCocerImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码叠加图";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.codeImageView];
    UIImage *frontImage = [UIImage imageNamed:@"qrIcon3"];
    // 前景图
    UIImage *image = [QRcodeManger generateQRImageWithCode:self.code size:_codeImageView.size.width frontImage:frontImage bgColor:[UIColor whiteColor]];
    self.codeImageView.image = image;
    
    [self.view addSubview:self.codeImageView2];
    UIImage *qrImage2=[QRcodeManger generateQRCode:self.code size:CGSizeMake(SCREEN_WIDTH-160, SCREEN_WIDTH-160) frontColor:[UIColor blackColor] bgColor:[UIColor clearColor] centerIcon:nil];
    
    UIImage *bgImage = [[UIImage imageNamed:@"thumb7"] sg_reSize:CGSizeMake(SCREEN_WIDTH-160, SCREEN_WIDTH-160)];
    UIImage *image2 = [bgImage sg_coverImage:qrImage2 imageFrame:CGRectMake(0, 0, SCREEN_WIDTH-160, SCREEN_WIDTH-160)];
    self.codeImageView2.image = image2;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (UIImageView *)codeImageView
{
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc]init];
        _codeImageView.frame = CGRectMake(80, 80, SCREEN_WIDTH-160, SCREEN_WIDTH-160);
    }
    return _codeImageView;
}

- (UIImageView *)codeImageView2
{
    if (!_codeImageView2) {
        _codeImageView2 = [[UIImageView alloc]init];
        _codeImageView2.frame = CGRectMake(80, SCREEN_HEIGHT-SCREEN_WIDTH+50, SCREEN_WIDTH-160, SCREEN_WIDTH-160);
    }
    return _codeImageView2;
}

@end
