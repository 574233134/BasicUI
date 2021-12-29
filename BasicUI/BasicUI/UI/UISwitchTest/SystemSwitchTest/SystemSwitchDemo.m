//
//  SystemSwitchDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//
#import "SystemSwitchDemo.h"

@interface SystemSwitchDemo ()

@property (strong, nonatomic) IBOutlet UISwitch *colorSwitch;

@property (strong, nonatomic) IBOutlet UISwitch *imageSwitch;

@property (strong, nonatomic) IBOutlet UISwitch *sizeSwitch;

@end

@implementation SystemSwitchDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"系统开关";
    [self initSwitch];
    [self changeSwitchSize];
}


/**
 * 1. onTintColor 开关打开时颜色
 * 2. tintColor 开关轮廓颜色
 * 3. thumbTintColor 滑块颜色
 * 4. onImage 开关处于开启状态时的图片(iOS7及之后设置无效)
 * 5. offImage 开关处于关闭状态时的图片(iOS7及之后设置无效)
 */
- (void)initSwitch
{
    self.colorSwitch.onTintColor = [UIColor redColor];
    
    self.colorSwitch.tintColor = [UIColor blueColor];
    
    self.colorSwitch.thumbTintColor = [UIColor grayColor];
    
    self.imageSwitch.onImage = [UIImage imageNamed:@"btn_image_normal"];
    
    self.imageSwitch.offImage = [UIImage imageNamed:@"btn_image_heightlighted"];
}

/**
 * 使用缩放改变Switch大小
 */
 - (void)changeSwitchSize
{
    self.sizeSwitch.transform= CGAffineTransformMakeScale(0.75,0.75);
}
@end
