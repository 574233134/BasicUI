//
//  MJDIYBackFooter.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/12.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "MJDIYBackFooter.h"

@interface MJDIYBackFooter()

@property (weak, nonatomic) UILabel *label;

@property (weak, nonatomic) UISwitch *s;

@property (weak, nonatomic) UIImageView *logo;

@property (weak, nonatomic) UIActivityIndicatorView *loading;

@end

@implementation MJDIYBackFooter

- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    // 装饰开关
    UISwitch *s = [[UISwitch alloc] init];
    [self addSubview:s];
    self.s = s;
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    
    self.logo.bounds = CGRectMake(0, 0, self.bounds.size.width, 100);
    self.logo.center = CGPointMake(self.mj_w * 0.5, self.mj_h + self.logo.mj_h * 0.5);
    
    self.loading.center = CGPointMake(self.mj_w - 30, self.mj_h * 0.5);
}

/** 监听scrollView的contentOffset改变 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

/** 监听scrollView的contentSize改变 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

/** 监听scrollView的拖拽状态改变 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

/** 监听控件的刷新状态 */
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            [self.s setOn:NO animated:YES];
            self.label.text = @"上拉上拉上拉(装饰开关)";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            [self.s setOn:YES animated:YES];
            self.label.text = @"放开放开放开(装饰开关)";
            break;
        case MJRefreshStateRefreshing:
            [self.loading startAnimating];
            [self.s setOn:YES animated:YES];
            self.label.text = @"加载加载加载(装饰开关)";
            break;
        case MJRefreshStateNoMoreData:
            [self.loading stopAnimating];
            self.label.text = @"没数据了(装饰开关)";
            [self.s setOn:NO animated:YES];
        default:
            break;
    }
}

/** 监听拖拽比例（控件被拖出来的比例）*/
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
