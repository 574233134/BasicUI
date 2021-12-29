//
//  ScrollerViewZoomFounction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/22.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ScrollerViewZoomFounction.h"
#import "BasicUIDemo.h"
@interface ScrollerViewZoomFounction () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;

@property (strong, nonatomic) UIImageView *photoDisplay;

@end

@implementation ScrollerViewZoomFounction

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"缩放代理方法";
    [self creatSubView];
}

- (void)creatSubView
{
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height)];
    self.scrollerView.backgroundColor = [UIColor whiteColor];
    self.scrollerView.delegate = self;
    self.scrollerView.minimumZoomScale = 0.5; // 最小缩放倍数
    self.scrollerView.maximumZoomScale = 2;// 最大缩放倍数
    self.scrollerView.multipleTouchEnabled = YES; // 是否允许多点触碰
    self.scrollerView.bouncesZoom = YES; // 缩放时，是否存在反弹效果，默认yes
    [self.view addSubview:self.scrollerView];
    self.scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH ,self.view.frame.size.height);
    
    self.photoDisplay = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"miao1"]];
    self.photoDisplay.frame = self.scrollerView.frame;
    [self.scrollerView addSubview:self.photoDisplay];
}

#pragma mark - UIScrollView Delegate
// 返回一个放大或者缩小的视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.photoDisplay;
}
// 开始放大或者缩小
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"scrollViewWillBeginZooming");
}

// 缩放结束时
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
   NSLog(@"scrollViewDidEndZooming : %.2lf", scale);
}

// 视图已经放大或缩小
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidZoom");
    
    // 默认是以左上角为基准缩放，下面代码让图片中心不变进行缩放
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentInset.left - scrollView.contentInset.right - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom - scrollView.contentSize.height) * 0.5, 0.0);
    
    self.photoDisplay.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                        scrollView.contentSize.height * 0.5 + offsetY);
    
}

@end
