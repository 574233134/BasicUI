//
//  SegmentControlBasic.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/4.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "SegmentControlBasic.h"

@interface SegmentControlBasic ()

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;


@end

@implementation SegmentControlBasic

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"分段控制器基础";
}


#pragma mark - xib action

/**  */
- (IBAction)insertTitleSegment:(UIButton *)sender
{
    NSString *title = [NSString stringWithFormat:@"%u",self.segmentControl.numberOfSegments];
    [self.segmentControl insertSegmentWithTitle:title atIndex:self.segmentControl.numberOfSegments animated:YES];
}

- (IBAction)insertImageSegment:(UIButton *)sender
{
    UIImage *image = [[UIImage imageNamed:[NSString stringWithFormat:@"segment"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self .segmentControl insertSegmentWithImage:image atIndex:self.segmentControl.numberOfSegments animated:YES];
}

- (IBAction)deleteOneSegment:(UIButton *)sender
{
    [self.segmentControl removeSegmentAtIndex:self.segmentControl.numberOfSegments-1 animated:YES];
}

- (IBAction)deleteAllSegment:(UIButton *)sender
{
    [self.segmentControl removeAllSegments];
}

- (IBAction)setSegmentTitle:(UIButton *)sender
{
    [self.segmentControl setTitle:@"title" forSegmentAtIndex:0];
}

- (IBAction)setSegmentWidth:(UIButton *)sender
{
    [self.segmentControl setWidth:50 forSegmentAtIndex:0];
}

- (IBAction)setOneSegmentOffset:(UIButton *)sender
{
    [self.segmentControl setContentOffset:CGSizeMake(5, 5) forSegmentAtIndex:0];
}

- (IBAction)segmentIsAllowUserInteraction:(UIButton *)sender
{
    [self.segmentControl setEnabled:NO forSegmentAtIndex:0];
}

- (IBAction)setSegmentControlBGImage:(UIButton *)sender
{
    [self.segmentControl setBackgroundImage:[UIImage imageNamed:@"searchBarBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}


- (IBAction)setSpector:(UIButton *)sender
{
    [self.segmentControl setDividerImage:[UIImage imageNamed:@"sperector"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (IBAction)setTitleAttribute:(UIButton *)sender
{
    
    // 设置选择按钮视图的标题样式为20号橘色空心的系统字体
    NSDictionary *attributeDic = @{NSFontAttributeName : [UIFont systemFontOfSize:20] , NSStrokeColorAttributeName : [UIColor orangeColor] , NSStrokeWidthAttributeName : @(3)};

    [self.segmentControl setTitleTextAttributes:attributeDic forState:UIControlStateNormal];
}


@end
