//
//  UIImageDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/1/2.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "UIImageDemo.h"
#import <Masonry.h>
@interface UIImageDemo ()

@property (strong, nonatomic) UIImageView *imageView1;

@property (strong, nonatomic) UIImageView *imageView2;

@property (strong, nonatomic) UIImageView *imageView3;

@property (strong, nonatomic) UIImageView *imageView4;

@end

@implementation UIImageDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatImageView];
}

- (void)creatImageView
{
    self.imageView1 = [[UIImageView alloc]init];
    [self.view addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc]init];
    [self.view addSubview:self.imageView2];
    
    self.imageView3 = [[UIImageView alloc]init];
    [self.view addSubview:self.imageView3];
    
    self.imageView4 = [[UIImageView alloc]init];
    [self.view addSubview:self.imageView4];
    
    [self layoutImageView];
    [self imageViewSetImage];
}

- (void)layoutImageView
{
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView1.mas_centerX);
        make.top.equalTo(self.imageView1.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView1.mas_centerX);
        make.top.equalTo(self.imageView2.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.imageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView1.mas_centerX);
        make.top.equalTo(self.imageView3.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
}

- (void)imageViewSetImage
{
    UIImage *image1 = [UIImage imageNamed:@"thumb6"];
    self.imageView1.image = image1;
    
    UIImage *image2 = [UIImage imageWithContentsOfFile:@"/Users/limengke1/Desktop/icon2.png"];
    self.imageView2.image = image2;
    
    
    NSString *path = @"/Users/limengke1/Desktop/icon2.png";
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image3 = [UIImage imageWithData:data];
    self.imageView3.image = image3;
    
    UIImage *animateImage1 = [UIImage imageNamed:@"thumb1"];
    UIImage *animateImage2 = [UIImage imageNamed:@"thumb2"];
    UIImage *animateImage3 = [UIImage imageNamed:@"thumb3"];
    UIImage *image4 = [UIImage animatedImageWithImages:@[animateImage1,animateImage2,animateImage3] duration:2];
    self.imageView4.image = image4;
    
    
    
}

@end
