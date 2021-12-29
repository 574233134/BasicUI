//
//  SystemSliderDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "SystemSliderDemo.h"

@interface SystemSliderDemo ()

@property (strong, nonatomic) IBOutlet UISlider *sysSlider;

@property (strong, nonatomic) IBOutlet UILabel *sliderValue;

@property (strong, nonatomic) IBOutlet UISlider *imageSlider;


@end

@implementation SystemSliderDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"系统Slider";
    [self setupSlider];
    self.sliderValue.text = [NSString stringWithFormat:@"%.2f",self.sysSlider.value];
}

/**
 * 1. minimumValue 最小值 （默认为0.0）
 * 2. maximumValue 最大值 （默认为1.0）
 * 3. value 当前值（必须在最小值和最大值之间，默认为0.0）
 *
 * 4. minimumTrackTintColor 滑块左侧slider背景色
 * 5. minimumTrackTintColor 滑块t右侧slider背景色
 * 7. thumbTintColor 滑块颜色
 */
- (void)setupSlider
{
    self.sysSlider.minimumValue = 0.0;
    self.sysSlider.maximumValue = 1.0;
    self.sysSlider.value = 0.5;
    [self setSliderColor];
    [self setImageSlider];
}

- (void)setSliderColor
{
    self.sysSlider.minimumTrackTintColor = [UIColor redColor];
    self.sysSlider.maximumTrackTintColor = [UIColor blackColor];
    self.sysSlider.thumbTintColor = [UIColor purpleColor];
    [self.sysSlider setMinimumValueImage:[UIImage imageNamed:@"minValue"]];
    [self.sysSlider setMaximumValueImage:[UIImage imageNamed:@"maxValue"]];
    
   
}

- (void)setImageSlider
{
    [self.imageSlider setMinimumTrackImage:[UIImage imageNamed:@"btn_image_disable"] forState:UIControlStateNormal];
    [self.imageSlider setMaximumTrackImage:[UIImage imageNamed:@"btn_image_normal"] forState:UIControlStateNormal];
    [self.imageSlider setThumbImage:[UIImage imageNamed:@"umbrellaIcon"] forState:UIControlStateNormal];
}

- (IBAction)sliderValueChanged:(UISlider *)sender
{
    self.sliderValue.text = [NSString stringWithFormat:@"%.2f",self.sysSlider.value];
}



@end
