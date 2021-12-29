//
//  ViewControllerChildVC.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/24.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ViewControllerChildVC.h"
#import "FirstChildViewController.h"
#import "SecendChildViewController.h"
#import "ThirdChildViewController.h"
#import "BasicUIDemo.h"
@interface ViewControllerChildVC ()

@property (nonatomic, strong) FirstChildViewController *firstVC;
@property (nonatomic, strong) SecendChildViewController *secondVC;
@property (nonatomic, strong) ThirdChildViewController *thirdVC;
@property (nonatomic, strong) UIViewController *currentVC;

@property (nonatomic, strong) UIScrollView *headScrollView;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) UIView *contentView;


@end

@implementation ViewControllerChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"子视图";
    [self loadData];
    [self loadBaseUI];
}

- (void)loadData
{
    self.itemArray = [NSMutableArray arrayWithObjects:@"消息",@"我的",@"设置", nil];
}

- (void)loadBaseUI
{
    self.headScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NARBARHEIGHT, [UIScreen mainScreen].bounds.size.width, 44)];
    self.headScrollView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    for (int i = 0; i<self.itemArray.count; i++) {
        UIButton *itemButton = [[UIButton alloc]initWithFrame:CGRectMake(i*([UIScreen mainScreen].bounds.size.width/self.itemArray.count), 0, [UIScreen mainScreen].bounds.size.width/self.itemArray.count, 44)];
        itemButton.tag = 100+i;
        itemButton.backgroundColor = [UIColor clearColor];
        NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor purpleColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
        [itemButton setAttributedTitle:[[NSAttributedString alloc]initWithString:self.itemArray[i] attributes:dic] forState:UIControlStateNormal];
        [itemButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headScrollView addSubview:itemButton];
    }
    
    [self.headScrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 44)];
    self.headScrollView.showsHorizontalScrollIndicator = NO;
    self.headScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.headScrollView];
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 44+NARBARHEIGHT, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44 - NARBARHEIGHT)];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentView];
    
   
    
    [self addSubControllers];
}

#pragma mark - privatemethods
- (void)addSubControllers
{
    self.firstVC = [[FirstChildViewController alloc]init];
    [self addChildViewController:self.firstVC];
    [self.firstVC didMoveToParentViewController:self];
    
    self.secondVC = [[SecendChildViewController alloc]init];
    [self addChildViewController:self.secondVC];
    [self.secondVC didMoveToParentViewController:self];
    
    self.thirdVC = [[ThirdChildViewController alloc]init];
    [self addChildViewController:self.thirdVC];
    [self.thirdVC didMoveToParentViewController:self];
    
    //调整子视图控制器的Frame已适应容器View
    [self fitFrameForChildViewController:self.firstVC];
    //设置默认显示在容器View的内容
    [self.contentView addSubview:self.firstVC.view];
    
    NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));
    NSLog(@"%@",NSStringFromCGRect(self.firstVC.view.frame));
    
    self.currentVC = self.firstVC;
}

- (void)buttonClick:(UIButton *)sender
{
    if ((sender.tag == 100 && self.currentVC == self.firstVC) || (sender.tag == 101 && self.currentVC == self.secondVC) || (sender.tag == 102 && self.currentVC == self.thirdVC)) {
        return;
    }
    switch (sender.tag) {
        case 100:{
            [self fitFrameForChildViewController:self.firstVC];
            [self transitionFromOldViewController:self.currentVC toNewViewController:self.firstVC];
        }
            break;
        case 101:{
            [self fitFrameForChildViewController:self.secondVC];
            [self transitionFromOldViewController:self.currentVC toNewViewController:self.secondVC];
        }
            break;
        case 102:{
            [self fitFrameForChildViewController:self.thirdVC];
            [self transitionFromOldViewController:self.currentVC toNewViewController:self.thirdVC];
        }
            break;
    }
}

- (void)fitFrameForChildViewController:(UIViewController *)chileViewController
{
    CGRect frame = self.contentView.frame;
    frame.origin.y = 0;
    chileViewController.view.frame = frame;
}

// 转换子视图控制器的位置
- (void)transitionFromOldViewController:(UIViewController *)oldViewController toNewViewController:(UIViewController *)newViewController{
    __weak typeof(self) weekself = self;
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newViewController didMoveToParentViewController:self];
            weekself.currentVC = newViewController;
        }else{
            weekself.currentVC = oldViewController;
        }
    }];
}

// 移除所有子视图控制器
- (void)removeAllChildViewControllers
{
    for (UIViewController *vc in self.childViewControllers)
    {
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
}


@end
