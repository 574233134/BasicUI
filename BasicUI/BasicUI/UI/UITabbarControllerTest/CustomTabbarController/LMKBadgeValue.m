//
//  LMKBadgeValue.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "LMKBadgeValue.h"
#import "UIView+frame.h"
#import "TabbarBaseConfig.h"
#import "UIColor+hexColor.h"
@implementation LMKBadgeValue

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.bgImageView.size = CGSizeMake(14, 14);
        [self addSubview:self.bgImageView];
        
        self.badgeL = [[UILabel alloc] initWithFrame:self.bounds];
        self.badgeL.textColor = [[TabbarBaseConfig config] badgeTextColor];
        self.badgeL.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:10];;
        self.badgeL.size = CGSizeMake(14, 14);
        self.badgeL.textAlignment = NSTextAlignmentCenter;
        self.badgeL.layer.cornerRadius = 7.f;
        self.badgeL.layer.masksToBounds = YES;
       // self.badgeL.backgroundColor = [[TabbarBaseConfig config] badgeBackgroundColor];
        [self addSubview:self.badgeL];
        self.badgeL.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)resetBadgeLabel
{
    if (![self.badgeL.superview isKindOfClass:[self class]]) {
        [self.badgeL.superview removeFromSuperview];
        [self addSubview:self.badgeL];
    }
    self.badgeL.layer.cornerRadius = 7.f;
    self.badgeL.font = [UIFont systemFontOfSize:10];
    self.badgeL.textColor = [[TabbarBaseConfig config] badgeTextColor];
    self.badgeL.textAlignment = NSTextAlignmentCenter;
    self.badgeL.size = CGSizeMake(14, 14);
    self.badgeL.layer.masksToBounds = YES;
//    self.badgeL.backgroundColor = [[TabbarBaseConfig config] badgeBackgroundColor];
    self.badgeL.backgroundColor = [UIColor clearColor];
}


- (void)setType:(LMKBadgeValueType )type
{
    [self resetBadgeLabel];
    _type = type;
    if (type == LMKBadgeValueTypePoint)
    {
        self.badgeL.size = CGSizeMake(15, 15);
 //       self.badgeL.layer.cornerRadius = 3.5f;
//        self.badgeL.x = 0;
//        self.badgeL.y = 3.5;
        self.bgImageView.size = CGSizeMake(15, 15);
        self.bgImageView.image = [UIImage imageNamed:@"red_point"];
    }
    else if (type == LMKBadgeValueTypeNew)
    {
        CGSize size = CGSizeZero;
        CGFloat radius = 7.f;
        self.badgeL.layer.cornerRadius = 0;
        if (self.badgeL.text.length <= 1)
        {
            size = CGSizeMake(14, 14);
            radius = size.height * 0.5;
        } else if (self.badgeL.text.length > 1)
        {
            size = CGSizeMake([self calculateRowWidthString:self.badgeL.text withHeight:14 andFont:self.badgeL.font]+14, 14);
        }
        
        self.badgeL.size = size;
        UIView *labelBackground = [[UIView alloc] initWithFrame:self.badgeL.frame];
        self.badgeL.backgroundColor = [UIColor clearColor];
        self.badgeL.frame = self.badgeL.bounds;
        [self.badgeL.superview addSubview:labelBackground];
        [self.badgeL removeFromSuperview];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#FF4142"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#FF4B2B"].CGColor];
        gradientLayer.locations = @[@0.3, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = self.badgeL.bounds;
        [labelBackground.layer addSublayer:gradientLayer];
        [labelBackground addSubview:self.badgeL];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.badgeL.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.badgeL.bounds;
        maskLayer.path = maskPath.CGPath;
        labelBackground.layer.mask = maskLayer;
    }
    else if (type == LMKBadgeValueTypeNumber)
    {
        CGSize size = CGSizeZero;
        CGFloat radius = 7.f;
        if (self.badgeL.text.length <= 1)
        {
            size = CGSizeMake(15, 15);
            radius = size.height * 0.5;
            self.bgImageView.image = [UIImage imageNamed:@"red_Oval"] ;
        } else if (self.badgeL.text.length > 1)
        {
            
            size = CGSizeMake([self calculateRowWidthString:self.badgeL.text withHeight:15 andFont:self.badgeL.font]+10, 15);
            radius = 7.f;
            self.bgImageView.image = [UIImage imageNamed:@"red_Rect"] ;
        }
        self.badgeL.text = @"";
        self.badgeL.size = size;
        self.badgeL.layer.cornerRadius = radius;
        self.bgImageView.size = size;
    }
    
}

- (CGFloat)calculateRowWidthString:(NSString *)string withHeight:(CGFloat)height andFont:(UIFont *)font
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
}



@end
