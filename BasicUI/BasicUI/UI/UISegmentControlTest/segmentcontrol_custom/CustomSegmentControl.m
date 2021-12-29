//
//  CustomSegmentControl.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/6.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomSegmentControl.h"
#import "LMKSegement.h"
#import "BasicUIDemo.h"
@interface CustomSegmentControl ()<CustomSegmentDelegate>
@property (strong, nonatomic)LMKSegement *segmentView;
@end
@implementation CustomSegmentControl

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"简单自定义segment";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatCustomSegment];
}

- (void)creatCustomSegment
{
    self.view.backgroundColor = UIColorFromRGB(0xeeeeee);
    _segmentView = [[LMKSegement alloc]initWithFrame:CGRectMake((self.view.frame.size.width-300)/2, 100, 300, 40)];
    _segmentView.delegate = self;
    [_segmentView setSegmentWithBackground:[UIColor whiteColor] titleArray:@[@"主页",@"我的"] titleFont:[UIFont systemFontOfSize:14] titleLineSelectColor:[UIColor redColor] normal:[UIColor blackColor] withselectedIndex:0];
    [_segmentView setRightTopLabelWithAry:@[@"1",@"2"]];
    [self.view addSubview:_segmentView];
}

- (void)customSegmentedValueChanged:(UISegmentedControl *)segment
{
   NSLog(@"点击button----%ld",segment.selectedSegmentIndex);
   
    
}
@end
