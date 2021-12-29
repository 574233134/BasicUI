//
//  UIBezierPathDisplay.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "UIBezierPathDisplay.h"
#import "BasicUIDemo.h"
#import "PentagonView.h"
#import "PentagonFillView.h"
#import "RectFillView.h"
#import "CircleView.h"
#import "RoundRectView.h"
#import "ARCView.h"
@interface UIBezierPathDisplay ()

@property (strong, nonatomic) UIScrollView *scrollerView;

@end

@implementation UIBezierPathDisplay

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubViews];
}

- (void)creatSubViews
{
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NARBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NARBARHEIGHT)];
    self.scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH * 6, SCREEN_HEIGHT-NARBARHEIGHT);
    self.scrollerView.pagingEnabled = YES;
     [self.view addSubview:self.scrollerView];
    
    PentagonView *pentagonView = [[PentagonView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NARBARHEIGHT)];
    [self.scrollerView addSubview:pentagonView];
    
    PentagonFillView *pentagonFillView = [[PentagonFillView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NARBARHEIGHT)];
    [self.scrollerView addSubview:pentagonFillView];
    
    RectFillView *rectFillView = [[RectFillView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NARBARHEIGHT)];
    [self.scrollerView addSubview:rectFillView];
    
    CircleView *circleView = [[CircleView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NARBARHEIGHT)];
    [self.scrollerView addSubview:circleView];
    
    RoundRectView *roundRectView = [[RoundRectView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*4, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NARBARHEIGHT)];
    [self.scrollerView addSubview:roundRectView];
    
    ARCView *arcView = [[ARCView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*5, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NARBARHEIGHT)];
    [self.scrollerView addSubview:arcView];
    
}

@end
