//
//  CustomPageControl.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/27.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomPageControl.h"
#import "UIView+frame.h"
#import "BasicUIDemo.h"
#define defaultW 22
#define defaultH 7
#define defaultMagrin 8    // 圆点间距

@interface CustomPageControl ()

@property (assign, nonatomic) CGFloat dotW;

@property (assign, nonatomic) CGFloat dotH;

@property (assign, nonatomic) CGFloat currentW;

@property (assign, nonatomic) CGFloat currentH;

@end

@implementation CustomPageControl

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self updateDots];
}

- (void)updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView *dot = [self imageViewForSubview:[self.subviews objectAtIndex:i] currPage:i];
        if (i == self.currentPage && self.currentImage!=nil)
        {
            dot.image = self.currentImage;
            dot.size = self.currentImageSize;
        }
        else if(self.inactiveImage!=nil)
        {
            dot.image = self.inactiveImage;
            dot.size = self.inactiveImageSize;
        }
    }
}

- (UIImageView *)imageViewForSubview:(UIView *)view currPage:(int)currPage
{
    UIImageView *dot = nil;
    if ([view isKindOfClass:[UIView class]])
    {
        for (UIView *subview in view.subviews)
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                dot = (UIImageView *)subview;
                break;
            }
        }
        
        if (dot == nil)
        {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            [view addSubview:dot];
        }
    }
    else
    {
        dot = (UIImageView *)view;
    }
    
    return dot;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setDefaultValue];
    
    CGFloat marginX = self.dotW + self.magrin;
    
    // 计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 2 ) * marginX+self.currentW+self.magrin;
    
    // 设置新frame
    self.frame = CGRectMake(SCREEN_WIDTH/2-(newW + self.dotW)/2, self.frame.origin.y, newW + self.dotW, self.frame.size.height);
    
    // 遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++)
    {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        if ( i<self.currentPage )
        {
            [dot setFrame:CGRectMake(i * marginX, (self.height-self.dotH)/2, self.dotW, self.dotH)];
        }
        else if (i == self.currentPage)
        {
            [dot setFrame:CGRectMake(i * marginX, (self.height-self.currentH)/2, self.currentW, self.currentH)];
        }
        else
        {
            [dot setFrame:CGRectMake((i-1) * marginX + self.currentW+self.magrin, (self.height-self.dotH)/2, self.dotW, self.dotH)];
        }
    }
}

- (void)setDefaultValue
{
    CGFloat width = self.currentImageSize.width+(self.numberOfPages-1)*(self.inactiveImageSize.width+self.magrin);
    
    CGFloat minWidth = defaultW * self.numberOfPages+(self.numberOfPages-1)*self.magrin;
    CGFloat height = self.currentImageSize.height > self.inactiveImageSize.height ? self.currentImageSize.height : self.inactiveImageSize.height;
    self.height = self.height > height ? self.height : height;
    if (width<minWidth)
    {
        self.width = minWidth;
    }
    
    if (width>self.width)
    {
        self.currentW = defaultW;
        self.currentH = defaultH;
        self.dotW = defaultW;
        self.dotH = defaultH;
        self.magrin = defaultMagrin;
        return;
    }
    
    
    if(CGSizeEqualToSize(self.currentImageSize, CGSizeZero))
    {
        self.currentW = defaultW;
        self.currentH = defaultH;
    }
    else
    {
        self.currentW = self.currentImageSize.width;
        self.currentH = self.currentImageSize.height;
    }
    if (CGSizeEqualToSize(self.inactiveImageSize, CGSizeZero))
    {
        self.dotW = defaultW;
        self.dotH = defaultH;
    }
    else
    {
        self.dotW = self.inactiveImageSize.width;
        self.dotH = self.inactiveImageSize.height;
    }
    if (self.magrin == 0)
    {
        self.magrin = defaultMagrin;
    }
    
}

@end
