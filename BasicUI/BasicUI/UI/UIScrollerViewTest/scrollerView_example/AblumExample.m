//
//  AblumExample.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/22.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "AblumExample.h"
#import "BasicUIDemo.h"
#import "ImageScrollerView.h"
@interface AblumExample ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;

@property (strong, nonatomic) UIImageView *currentPhoto;

@end

@implementation AblumExample

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"相册浏览";
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentPhoto = [[UIImageView alloc]init];
    [self creatSubView];
}

- (void)creatSubView
{
    self.scrollerView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scrollerView.backgroundColor = [UIColor blackColor];
    self.scrollerView.delegate  = self;
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH*8, self.view.frame.size.width);
    [self.view addSubview:self.scrollerView];
    int tmpwidth = 0;
    for (int i=0; i<8; i++)
    {
        ImageScrollerView *imageScroller = [[ImageScrollerView alloc]initWithFrame:CGRectMake(0+tmpwidth, 0, SCREEN_WIDTH, self.view.frame.size.height)];
        imageScroller.tag = i;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"miao%d",i]];
        imageScroller.imageView.image = image;
        [self.scrollerView addSubview:imageScroller];
        tmpwidth += SCREEN_WIDTH;

    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    static int pre = 0;
    int current = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    ImageScrollerView *imgScrollView = (ImageScrollerView *)[scrollView viewWithTag:pre];
    if (current != pre && imgScrollView.zoomScale > 1)
    {
        imgScrollView.zoomScale = 1;
    }
    pre = current;
}


@end
