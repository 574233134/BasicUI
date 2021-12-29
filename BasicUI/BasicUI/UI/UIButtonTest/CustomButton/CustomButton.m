//
//  CustomButton.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomButton.h"
#import "UIView+frame.h"
@implementation CustomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self setup];
    }
    return self;
}

// 初始化属性值
- (void)setup
{
    _titleImageSpacing = 4;
    _imagePosition = CustomButtonImagePositionLeft;
    _imageCornerRadius = 0;
}

#pragma mark - Setter

- (void)setImagePosition:(CustomButtonImagePosition)imagePosition
{
    _imagePosition = imagePosition;
    [self setNeedsLayout];
}

- (void)setInterTitleImageSpacing:(CGFloat)interTitleImageSpacing
{
    _titleImageSpacing = interTitleImageSpacing;
    [self setNeedsLayout];
}

- (void)setImageCornerRadius:(CGFloat)imageCornerRadius
{
    _imageCornerRadius = imageCornerRadius;
    self.imageView.layer.cornerRadius = imageCornerRadius;
    self.imageView.layer.masksToBounds = YES;
}

#pragma mark - Layout subviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (CGRectIsEmpty(self.bounds))
    {
        return;
    }
    [self p_resizeSubviews];
    if (self.imagePosition == CustomButtonImagePositionLeft)
    {
        // 图片在左侧：🏝+文字
        [self p_layoutSubViewsForImagePositionLeft];
        
    }
    else if (self.imagePosition == CustomButtonImagePositionRight)
    {
        // 图片在右侧：文字+🏝
        [self p_layoutSubViewsForImagePositionRight];
        
    }
    else if (self.imagePosition == CustomButtonImagePositionTop)
    {
        // 图片在顶部
        [self p_layoutSubViewsForImagePositionTop];
    }
    else if (self.imagePosition == CustomButtonImagePositionBottom)
    {
        // 图片在底部
        [self p_layoutSubViewsForImagePositionBottom];
    }
}

// 计算尺寸
- (void)p_resizeSubviews
{
    self.imageView.size = self.imageView.image.size;
    [self.titleLabel sizeToFit];
    
    // 防止titleLabel 位置超出customLabel
    if (self.imagePosition == CustomButtonImagePositionRight ||  // 图片在右侧：文字+🏔
        self.imagePosition == CustomButtonImagePositionLeft ) // 图片在左侧：🏝+文字
    {
        if (self.titleLabel.width > (self.width - self.titleImageSpacing - self.imageView.width))
        {
            self.titleLabel.width = self.width - self.titleImageSpacing - self.imageView.width;
        }
    }
    else if (self.imagePosition == CustomButtonImagePositionTop || // 图片在顶部
               self.imagePosition == CustomButtonImagePositionBottom)// 图片在底部
    {
        if (self.titleLabel.width > self.width)
        {
            self.titleLabel.width = self.width;
        }
    }
}

// 图片在左侧
- (void)p_layoutSubViewsForImagePositionLeft
{
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight)
    {
        // 整体靠右
        self.titleLabel.x = self.width - self.titleLabel.width;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
        
        self.imageView.x = self.width - self.titleLabel.width - self.titleImageSpacing - self.imageView.width;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
        
    }
    else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft)
    {
        // 整体靠左
        self.imageView.x = 0;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
        
        self.titleLabel.x = self.imageView.right + self.titleImageSpacing;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
        
    }
    else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter)
    {
        // 整体居中
        self.imageView.x = self.width * 0.5 - (self.titleLabel.width + self.titleImageSpacing + self.imageView.width) * 0.5;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
        
        self.titleLabel.x = self.titleImageSpacing + self.imageView.right;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
    }
}

// 图片在右侧
- (void)p_layoutSubViewsForImagePositionRight
{
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight)
    {
        // 整体靠右
        self.imageView.x = self.width - self.imageView.width;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
        
        self.titleLabel.x = self.width - self.imageView.width - self.titleImageSpacing - self.titleLabel.width;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
        
    }
    else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft)
    {
        // 整体靠左
        self.titleLabel.x = 0;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
        
        self.imageView.x = self.titleImageSpacing + self.titleLabel.width;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
        
    }
    else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter)
    {
        // 整体居中
        self.titleLabel.x = self.width * 0.5 - (self.titleLabel.width + self.titleImageSpacing + self.imageView.width) * 0.5;
        self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
        
        self.imageView.x = self.titleLabel.x + self.titleLabel.width + self.titleImageSpacing;
        self.imageView.y = (self.height - self.imageView.height) * 0.5;
    }
}

// 图片在顶部
- (void)p_layoutSubViewsForImagePositionTop
{
    if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop)
    {
        // 整体靠顶部
        self.imageView.y = 0;
        self.imageView.centerX = self.width * 0.5;
        
        self.titleLabel.y = self.imageView.bottom + self.titleImageSpacing;
        self.titleLabel.centerX = self.width * 0.5;
        
    }
    else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom)
    {
        // 整体靠底部
        self.titleLabel.y = self.height - self.titleLabel.height;
        self.titleLabel.centerX = self.width * 0.5;
        self.imageView.y = self.height - (self.imageView.height + self.titleLabel.height + self.titleImageSpacing);
        self.imageView.centerX = self.width * 0.5;
    }
    else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentCenter)
    {
        // 整体居中
        self.imageView.y = self.height * 0.5 - (self.imageView.height + self.titleLabel.height + self.titleImageSpacing) * 0.5;
        self.imageView.centerX = self.width * 0.5;
        
        self.titleLabel.y = self.imageView.bottom + self.titleImageSpacing;
        self.titleLabel.centerX = self.width * 0.5;
    }
}

// 图片在底部
- (void)p_layoutSubViewsForImagePositionBottom
{
    if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop)
    {
        // 整体靠顶部
        self.titleLabel.y = 0;
        self.titleLabel.centerX = self.width * 0.5;
        
        self.imageView.y = self.titleLabel.bottom + self.titleImageSpacing;
        self.imageView.centerX = self.width * 0.5;
        
    }
    else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom)
    {
        // 整体靠底部
        self.imageView.y = self.height - self.imageView.height;
        self.imageView.centerX = self.width * 0.5;
        
        self.titleLabel.y = self.height - (self.titleLabel.height + self.titleImageSpacing + self.imageView.height);
        self.titleLabel.centerX = self.width * 0.5;
        
    }
    else if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentCenter)
    {
        // 整体居中
        self.titleLabel.y = self.height * 0.5 - (self.imageView.height + self.titleLabel.height + self.titleImageSpacing) * 0.5;
        self.titleLabel.centerX = self.width * 0.5;
        self.imageView.y = self.titleLabel.bottom + self.titleImageSpacing;
        self.imageView.centerX = self.width * 0.5;
        
    }
}



@end
