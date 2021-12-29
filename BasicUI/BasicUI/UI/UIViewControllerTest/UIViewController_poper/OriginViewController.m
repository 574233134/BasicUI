//
//  OriginViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/24.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "OriginViewController.h"
#import "PoperViewControllerTest.h"
#import "PoperViewControllerTwo.h"
@interface OriginViewController ()<PoperViewControllerTestDelegate,PoperViewControllerTwoDelegate,UIPopoverPresentationControllerDelegate>

@property (strong,nonatomic)UIPopoverPresentationController *popoverPresentVC;//声明模态弹出窗控制器
@property (strong, nonatomic)UIButton *poperBtn;
@property (strong, nonatomic)UIButton *poperBtnTwo;

@end

@implementation OriginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self creatBtn];
}

- (void)creatBtn
{
    self.poperBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 60, 40)];
    self.poperBtn.backgroundColor = [UIColor purpleColor];
    [self.poperBtn setTitle:@"poper" forState:UIControlStateNormal];
    [self.poperBtn addTarget:self action:@selector(Open:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.poperBtn];
    
    self.poperBtnTwo = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 80, 40)];
    self.poperBtnTwo.backgroundColor = [UIColor purpleColor];
    [self.poperBtnTwo setTitle:@"poperTwo" forState:UIControlStateNormal];
    [self.poperBtnTwo addTarget:self action:@selector(poper2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.poperBtnTwo];
    
    
}

#pragma mark - 打开弹窗
-(void)Open:(UIButton *)sender
{
    NSArray *array = @[@"首页",@"我的",@"测试"];
    PoperViewControllerTest *contentVC = [[PoperViewControllerTest alloc]init];
    contentVC.modalPresentationStyle = UIModalPresentationPopover;
    // 气泡视图方向
    contentVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    contentVC.popoverPresentationController.sourceView = self.poperBtn;
    contentVC.popoverPresentationController.sourceRect = self.poperBtn.bounds;
    contentVC.popoverPresentationController.delegate = self;
    contentVC.delegate = self;
    [contentVC loadCustomViewWithData:array];
    [self presentViewController:contentVC animated:YES completion:nil];
}

- (void)poper2
{
    NSArray *array = @[@"首页",@"我的",@"测试"];
    PoperViewControllerTwo *poperTwoVC = [PoperViewControllerTwo sharedInstance];
    // 需要通过 sourceView 来判断位置的
    poperTwoVC.popoverPresentationController.sourceView = self.poperBtnTwo;
    poperTwoVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    // 指定箭头所指区域的矩形框范围（位置和尺寸）,以sourceView的左上角为坐标原点
    poperTwoVC.popoverPresentationController.sourceRect = self.poperBtnTwo.bounds;
    // 设置代理
    poperTwoVC.popoverPresentationController.delegate = self;
    poperTwoVC.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    poperTwoVC.delegate = self;
    [self presentViewController:poperTwoVC animated:YES completion:nil];
    poperTwoVC.dataList = [NSMutableArray arrayWithArray:array];
    [poperTwoVC reloadData];
}


#pragma mark - UIPopoverPresentationController Delegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone; //不适配
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    return YES; //点击蒙版popover消失， 默认YES
}

#pragma mark - PoperViewControllerTestDelegate
- (void)actionViewClickedButtonAtIndex:(NSInteger)buttonIndex title:(NSString *)title
{
    NSString *message = [NSString stringWithFormat:@"点击了第%lu个，数据为%@",buttonIndex,title];
    NSLog(@"poper1:%@",message);
}

#pragma mark - PoperViewControllerTwoDelegate
- (void)selectAtIndex:(NSIndexPath *)indexPath data:(NSString *)data
{
    NSString *message = [NSString stringWithFormat:@"点击了第%lu个，数据为%@",indexPath.section*4+indexPath.row,data];
    NSLog(@"poper2:%@",message);
}


@end
