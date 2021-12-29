//
//  UIViewBasic.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/18.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "UIViewBasic.h"
#import "BasicUIDemo.h"
#import "UIView+frame.h"
@interface UIViewBasic ()

@property (strong, nonatomic) UIView *firstView;

@property (strong, nonatomic) UIView *secendView;

@property (strong, nonatomic) UILabel *firstLabel;

@property (strong, nonatomic) UILabel *secendLabel;

@end

@implementation UIViewBasic

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadFirstViewConfig];
    [self loadSecendViewConfig];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    [self subViewLog];
    [self logFirstViewLocation];
    [self coordinateTransformation];
    
}

/** 输出子视图 */
- (void)subViewLog
{
    // firstView 和 secendView 为self.view的子视图
    NSLog(@"self.view.subview = %@",self.view.subviews);
    
    NSLog(@"self.firstView.subview = %@",self.firstView.subviews);
    
    NSLog(@"self.secendView.subView = %@",self.secendView.subviews);
    
}

/** 输出firstView 的位置信息 */
- (void)logFirstViewLocation
{
    
    NSLog(@"self.firstview.frame = %@ ",NSStringFromCGRect(self.firstView.frame));
    
    NSLog(@"self.firstview.bounds = %@ ",NSStringFromCGRect(self.firstView.bounds));
    
    NSLog(@"self.firstview.center = %@ ", NSStringFromCGPoint(self.firstView.center));
}

/** 坐标转换 */
- (void)coordinateTransformation
{
    CGPoint firstPoint = CGPointZero;
    CGPoint selfPoint = [self.firstView convertPoint:firstPoint toView:self.view];
    NSLog(@"firstView 中的（0，0）点在self.View 中坐标为：%@",NSStringFromCGPoint(selfPoint));
    
    CGPoint fromPoint = selfPoint;
    CGPoint currentViewPoint = [self.firstView convertPoint:fromPoint fromView:self.view];
    NSLog(@"self.view 中的 %@ 在firstView 中的坐标为 ： %@",NSStringFromCGPoint(fromPoint),NSStringFromCGPoint(currentViewPoint));
    
    CGRect firstFrame = self.firstView.frame;
    CGRect selfFrame = [self.firstView convertRect:firstFrame toView:self.view];
    NSLog(@"firestView rect 为 %@， 转换到self.view 上 rect 为 %@",NSStringFromCGRect(firstFrame),NSStringFromCGRect(selfFrame));
    
    CGRect fromRect = selfFrame;
    CGRect torect = [self.firstView convertRect:fromRect toView:self.view];
    NSLog(@"self.view 中的rect %@, 转换到firstView 上rect 为: %@",NSStringFromCGRect(fromRect),NSStringFromCGRect(torect));
    
}

# pragma mark - firstView 基础属性

/** 加载firstView 基础内容 */
- (void)loadFirstViewConfig
{
    self.firstView = [[UIView alloc]init];
    
    self.firstView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.firstView];
    
    [self autoLayoutFirstView];
    
    // 由于上面自动布局了子视图，所以调用下面方法后系统会调用layoutSubviews，否则打印出的frame 为0，0，0，0
    [self.firstView layoutIfNeeded];
    
    NSLog(@"%@",self.firstView.superview);// view 的父视图
    
    self.firstView.backgroundColor = [UIColor cyanColor]; // 背景颜色
    
    self.firstView.multipleTouchEnabled = YES; // 允许多点触碰，默认为NO
    
    self.firstView.exclusiveTouch = YES; // 决定当前视图是否是处理触摸事件的唯一对象
    
    NSLog(@"self.firstView.widow %@",self.firstView.window);
    
    // 如果opaque设置为YES，绘图系统会将view看为完全不透明，这样绘图系统就可以优化一些绘制操作以提升性能。如果设置为NO，那么绘图系统结合其它内容来处理view。默认情况下，这个属性是YES。
    self.firstView.opaque = NO;
    
    // 视图是否隐藏默认为NO
    self.firstView.hidden = NO;
    
    // 视图的透明度（0~1之间）
    self.firstView.alpha = 0.5;
    
    [self loadFirstLabel];
}

/** 加载secendView 基础内容 */
- (void)loadSecendViewConfig
{
    self.secendView = [[UIView alloc]init];
    self.secendView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.secendView];
    [self autoLayoutSencendView];
    [self.secendView layoutIfNeeded];
    self.secendView.backgroundColor = [UIColor orangeColor];
    [self loadSecendLabel];
}


- (void)loadFirstLabel
{
    self.firstLabel = [[UILabel alloc]init];
    self.firstLabel.text = @"view1";
    self.firstLabel.backgroundColor = [UIColor brownColor];
    self.firstLabel.frame = CGRectMake((self.firstView.width-80)/2, (self.firstView.height-40)/2, 80, 40);
    [self.firstView addSubview:self.firstLabel];
}

- (void)loadSecendLabel
{
    self.secendLabel = [[UILabel alloc]init];
    self.secendLabel.text = @"view2";
    self.secendLabel.backgroundColor = [UIColor brownColor];
    self.secendLabel.frame = CGRectMake((self.secendView.width - 80)/2, (self.secendView.height-40)/2, 80, 40);
    [self.secendView addSubview:self.secendLabel];
}


#pragma mark - UIView AutoLayout 布局
- (void)autoLayoutFirstView
{
    
    NSLayoutConstraint *firstLeft = [NSLayoutConstraint constraintWithItem:self.firstView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:50];
    [self.view addConstraint:firstLeft];
    
    NSLayoutConstraint *firstRight = [NSLayoutConstraint constraintWithItem:self.firstView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-50];
    [self.view addConstraint:firstRight];
    
    NSLayoutConstraint *firstTop = [NSLayoutConstraint constraintWithItem:self.firstView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:50+NARBARHEIGHT];
    [self.view addConstraint:firstTop];
    
    
    NSLayoutConstraint *firstBottom = [NSLayoutConstraint constraintWithItem:self.firstView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:-10];
    [self.view addConstraint:firstBottom];
}

- (void)autoLayoutSencendView
{
    NSLayoutConstraint *secendLeft = [NSLayoutConstraint constraintWithItem:self.secendView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:50];
    [self.view addConstraint:secendLeft];

    NSLayoutConstraint *secendRight = [NSLayoutConstraint constraintWithItem:self.secendView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-50];
    [self.view addConstraint:secendRight];
    
    NSLayoutConstraint *secendTop = [NSLayoutConstraint constraintWithItem:self.secendView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:10];
    [self.view addConstraint:secendTop];
    
    NSLayoutConstraint *secendHeight = [NSLayoutConstraint constraintWithItem:self.secendView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0 constant:200];
    [self.view addConstraint:secendHeight];
}


@end
