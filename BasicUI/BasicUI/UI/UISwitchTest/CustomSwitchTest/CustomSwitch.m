//
//  CustomSwitch.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomSwitch.h"

#define VW(view) (view.frame.size.width)
#define VH(view) (view.frame.size.height)

static const CGFloat CustomAnimateDuration = 0.3f; // 动画时长
static const CGFloat CustomHorizontalAdjustment = 3.0f;
static const CGFloat CustomRectShapeCornerRadius = 4.0f; // 圆角
static const CGFloat CustomThumbShadowOpacity = 0.3f; // 阴影的不透明度
static const CGFloat CustomThumbShadowRadius = 0.5f; // 阴影半径
static const CGFloat CustomSwitchBorderWidth = 1.5f; // 边框宽度

@interface CustomSwitch()

@property (nonatomic, strong) UIView *onBackgroundView;
@property (nonatomic, strong) UIView *offBackgroundView;
@property (nonatomic, strong) UIView *thumbView; // 滑块

@end

@implementation CustomSwitch

- (id)initWithFrame:(CGRect)frame
{
    CGRect myframe = frame;
    if (CGSizeEqualToSize(frame.size, CGRectZero.size))
    {
        myframe = CGRectMake(frame.origin.x, frame.origin.y, 51, 31);
    }
    self = [super initWithFrame:myframe];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI
{
    self.shape = CustomSwitchShapeOval;
    self.shadow = YES;
    [self setBackgroundColor:[UIColor clearColor]];
    [self setOn:NO];
    
    // 开关背景视图添加单击手势
    UITapGestureRecognizer *tapBgGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBgTap:)];
    [tapBgGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:tapBgGestureRecognizer];
    
    [self setupOnUI];
    [self setupOffUI];
    [self setupThumb];
}

// 开启状态下UI设置
- (void)setupOnUI
{
    // 打开时候的背景
    self.onBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VW(self), VH(self))];
    [self.onBackgroundView setBackgroundColor:[UIColor greenColor]];
    [self.onBackgroundView.layer setCornerRadius:VH(self)/2];
    [self.onBackgroundView.layer setShouldRasterize:YES];
    [self.onBackgroundView.layer setRasterizationScale:[UIScreen mainScreen].scale];
    [self addSubview:self.onBackgroundView];
    
    // 打开状态下显示文字的label
    self.onBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0,VW(self.onBackgroundView)-15 , VH(self.onBackgroundView))];
    self.onBackLabel.textColor = [UIColor blackColor];
    self.onBackLabel.textAlignment = NSTextAlignmentLeft;
    [self.onBackgroundView addSubview:self.onBackLabel];
}

// 关闭状态下UI设置
- (void)setupOffUI
{
    // 关闭状态背景
    self.offBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VW(self), VH(self))];
    [self.offBackgroundView setBackgroundColor:[UIColor whiteColor]];
    [self.offBackgroundView.layer setCornerRadius:VH(self)/2];
    [self.offBackgroundView.layer setShouldRasterize:YES];
    [self.offBackgroundView.layer setRasterizationScale:[UIScreen mainScreen].scale];
    [self addSubview:self.offBackgroundView];
    
    
    // 关闭状态下显示文字的label
    self.offBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VW(self.offBackgroundView)-15, VH(self.offBackgroundView))];
    self.offBackLabel.font = [UIFont systemFontOfSize:15];
    self.offBackLabel.textAlignment = NSTextAlignmentRight;
    [self.offBackgroundView addSubview:self.offBackLabel];
    
}

// 滑块设置
- (void)setupThumb
{
    // 滑块视图
    self.thumbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height-CustomHorizontalAdjustment, self.frame.size.height-CustomHorizontalAdjustment)];
    [self.thumbView setBackgroundColor:[UIColor whiteColor]];
    [self.thumbView setUserInteractionEnabled:YES];
    [self.thumbView.layer setCornerRadius:(self.frame.size.height-CustomHorizontalAdjustment)/2];
    [self.thumbView.layer setShadowOffset:CGSizeMake(0, 1)];
    [self.thumbView.layer setShouldRasterize:YES];
    [self.thumbView.layer setShadowOpacity:CustomThumbShadowOpacity];
    [self.thumbView.layer setRasterizationScale:[UIScreen mainScreen].scale];
    [self addSubview:self.thumbView];
    
    // 关闭状态下的滑块位置（默认关闭状态）

    [self.thumbView setCenter:CGPointMake(self.thumbView.frame.size.width/2+CustomSwitchBorderWidth, self.frame.size.height/2)];
    
    // 为滑块添加点击手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwitchTap:)];
    [tapGestureRecognizer setDelegate:self];
    [self.thumbView addGestureRecognizer:tapGestureRecognizer];
    
    // 为滑块添加滑动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panGestureRecognizer setDelegate:self];
    [self.thumbView addGestureRecognizer:panGestureRecognizer];
}

#pragma mark - Accessor
- (BOOL)isOn
{
    return _on;
}

- (void)setOn:(BOOL)on
{
    if (_on != on)
        _on = on;
    
    if (_on)
    {
        [self.onBackgroundView setAlpha:1.0];
        self.offBackgroundView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        
        self.thumbView.center = CGPointMake(self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width+CustomHorizontalAdjustment)/2, self.thumbView.center.y);
    }
    else
    {
        [self.onBackgroundView setAlpha:0.0];
        self.offBackgroundView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        self.thumbView.center = CGPointMake((self.thumbView.frame.size.width+CustomHorizontalAdjustment)/2, self.thumbView.center.y);
    }
}

- (void)setOnTintColor:(UIColor *)color
{
    if (_onTintColor != color)
        _onTintColor = color;
    
    [self.onBackgroundView setBackgroundColor:color];
}

- (void)setOnTintBorderColor:(UIColor *)color
{
    if (_onTintBorderColor != color)
        _onTintBorderColor = color;
    
    [self.onBackgroundView.layer setBorderColor:color.CGColor];
    
    if (color)
        [self.onBackgroundView.layer setBorderWidth:CustomSwitchBorderWidth];
    else
        [self.onBackgroundView.layer setBorderWidth:0.0];
}

- (void)setTintColor:(UIColor *)color
{
    if (_tintColor != color)
        _tintColor = color;
    
    [self.offBackgroundView setBackgroundColor:color];
}

- (void)setTintBorderColor:(UIColor *)color
{
    if (_tintBorderColor != color)
        _tintBorderColor = color;
    
    [self.offBackgroundView.layer setBorderColor:color.CGColor];
    
    if (color)
        [self.offBackgroundView.layer setBorderWidth:CustomSwitchBorderWidth];
    else
        [self.offBackgroundView.layer setBorderWidth:0.0];
}

- (void)setThumbTintColor:(UIColor *)color
{
    if (_thumbTintColor != color)
        _thumbTintColor = color;
    
    [self.thumbView setBackgroundColor:color];
}

// switch 类型
- (void)setShape:(CustomSwitchShape)newShape
{
    if (_shape != newShape)
        _shape = newShape;
    
    if (newShape == CustomSwitchShapeOval)
    {
        [self.onBackgroundView.layer setCornerRadius:self.frame.size.height/2];
        [self.offBackgroundView.layer setCornerRadius:self.frame.size.height/2];
        [self.thumbView.layer setCornerRadius:(self.frame.size.height-CustomHorizontalAdjustment)/2];
    }
    else if (newShape == CustomSwitchShapeRectangle)
    {
        [self.onBackgroundView.layer setCornerRadius:CustomRectShapeCornerRadius];
        [self.offBackgroundView.layer setCornerRadius:CustomRectShapeCornerRadius];
        [self.thumbView.layer setCornerRadius:CustomRectShapeCornerRadius];
    }
    else if (newShape == CustomSwitchShapeRectangleNoCorner)
    {
        [self.onBackgroundView.layer setCornerRadius:0];
        [self.offBackgroundView.layer setCornerRadius:0];
        [self.thumbView.layer setCornerRadius:0];
    }
}

// 设置滑块阴影
- (void)setShadow:(BOOL)showShadow
{
    if (_shadow != showShadow)
        _shadow = showShadow;
    
    if (showShadow)
    {
        [self.thumbView.layer setShadowOffset:CGSizeMake(0, 1)];
        [self.thumbView.layer setShadowRadius:CustomThumbShadowRadius];
        [self.thumbView.layer setShadowOpacity:CustomThumbShadowOpacity];
    }
    else
    {
        [self.thumbView.layer setShadowRadius:0.0];
        [self.thumbView.layer setShadowOpacity:0.0];
    }
}
#pragma mark - Animation
- (void)animateToDestination:(CGPoint)centerPoint withDuration:(CGFloat)duration switch:(BOOL)on
{
    // 更改开状态及关状态的背景alpha，动画滑动到滑块结束位置
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.thumbView.center = centerPoint;
                         
                         if (on)
                         {
                             [self.onBackgroundView setAlpha:1.0];
                             [self.offBackgroundView setAlpha:0.0];
                         }
                         else
                         {
                             [self.onBackgroundView setAlpha:0.0];
                             [self.offBackgroundView setAlpha:1.0];
                         }
                         
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             [self updateSwitch:on];
                         }
                         
                     }];
    
}


#pragma mark - Gesture Recognizers
// 处理滑动手势
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.thumbView];
    
    // 检查目标位置是否合法
    CGPoint newCenter = CGPointMake(recognizer.view.center.x + translation.x,
                                    recognizer.view.center.y);
    if (newCenter.x < (recognizer.view.frame.size.width+CustomHorizontalAdjustment)/2 || newCenter.x > self.onBackgroundView.frame.size.width-(recognizer.view.frame.size.width+CustomHorizontalAdjustment)/2)
    {

        if(recognizer.state == UIGestureRecognizerStateBegan ||
           recognizer.state == UIGestureRecognizerStateChanged)
        {
            CGPoint velocity = [recognizer velocityInView:self.thumbView];
            
            if (velocity.x >= 0)
            {
                // 向右移动
                [self animateToDestination:CGPointMake(self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width+CustomHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:CustomAnimateDuration switch:YES];
            }
            else
            {
                // 向左移动
                [self animateToDestination:CGPointMake((self.thumbView.frame.size.width+CustomHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:CustomAnimateDuration switch:NO];
            }
            
        }
        
        return;
    }
    
    // 只允许水平方向的滑动
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.thumbView];
    
    CGPoint velocity = [recognizer velocityInView:self.thumbView];
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (velocity.x >= 0)
        {
            if (recognizer.view.center.x < self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width+CustomHorizontalAdjustment)/2)
            {
                // 向右移动动画
                [self animateToDestination:CGPointMake(self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width+CustomHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:CustomAnimateDuration switch:YES];
            }
        }
        else
        {
            // 向左移动动画
            [self animateToDestination:CGPointMake((self.thumbView.frame.size.width+CustomHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:CustomAnimateDuration switch:NO];
        }
    }
}

// 处理滑块点击事件
- (void)handleSwitchTap:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (self.isOn)
        {
            // 向左动画
            [self animateToDestination:CGPointMake((self.thumbView.frame.size.width+CustomHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:CustomAnimateDuration switch:NO];
        }
        else
        {
            // 向右动画
            [self animateToDestination:CGPointMake(self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width+CustomHorizontalAdjustment)/2, recognizer.view.center.y) withDuration:CustomAnimateDuration switch:YES];
        }
    }
}

// 处理背景点击事件
- (void)handleBgTap:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (self.isOn)
        {
            // 向左动画
            [self animateToDestination:CGPointMake((self.thumbView.frame.size.width+CustomHorizontalAdjustment)/2, self.thumbView.center.y) withDuration:CustomAnimateDuration switch:NO];
        }
        else
        {
            // 向右动画
            [self animateToDestination:CGPointMake(self.onBackgroundView.frame.size.width - (self.thumbView.frame.size.width+CustomHorizontalAdjustment)/2, self.thumbView.center.y) withDuration:CustomAnimateDuration switch:YES];
        }
    }
}

#pragma mark - 更新开关状态
- (void)updateSwitch:(BOOL)on
{
    if (_on != on)
        _on = on;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


@end
