//
//  MJDIYAutoFooter.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/12.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "MJDIYAutoFooter.h"

@interface MJDIYAutoFooter()

@property (weak, nonatomic) UILabel *label;

@property (weak, nonatomic) UISwitch *s;

@property (weak, nonatomic) UIActivityIndicatorView *loading;

@end

@implementation MJDIYAutoFooter

#pragma mark - 重写方法
/** 在这里做一些初始化配置（比如添加子控件）*/
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
    
    // 开关
    UISwitch *s = [[UISwitch alloc] init];
    [self addSubview:s];
    self.s = s;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

/** 设置子控件的位置和尺寸 */
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    self.s.center = CGPointMake(self.mj_w - 20, self.mj_h - 20);
    
    self.loading.center = CGPointMake(30, self.mj_h * 0.5);
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

/**  监听控件的刷新状态 */
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"上拉上拉上拉(开关无用)";
            [self.loading stopAnimating];
            [self.s setOn:NO animated:YES];
            break;
        case MJRefreshStateRefreshing:
            [self.s setOn:YES animated:YES];
            self.label.text = @"加载加载加载(开关无用)";
            [self.loading startAnimating];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"没有更多数据(开关无用)";
            [self.s setOn:NO animated:YES];
            [self.loading stopAnimating];
            break;
        default:
            break;
    }
}


@end
