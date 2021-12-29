//
//  ScrollerViewShufflingFigure.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/23.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ScrollerViewShufflingFigure.h"

@interface ScrollerViewShufflingFigure ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;

@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) UIImageView *imgLeft;

@property (strong, nonatomic) UIImageView *imgCenter;

@property (strong, nonatomic) UIImageView *imgRight;

@property (strong, nonatomic) NSMutableArray *imgDataArray;

@property (assign, nonatomic) NSInteger currentImgIndex;

@property (assign, nonatomic) NSInteger imgCount;

@property (weak) NSTimer *timer;

@end

@implementation ScrollerViewShufflingFigure

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"轮播图";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubViews];
    
}

- (void)loadData
{
    self.currentImgIndex = 0;
    self.imgDataArray = [NSMutableArray array];
    for (int i= 0; i<8; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"miao%d",i]];
        [self.imgDataArray addObject:image];
    }
    self.imgCount = self.imgDataArray.count;
}

- (void)creatSubViews
{
    [self loadData];
    [self creatScrollerView];
    [self addImageviewsToScroller];
    [self creatPageControl];
    [self setupTimer];
}

- (void)creatScrollerView
{
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    self.scrollerView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height-64);
    self.scrollerView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    self.scrollerView.delegate = self;
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    self.scrollerView.decelerationRate = 1.0;
    [self.view addSubview:self.scrollerView];
}

-(void)addImageviewsToScroller
{
    
    self.imgLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.imgLeft.image = self.imgDataArray[(self.currentImgIndex-1+self.imgCount)%self.imgCount];
    self.imgLeft.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollerView addSubview:self.imgLeft];
    
    self.imgCenter = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    /** 设置内容模式  保证图片不失真 */
    self.imgCenter.contentMode = UIViewContentModeScaleAspectFit;
    self.imgCenter.image = self.imgDataArray[self.currentImgIndex];
    [self.scrollerView addSubview:self.imgCenter];
    
    self.imgRight = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.imgRight.contentMode = UIViewContentModeScaleAspectFit;
    self.imgRight.image = self.imgDataArray[(self.currentImgIndex+1)%self.imgCount];
    [self.scrollerView addSubview:self.imgRight];
    
}

- (void)creatPageControl
{
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.frame = CGRectMake((self.view.frame.size.width-100)/2,self.view.frame.size.height-150 , 100, 50);
    self.pageControl.numberOfPages = self.imgCount;
    
    /** 未选中时pagecontrol的颜色 */
    self.pageControl.pageIndicatorTintColor = [UIColor cyanColor];
   
    /** 设置选中时pagecontrol的颜色 */
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
   
    /** 设置pagecontrol不允许与用户交互 */
    self.pageControl.userInteractionEnabled = NO;
    
    /** 设置pagecontrol的当前选中索引 */
    self.pageControl.currentPage = self.currentImgIndex;
    
    [self.view addSubview:self.pageControl];
}

- (void)reloadImage
{
    NSInteger index = self.scrollerView.contentOffset.x/self.scrollerView.frame.size.width;

    if (index == 0)
    {
        self.currentImgIndex--;
        if (self.currentImgIndex <0 )
        {
            self.currentImgIndex = self.imgCount-1;
        }
        self.imgRight.image = self.imgCenter.image;
        self.imgCenter.image = self.imgLeft.image;
        self.scrollerView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollerView.frame) * 1, 0);
        [self.imgLeft setImage:self.imgDataArray[(self.currentImgIndex-1+self.imgCount)%self.imgCount]];
        self.pageControl.currentPage = self.currentImgIndex;
    }
    else if(index == 2)
    {
        self.currentImgIndex++;
        if (self.currentImgIndex == self.imgCount)
        {
            self.currentImgIndex = 0;
        }
        self.imgLeft.image = self.imgCenter.image;
        self.imgCenter.image = self.imgRight.image;
        self.scrollerView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollerView.frame) * 1, 0);
        [self.imgRight setImage:self.imgDataArray[(self.currentImgIndex+1)%self.imgCount]];
        
        self.pageControl.currentPage = self.currentImgIndex;
    }
}

/** 设置定时器 */
-(void)setupTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
    
}

/**  定时器时间到了之后的回调函数（用于更新image信息） */
-(void)timeChanged
{
    self.currentImgIndex++;
    if (self.currentImgIndex == self.imgCount)
    {
        self.currentImgIndex = 0;
    }
    /** 注意：设置动画的时间要小于滑动的时间 */
    __weak typeof(self) weekself = self;
    [UIView animateWithDuration:0.5 animations:^{
        
        self.scrollerView.contentOffset =CGPointMake(CGRectGetWidth(self.scrollerView.frame) * 2, 0);
    } completion:^(BOOL finished) {
        
        /**
         * 滑动完成后，把当前现实的imageview重新移动回中间位置，此处不能使用动画，用户感觉不到
         * 移动前,先把中间imageview的image设置成当前现实的iamge
         */
        self.imgLeft.image = self.imgCenter.image;
        self.imgCenter.image = self.imgRight.image;
        self.scrollerView.contentOffset =CGPointMake(CGRectGetWidth(self.scrollerView.frame) * 1, 0);
        [self.imgRight setImage:weekself.imgDataArray[(weekself.currentImgIndex+1)%weekself.imgCount]];
        
    }];
    self.pageControl.currentPage = self.currentImgIndex;
}

#pragma mark - scrollerView Delegate
/** 只有用手滑动时才会走该方法 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadImage];
    
}

/** 开始拖动时停止使用定时器 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

/** 结束拖动时重新启动定时器 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}
@end
