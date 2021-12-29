//
//  ImageViewBasic.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/10.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ImageViewBasic.h"

@interface ImageViewBasic ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageViewBasic

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"imageView基础";
    [self loadImageViewConfig];
}

- (void)loadImageViewConfig
{
    // 设置正常状态下imageView 图片
    UIImage *image = [[UIImage imageNamed:@"miao0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.imageView.image = image;
    
    // 设置高亮状态下imageView 图片
    UIImage *highlightedImage = [[UIImage imageNamed:@"miao1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.imageView.highlightedImage = highlightedImage;
    
    // 是否允许用户交互  默认为NO
    self.imageView.userInteractionEnabled = YES;
    
    // 设置动画组
    NSMutableArray *animationImages = [NSMutableArray array];
    for (int i=0; i<7; i++)
    {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"miao%d",i]];
        [animationImages addObject:img];
    }
    self.imageView.animationImages = animationImages;
    
    // 设置动画时间
    self.imageView.animationDuration = 4;
    
    // 设置动画重复次数  为0 便是无限循环
    self.imageView.animationRepeatCount = 0;
    
    self.imageView.tintColor = [UIColor redColor];
    
}


- (IBAction)startAnimating:(UIButton *)sender
{
    [self.imageView startAnimating];
}

- (IBAction)stopAnimating:(UIButton *)sender
{
    [self.imageView stopAnimating];
}

- (IBAction)isHeightlight:(UISwitch *)sender
{
    self.imageView.highlighted = sender.on;
}


@end
