//
//  CustomSliderDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomSliderDemo.h"
#import "LMKSlider.h"
@interface CustomSliderDemo ()

@property(nonatomic, strong)LMKSlider *customSlider;//买入数量百分比

@property(nonatomic, strong)UILabel *sliderValueLabel;//滑块下面的值

@end

@implementation CustomSliderDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义Slider";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatCustomSlider];
}

- (void)creatCustomSlider
{
    self.customSlider = [[LMKSlider alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width-100, 30)];
    self.customSlider.titleStyle = TopTitleStyle;
    self.customSlider.isShowTitle = YES;
    //设置最大和最小值
    self.customSlider.minimumValue = 0;
    self.customSlider.maximumValue = 100;
    self.customSlider.maximumTrackTintColor = [UIColor orangeColor];//设置滑块线条的颜色（右边）,默认是灰色
    self.customSlider.thumbTintColor = [UIColor blueColor];///设置滑块按钮的颜色
    [self.view addSubview:self.customSlider];
    
    UIImage *imagea=[self OriginImage:[UIImage imageNamed:@"round"] scaleToSize:CGSizeMake(35, 35)];
    UIImage *imagea2=[self OriginImage:[UIImage imageNamed:@"round"] scaleToSize:CGSizeMake(35, 35)];
    [self.customSlider setThumbImage:imagea forState:UIControlStateNormal];
    [self.customSlider setThumbImage:imagea2 forState:UIControlStateHighlighted];
    

}

/*
 对原来的图片的大小进行处理
 @param image 要处理的图片
 @param size  处理过图片的大小
 */
-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}



@end
