//
//  CustomButtonDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomButtonDemo.h"
#import "CustomButton.h"
#import "CustomButtonOverrideSysMethods.h"
@interface CustomButtonDemo ()

@property (strong, nonatomic) CustomButton *customButton1; // imageleft

@property (strong, nonatomic) CustomButton *customButton2; // imageRight;

@property (strong, nonatomic) CustomButton *customButton3; // imageTop;

@property (strong, nonatomic) CustomButton *customButton4; // imageBottom

@property (strong, nonatomic) CustomButtonOverrideSysMethods *customButton5;//重写系统提供的四个方法

@end

@implementation CustomButtonDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.customButton1];
    [self.view addSubview:self.customButton2];
    [self.view addSubview:self.customButton3];
    [self.view addSubview:self.customButton4];
    [self.view addSubview:self.customButton5];
}

- (CustomButton *)customButton1
{
    if (_customButton1 == nil)
    {
        _customButton1 = [CustomButton buttonWithType:UIButtonTypeSystem];
        _customButton1.backgroundColor = [UIColor cyanColor];
        _customButton1.frame=CGRectMake(100, 100, 100, 40);
        _customButton1.titleImageSpacing = 10;
        _customButton1.imagePosition = CustomButtonImagePositionLeft;
        [_customButton1 setImage:[UIImage imageNamed:@"umbrellaIcon"] forState:UIControlStateNormal];
        [_customButton1 setTitle:@"测试" forState:UIControlStateNormal];
        _customButton1.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _customButton1;
}

- (CustomButton *)customButton2
{
    if (_customButton2 == nil)
    {
        _customButton2 = [CustomButton buttonWithType:UIButtonTypeCustom];
        _customButton2.backgroundColor = [UIColor cyanColor];
        _customButton2.frame = CGRectMake(100, 160, 100, 40);
        _customButton2.titleImageSpacing = 10;
        _customButton2.imagePosition = CustomButtonImagePositionRight;
        [_customButton2 setImage:[UIImage imageNamed:@"umbrellaIcon"] forState:UIControlStateNormal];
        [_customButton2 setTitle:@"测试" forState:UIControlStateNormal];
        _customButton2.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _customButton2;
}

- (CustomButton *)customButton3
{
    if (_customButton3 == nil)
    {
        _customButton3 = [CustomButton buttonWithType:UIButtonTypeCustom];
        _customButton3.backgroundColor = [UIColor cyanColor];
        _customButton3.frame = CGRectMake(100, 220, 40, 80);
        _customButton3.titleImageSpacing = 10;
        _customButton3.imagePosition = CustomButtonImagePositionTop;
        [_customButton3 setImage:[UIImage imageNamed:@"umbrellaIcon"] forState:UIControlStateNormal];
        [_customButton3 setTitle:@"测试" forState:UIControlStateNormal];
        _customButton3.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _customButton3;
}

- (CustomButton *)customButton4
{
    if (_customButton4 == nil)
    {
        _customButton4 = [CustomButton buttonWithType:UIButtonTypeCustom];
        _customButton4.backgroundColor = [UIColor cyanColor];
        _customButton4.frame = CGRectMake(100, 320, 40, 80);
        _customButton4.titleImageSpacing = 10;
        _customButton4.imagePosition = CustomButtonImagePositionBottom;
        [_customButton4 setImage:[UIImage imageNamed:@"umbrellaIcon"] forState:UIControlStateNormal];
        [_customButton4 setTitle:@"测试" forState:UIControlStateNormal];
        _customButton4.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _customButton4;
}

- (CustomButtonOverrideSysMethods *)customButton5
{
    if (_customButton5 == nil)
    {
        _customButton5 = [CustomButtonOverrideSysMethods buttonWithType:UIButtonTypeCustom];
        [_customButton5 setBackgroundImage:[UIImage imageNamed:@"btn_normal.jpg"] forState:UIControlStateNormal];
        _customButton5.backgroundColor = [UIColor cyanColor];
        _customButton5.frame = CGRectMake(100, 420, 100, 40);
        [_customButton5 setImage:[UIImage imageNamed:@"umbrellaIcon"] forState:UIControlStateNormal];
        [_customButton5 setTitle:@"测试" forState:UIControlStateNormal];
        _customButton5.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_customButton5 setNeedsLayout];
    }
    return _customButton5;
}

@end
