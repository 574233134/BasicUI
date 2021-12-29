//
//  ImageViewCustom.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/10.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ImageViewCustom.h"
#import "LMKImageView.h"
@interface ImageViewCustom ()

@property (strong, nonatomic)LMKImageView *imgCircle;

@property (strong, nonatomic)LMKImageView *imgRect;

@property (strong, nonatomic)LMKImageView *imgSixSide;

@end

@implementation ImageViewCustom

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义image形状";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatCustomImageView];
}

- (void)creatCustomImageView
{
    self.imgCircle = [[LMKImageView alloc]initWithFrame:CGRectMake(10, 100, 50, 50)];
    [self.imgCircle setCirclePhotoWithImage:[UIImage imageNamed:@"headPortrait"]];
    [self.view addSubview:self.imgCircle];
    
    self.imgRect = [[LMKImageView alloc]initWithFrame:CGRectMake(70, 100, 50, 50)];
    [self.imgRect setRectPhotoWithImage:[UIImage imageNamed:@"headPortrait"]];
    [self.view addSubview:self.imgRect];
    
    self.imgSixSide = [[LMKImageView alloc]initWithFrame:CGRectMake(130, 100, 50, 50)];
    [self.imgSixSide setSixSidePhotoWithImage:[UIImage imageNamed:@"headPortrait"]];
    [self.view addSubview:self.imgSixSide];
}

@end
