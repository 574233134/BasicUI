//
//  ColorViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/27.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ColorViewController.h"

@interface ColorViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label1;

@property (strong, nonatomic) IBOutlet UILabel *label2;

@property (strong, nonatomic) IBOutlet UILabel *label3;

@property (strong, nonatomic) IBOutlet UILabel *label4;

@property (strong, nonatomic) IBOutlet UILabel *label5;

@property (strong, nonatomic) IBOutlet UILabel *label6;

@property (strong, nonatomic) IBOutlet UILabel *label7;

@property (strong, nonatomic) IBOutlet UILabel *label8;

@property (strong, nonatomic) IBOutlet UILabel *label9;

@property (strong, nonatomic) IBOutlet UILabel *label10;

@property (strong, nonatomic) IBOutlet UILabel *label11;

@property (strong, nonatomic) IBOutlet UILabel *label12;

@property (strong, nonatomic) IBOutlet UILabel *label13;

@property (strong, nonatomic) IBOutlet UILabel *label14;

@property (strong, nonatomic) IBOutlet UILabel *label15;

@end

@implementation ColorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title  = @"color";
    [self setAllLabelsColor];
    
}

- (void)setAllLabelsColor
{
    // 黑色 0.0 white
    self.label1.backgroundColor = [UIColor blackColor];
    
    // 深灰色 0.333 white
    self.label2.backgroundColor = [UIColor darkGrayColor];
    
    // 浅灰色 0.667 white
    self.label3.backgroundColor = [UIColor lightGrayColor];
    
    // 白色 1.0 white
    self.label4.backgroundColor = [UIColor whiteColor];
    
    // 灰色 0.5 white
    self.label5.backgroundColor = [UIColor grayColor];
    
    // 红色 1.0, 0.0, 0.0 RGB
    self.label6.backgroundColor = [UIColor redColor];
    
    // 绿色 0.0, 1.0, 0.0 RGB
    self.label7.backgroundColor = [UIColor greenColor];
    
    // 蓝色 0.0, 0.0, 1.0 RGB
    self.label8.backgroundColor = [UIColor blueColor];
    
    // 青色 0.0, 1.0, 1.0 RGB
    self.label9.backgroundColor = [UIColor cyanColor];
    
    // 黄色 1.0, 1.0, 0.0 RGB
    self.label10.backgroundColor = [UIColor yellowColor];
    
    // 1.0, 0.0, 1.0 RGB
    self.label11.backgroundColor = [UIColor magentaColor];
    
    // 橙色 1.0, 0.5, 0.0 RGB
    self.label12.backgroundColor = [UIColor orangeColor];
    
    // 紫色 0.5, 0.0, 0.5 RGB
    self.label13.backgroundColor = [UIColor purpleColor];
    
    // 棕色 0.6, 0.4, 0.2 RGB
    self.label14.backgroundColor = [UIColor brownColor];
    
    // 透明无色 0.0 white, 0.0 alpha
    self.label15.backgroundColor = [UIColor clearColor];
    
    
}


- (IBAction)changeColor:(UIButton *)sender
{
    // white 越接近1越接近白色，越接近0越接近e黑色;
    self.label1.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    
    // RGB 色值
    self.label2.backgroundColor = [UIColor colorWithRed:243/255.0 green:92/255.0 blue:93/255 alpha:1];
    
    // HSB(色调,饱和度,亮度),根据HSB生成颜色 根据给定的 色调hue 饱和度saturation 亮度brightness来生成颜色。
    // hue色调:通常是指图像的整体明暗度.例如，如果图像亮部像素较多的话，则图像整体上看起来较为明快
    // saturation饱和度:又称彩度,是指颜色的强度或纯度,饱和度表示色相中灰色分量所占的比例，它使用从0%（灰色）至100%（完全饱和）的百分比来度量。 在标准色轮上，饱和度从中心到边缘递增
    // brightness亮度:是颜色的相对明暗程度，通常使用从0%（黑色）至100%（白色）的百分比来度量
    self.label3.backgroundColor = [UIColor colorWithHue:0.3 saturation:1 brightness:0.5 alpha:1];
    
    // 使用Display P3颜色空间中指定的不透明度和RGB分量值创建并返回颜色对象。
    if (@available(iOS 10.0, *)) {
        self.label4.backgroundColor = [UIColor colorWithDisplayP3Red:243/255.0 green:92/255.0 blue:93/255.0 alpha:1];
    }
    
    // 使用指定的图像创建并返回一个颜色对象 （不太清除绘制的颜色是怎么得来的）
    self.label5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"thumb5"]];
    
    
     
   
}


@end
