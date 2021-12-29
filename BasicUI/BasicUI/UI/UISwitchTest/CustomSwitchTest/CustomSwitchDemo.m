//
//  CustomSwitchDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomSwitchDemo.h"
#import "CustomSwitch.h"


@interface CustomSwitchDemo ()

@property (strong, nonatomic)CustomSwitch *cusSwitch1; // 类似系统的开关

@property (strong, nonatomic) CustomSwitch *cusSwitch2; // 带圆角的矩形开关

@property (strong, nonatomic) CustomSwitch *cusSwitch3; // 不带圆角的举行开关

@property (strong, nonatomic) CustomSwitch *cusSwitch4; // 椭圆形开关

@end

@implementation CustomSwitchDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义开关";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cusSwitch1];
    [self.view addSubview:self.cusSwitch2];
    [self.view addSubview:self.cusSwitch3];
    [self.view addSubview:self.cusSwitch4];
}

- (CustomSwitch *)cusSwitch1
{
    if (!_cusSwitch1)
    {
        _cusSwitch1 = [[CustomSwitch alloc]initWithFrame:CGRectMake(20, 92, 0, 0)];
        [_cusSwitch1 setTintBorderColor:[UIColor lightGrayColor]];
    }
    return _cusSwitch1;
}

- (CustomSwitch *)cusSwitch2
{
    if (!_cusSwitch2)
    {
        _cusSwitch2 = [[CustomSwitch alloc]initWithFrame:CGRectMake(20, 184, 100, 30)];
        _cusSwitch2.onBackLabel.text = @"已打开";
        _cusSwitch2.offBackLabel.text = @"已关闭";
        [_cusSwitch2 setOnTintColor:[UIColor greenColor]];
        [_cusSwitch2 setThumbTintColor:[UIColor colorWithRed:1.000 green:0.840 blue:0.837 alpha:1.000]];
        [_cusSwitch2 setOnTintColor:[UIColor colorWithRed:0.319 green:1.000 blue:0.136 alpha:1.000]];
        [_cusSwitch2 setShape:CustomSwitchShapeRectangle];
    }
    return _cusSwitch2;
}

- (CustomSwitch *)cusSwitch3
{
    if (!_cusSwitch3)
    {
        _cusSwitch3 = [[CustomSwitch alloc]initWithFrame:CGRectMake(20, 252, 150, 50)];
        _cusSwitch3.onBackLabel.text = @"已打开";
        _cusSwitch3.onBackLabel.textColor = [UIColor whiteColor];
        _cusSwitch3.offBackLabel.text = @"已关闭";
        [_cusSwitch3 setTintColor:[UIColor cyanColor]];
        [_cusSwitch3 setOnTintColor:[UIColor purpleColor]];
        [_cusSwitch3 setThumbTintColor:[UIColor whiteColor]];
        [_cusSwitch3 setShape:CustomSwitchShapeRectangleNoCorner];
    }
    return _cusSwitch3;
}

- (CustomSwitch *)cusSwitch4
{
    if (!_cusSwitch4)
    {
        _cusSwitch4 = [[CustomSwitch alloc]initWithFrame:CGRectMake(20, 312, 150, 50)];
        _cusSwitch4.onBackLabel.text = @"已打开";
        _cusSwitch4.offBackLabel.text = @"已关闭";
        _cusSwitch4.onBackLabel.textColor = [UIColor whiteColor];
        [_cusSwitch4 setTintColor:[UIColor redColor]];
        [_cusSwitch4 setOnTintColor:[UIColor greenColor]];
        [_cusSwitch4 setThumbTintColor:[UIColor whiteColor]];
    }
    return _cusSwitch4;
}
@end
