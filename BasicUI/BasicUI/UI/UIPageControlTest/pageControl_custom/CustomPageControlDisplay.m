//
//  CustomPageControlDisplay.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/27.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomPageControlDisplay.h"
#import "CustomPageControl.h"
#import "BasicUIDemo.h"
@interface CustomPageControlDisplay ()
@property (strong, nonatomic)CustomPageControl *pageControl;
@end

@implementation CustomPageControlDisplay

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义pageControl";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatCustomPageControl];
}
 
- (void)creatCustomPageControl
{
    self.pageControl = [[CustomPageControl alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 100)];
    self.pageControl.backgroundColor = [UIColor blackColor];
    self.pageControl.numberOfPages = 6;
    self.pageControl.currentPage = 0;
    self.pageControl.inactiveImage = [UIImage imageNamed:@"indicator"];
    self.pageControl.inactiveImageSize = CGSizeMake(50, 50);
    self.pageControl.currentImage = [UIImage imageNamed:@"current"];
    self.pageControl.currentImageSize = CGSizeMake(30, 30);
    
    [self.view addSubview:self.pageControl];
    
    [self.pageControl addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click
{
    [self.pageControl setCurrentPage: self.pageControl.currentPage];
    NSLog(@"%ld",(long)self.pageControl.currentPage);
}


@end
