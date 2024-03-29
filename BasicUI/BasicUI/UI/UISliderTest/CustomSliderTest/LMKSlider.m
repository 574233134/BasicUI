//
//  LMKSlider.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/11.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "LMKSlider.h"
#import <Masonry.h>
#import "UIView+frame.h"
// 适配
#define BANEWWIDTH                     [UIScreen mainScreen].bounds.size.width/375
#define BANEWHEIGHT                    [UIScreen mainScreen].bounds.size.height/667

#define BAScale_WIDTH(a)               (a*BANEWWIDTH)
#define BAScale_HEIGHT(a)              (a*BANEWHEIGHT)

#define thumbBound_x 10
#define thumbBound_y 20

@interface LMKSlider ()

@property(nonatomic, strong) UILabel *sliderValueLabel;//滑块下面的值

@property(nonatomic, assign) CGRect lastBounds;

@end

@implementation LMKSlider

// 解决自定义滑块图片左右有间隙问题
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    rect.origin.x = rect.origin.x-10;
    rect.size.width = rect.size.width + 20;
    CGRect result = [super thumbRectForBounds:bounds trackRect:rect value:value];
    
    _lastBounds = result;
    return result;
}

// 解决滑块不灵敏
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    UIView *result = [super hitTest:point withEvent:event];
    if (point.x < 0 || point.x > self.bounds.size.width)
    {
        return result;
    }
    
    if ((point.y >= -thumbBound_y) && (point.y < _lastBounds.size.height + thumbBound_y))
    {
        float value = 0.0;
        value = point.x -  self.bounds.origin.x;;
        value = value/self.bounds.size.width;
        
        value = value < 0? 0 : value;
        value = value > 1? 1: value;
        
        value = value * (self.maximumValue - self.minimumValue) + self.minimumValue;
        [self setValue:value animated:YES];
    }
    return result;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL result = [super pointInside:point withEvent:event];
    if (!result && point.y > -10)
    {
        if ((point.x >= _lastBounds.origin.x - thumbBound_x) && (point.x <= (_lastBounds.origin.x + _lastBounds.size.width + thumbBound_x)) && (point.y < (_lastBounds.size.height + thumbBound_y)))
        {
            result = YES;
        }
        
    }
    return result;
}

-(void)setIsShowTitle:(BOOL)isShowTitle
{
    _isShowTitle = isShowTitle;
    
    if (_isShowTitle == YES) {
        // 滑块的响应事件
        [self addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        self.continuous = YES; // 设置可连续变化
        
        // 当前值label
        self.sliderValueLabel = [[UILabel alloc] init];
        self.sliderValueLabel.textAlignment = NSTextAlignmentCenter;
        self.sliderValueLabel.font = [UIFont systemFontOfSize:14];
        self.sliderValueLabel.textColor = [UIColor orangeColor];
        self.sliderValueLabel.text = [NSString stringWithFormat:@"%.f%%", self.value];
        [self addSubview:self.sliderValueLabel];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIImageView *slideImage = (UIImageView *)[self.subviews lastObject];
            
            // 滑块的值
            [self.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                if (self.titleStyle == TopTitleStyle)
                {
                    make.bottom.mas_equalTo(slideImage.mas_top).offset(-5);
                }else{
                    make.top.mas_equalTo(slideImage.mas_bottom).offset(5);
                }
                
                make.centerX.equalTo(slideImage);
            }];
        });
    }
}

- (void)sliderAction:(UISlider*)slider
{
    // 滑块的值
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%.f%%", self.value];
}

@end
