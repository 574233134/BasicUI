//
//  SystemNavigationTest.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/15.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "SystemNavigationTest.h"
#import "NewViewController.h"
#import "NavigationBarConfigViewController.h"
#import "ToolBarConfigViewController.h"
#import "NavigationItemTestViewController.h"
#import "LmkInteractiveTransitioning.h"
@interface SystemNavigationTest ()<UITextFieldDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UISwitch *showNavigationBarSwitch;


@property (strong, nonatomic) IBOutlet UISwitch *showToolBarSwitch;


@property (strong, nonatomic) IBOutlet UISwitch *opaqueSwitch;

@property (strong, nonatomic) IBOutlet UITextField *textfield;

@property (strong, nonatomic) LmkInteractiveTransitioning *interactiveTransitioning;


@end

@implementation SystemNavigationTest

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"系统导航栏";
    
    self.view.backgroundColor = [UIColor cyanColor];
    [self.showNavigationBarSwitch setOn: self.navigationController.navigationBar.hidden];
    [self.showToolBarSwitch setOn: self.navigationController.toolbar.hidden];
    self.opaqueSwitch.on = self.navigationController.navigationBar.isOpaque;
    self.interactiveTransitioning = [[LmkInteractiveTransitioning alloc]initWithTransitionType:LMKInteractiveTransitionTypePush GestureDirection:LMKInteractiveTransitionGestureDirectionLeft];
    typeof(self)weakSelf = self;
    _interactiveTransitioning.pushConifg = ^(){
        [weakSelf pushToNewVC:nil];
    };
    
    //此处传入self.navigationController， 不传入self，因为self.view要形变，否则手势百分比算不准确；
    [_interactiveTransitioning addPanGestureForViewController:self];
    
    self.navigationController.delegate = self;
}

- (void)clickToolBarItem
{
    NSLog(@"点击了toobarItem");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:_showNavigationBarSwitch.on animated:YES];
    [self.navigationController setToolbarHidden:_showToolBarSwitch.on animated:YES];
    [self.navigationController.navigationBar setOpaque:_opaqueSwitch.on];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController setToolbarHidden:YES animated:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

// push到新的视图控制器
- (IBAction)pushToNewVC:(UIButton *)sender
{
    NewViewController *testVC = [NewViewController new];
    [self.navigationController pushViewController:testVC animated:YES];

}

// pop 当前视图控制器
- (IBAction)popCurrentVC:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

// pop到navigationController的根视图控制器
- (IBAction)popToRootVC:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// pop到特定位置的VC
- (IBAction)popToSpecificVC:(UIButton *)sender
{
    NSArray *array = self.navigationController.viewControllers; // 获取navigationController 管理的所有视图控制器
    if (array!=nil && array.count>0)
    {
         [self.navigationController popToViewController:array[1] animated:YES];
    }
}

// 改变导航栏背景色
- (IBAction)changeSearchBarBG:(UIButton *)sender
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}

// 改变标题颜色
- (IBAction)changeTitleColor:(UIButton *)sender
{
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

// 是否展示导航栏
- (IBAction)isShowNAvigationBar:(UISwitch *)sender
{
    [self.navigationController setNavigationBarHidden:sender.on animated:YES];
}

// 是否展示工具栏
- (IBAction)isShowToolBar:(UISwitch *)sender
{
    [self.navigationController setToolbarHidden:sender.on animated:YES];
}

// 导航栏是否透明
- (IBAction)isOpaque:(UISwitch *)sender
{
    self.navigationController.navigationBar.opaque = sender.on;
    self.navigationController.toolbar.opaque = sender.on;
}

// 改变navigftionBarItem 颜色
- (IBAction)changeBarItemColor:(UIButton *)sender
{
    [self.navigationController.navigationBar setTintColor:[UIColor greenColor]];
}

// 导航栏及工具栏 是否根据点击手势隐藏或展示
// 当用户滑动时，导航控制器的导航栏和工具栏将被隐藏或显示。工具栏只有在有item时才会响应该手势。
- (IBAction)isusedTapGesture:(UISwitch *)sender
{
    self.navigationController.hidesBarsOnTap = sender.on;
}

// 当键盘出现时，导航控制器的导航栏工具栏将被隐藏。当键盘消失时，它们仍会隐藏 可以配合单击或轻扫手势一起使用
- (IBAction)isHiddenBarWhenKeyBoaryAppear:(UISwitch *)sender
{
    self.navigationController.hidesBarsWhenKeyboardAppears = sender.on;
}

 // 当导航栏的垂直size比较紧凑的时候，导航栏是否自动隐藏
- (IBAction)isBArHiddenWhenSizeCompactness:(UISwitch *)sender
{
    self.navigationController.hidesBarsWhenVerticallyCompact = sender.on;
}

// 查看NavigationBar属性
- (IBAction)navigationBarProperty:(UIButton *)sender
{
    NavigationBarConfigViewController *navigationBarConfig = [NavigationBarConfigViewController new];
    navigationBarConfig.title = @"navigationBar属性";
    [self.navigationController pushViewController:navigationBarConfig animated:YES];
}

- (IBAction)toolBarProperty:(UIButton *)sender
{
    ToolBarConfigViewController *toolBarConfig = [[ToolBarConfigViewController alloc]init];
    toolBarConfig.title = @"toolBar属性";
    [self.navigationController pushViewController:toolBarConfig animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)learnNavigationItem:(UIButton *)sender
{
    NavigationItemTestViewController *itemController = [[NavigationItemTestViewController alloc]init];
    [self.navigationController pushViewController:itemController animated:YES];
}

#pragma mark - navigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"即将展示：%@",NSStringFromClass([viewController class]));
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"已经展示：%@",NSStringFromClass([viewController class]));
}

// 屏幕旋转时，navigationController 支持的方向，多选
- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    return UIInterfaceOrientationMaskAll;
}

/** 子控制器支持的方向
 * UIInterfaceOrientation 枚举类型
 *  1. UIInterfaceOrientationUnknown 设备的朝向不能确定。
 *  2. UIInterfaceOrientationPortrait  该设备处于竖屏模式，设备保持直立，底部的Home键。
 *  3. UIInterfaceOrientationPortraitUpsideDown 该设备处于竖屏模式，但上下颠倒，设备保持直立，顶部的Home键。
 *  4. UIInterfaceOrientationLandscapeLeft 设备处于横向模式，设备保持直立，右侧Home键。
 *  5. UIInterfaceOrientationLandscapeRight 该设备处于横向模式，设备保持直立，左侧Home键。
 */
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController
{
    return UIInterfaceOrientationPortrait;
}

 // 自定义 切换 交互式
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return self.interactiveTransitioning;
}

// 自定义 切换 动画
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    return nil;
}

@end
