//
//  CustomTabbarItem.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomTabbarItem.h"
#import "TabbarBaseConfig.h"
#import "UIView+frame.h"

@implementation CustomTabbarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        
        self.title = [[UILabel alloc] init];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont systemFontOfSize:10.f];
        [self addSubview:self.title];
        
        self.badgeValue = [[LMKBadgeValue alloc] init];
        self.badgeValue.hidden = YES;
        [self addSubview:self.badgeValue];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize imageSize = [[TabbarBaseConfig config] imageSize];
    CGFloat imageY = 5;
    if ([[TabbarBaseConfig config] typeLayout] == LMKConfigTypeLayoutImage)
    {
        imageY = self.height * 0.5 - imageSize.height * 0.5;
    }
    CGFloat iamgeX = self.width * 0.5 - imageSize.width * 0.5;
    self.imageView.frame = CGRectMake(iamgeX, imageY, imageSize.width, imageSize.height);
    
    CGFloat titleX = 4;
    CGFloat titleH = 15.f;
    CGFloat titleW = self.width - 8;
    CGFloat titleY = self.height - 18.f;
    self.title.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat badgeX = iamgeX+imageSize.width*3/4;
    CGFloat badgeY = CGRectGetMinY(self.imageView.frame) - 4;
    self.badgeValue.origin = CGPointMake(badgeX, badgeY);
}

- (void)setTypeLayout:(LMKConfigTypeLayout )typeLayout
{
    _typeLayout = typeLayout;
    
    if (typeLayout == LMKConfigTypeLayoutImage)
    {
        self.title.hidden = YES;
        
        CGSize imageSize = [[TabbarBaseConfig config] imageSize];
        
        CGFloat imageX = self.width * 0.5 - imageSize.width * 0.5;
        CGFloat imageY = self.height * 0.5 - imageSize.height * 0.5;
        self.imageView.frame = CGRectMake(imageX, imageY, imageSize.width, imageSize.height);
    }
}

@end
