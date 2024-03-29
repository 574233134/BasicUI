//
//  ViewControllerLifeCircle.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/24.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ViewControllerLifeCircle.h"

@interface ViewControllerLifeCircle ()

@end

@implementation ViewControllerLifeCircle

// 非storyBoard(xib或非xib)都走这个方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"%s", __FUNCTION__);
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
    }
    return self;
}

// 如果连接了串联图storyBoard 走这个方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"%s", __FUNCTION__);
    if (self = [super initWithCoder:aDecoder])
    {
        
    }
    return self;
}

- (instancetype)init
{
    NSLog(@"%s", __FUNCTION__);
    if (self = [super init])
    {
        
    }
    return self;
}

// xib 加载 完成
- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"%s", __FUNCTION__);
}

// 加载视图(默认从nib)
- (void)loadView
{
    NSLog(@"%s", __FUNCTION__);
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
}

//视图控制器中的视图加载完成，viewController自带的view加载完成
- (void)viewDidLoad
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLoad];
}


//视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [super viewWillAppear:animated];
}

// view 即将布局其 Subviews
- (void)viewWillLayoutSubviews
{
    NSLog(@"%s", __FUNCTION__);
    [super viewWillLayoutSubviews];
}

// view 已经布局其 Subviews
- (void)viewDidLayoutSubviews
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLayoutSubviews];
}

//视图已经出现
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidAppear:animated];
}

//视图将要消失
- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [super viewWillDisappear:animated];
}

//视图已经消失
- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidDisappear:animated];
}

//出现内存警告  //模拟内存警告:点击模拟器->hardware-> Simulate Memory Warning
- (void)didReceiveMemoryWarning
{
    NSLog(@"%s", __FUNCTION__);
    [super didReceiveMemoryWarning];
}

// 视图被销毁
- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

@end
