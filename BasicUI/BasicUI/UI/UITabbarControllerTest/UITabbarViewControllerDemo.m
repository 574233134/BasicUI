//
//  UITabbarViewControllerDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/19.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "UITabbarViewControllerDemo.h"
#import "TabbarViewControllers/HomeViewController.h"
#import "TabbarViewControllers/CategoryViewController.h"
#import "TabbarViewControllers/FinderViewController.h"
#import "TabbarViewControllers/ShoppingCartViewController.h"
#import "TabbarViewControllers/MineViewController.h"
#import "TabbarViewControllers/SettingViewController.h"
#import "LMKScaleTransition.h"
#import "CustomTabbarController/CustomTabBarController.h"
@interface UITabbarViewControllerDemo ()<UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate>

@property (strong,nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation UITabbarViewControllerDemo


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"BasicUI";
    [self.navigationController setToolbarHidden:YES];
    self.view.backgroundColor =[UIColor whiteColor];
    [self initDataArray];
    [self creatTableView];
}

- (void)initDataArray
{
    self.dataArray = [NSArray arrayWithObjects:@"SystemTabbarVC", @"CustomTabbarVC",nil];
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            [self presentSystemTabbarVC];
        }
            break;
        case 1:
        {
            [self presentCustomTabBarVC];
        }
        default:
            break;
    }
}

- (void)presentSystemTabbarVC
{
    HomeViewController *homeVc = [[HomeViewController alloc]init];
    CategoryViewController *categoryVC = [[CategoryViewController alloc]init];
    FinderViewController *findVC = [[FinderViewController alloc]init];
    ShoppingCartViewController *shopCartVC = [[ShoppingCartViewController alloc]init];
    MineViewController *mineVC =[[MineViewController alloc]init];
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVc];
    UINavigationController *categoryNav = [[UINavigationController alloc]initWithRootViewController:categoryVC];
    UINavigationController *finderNav = [[UINavigationController alloc]initWithRootViewController:findVC];
    UINavigationController *shopCartNav = [[UINavigationController alloc]initWithRootViewController:shopCartVC];
    UINavigationController *mineNav = [[UINavigationController alloc]initWithRootViewController:mineVC];
    UINavigationController *settingNav = [[UINavigationController alloc]initWithRootViewController:settingVC];
    
    
    homeNav.tabBarItem.title = @"主页";
    categoryVC.tabBarItem.title = @"分类";
    findVC.tabBarItem.title = @"发现";
    shopCartVC.tabBarItem.title = @"购物车";
    mineVC.tabBarItem.title = @"我的";
    settingVC.tabBarItem.title = @"设置";
    
//    homeVc.tabBarItem.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    homeVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    homeVc.tabBarItem.image = [UIImage imageNamed:@"home"];
    homeVc.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected"];
    // 设置角标颜色及文字
    if (@available(iOS 10.0, *)) {
        homeVc.tabBarItem.badgeColor = [UIColor redColor];
    } else {
       
    }
    homeVc.tabBarItem.badgeValue = @"3";
    
    
    categoryVC.tabBarItem.image = [UIImage imageNamed:@"category"];
    categoryVC.tabBarItem.selectedImage = [UIImage imageNamed:@"category_selected"] ;
    
    findVC.tabBarItem.image = [UIImage imageNamed:@"finder"];
    findVC.tabBarItem.selectedImage = [UIImage imageNamed:@"finder_selected"];
    findVC.tabBarItem.badgeValue = @"●";
    if (@available(iOS 10.0, *)) {
        [findVC.tabBarItem setBadgeTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
    } else {
        
    }
    
    shopCartVC.tabBarItem.image = [UIImage imageNamed:@"shopCart"];
    shopCartVC.tabBarItem.selectedImage = [UIImage imageNamed:@"shopCart_selectes"];
    
    mineVC.tabBarItem.image =[UIImage imageNamed:@"mine"];
    mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"mine_selected"];
    
    settingVC.tabBarItem.image = [UIImage imageNamed:@"setting"];
    settingVC.tabBarItem.selectedImage = [UIImage imageNamed:@"setting_selected"];
    

//    // 改变tabbarController 文字选中颜色(默认渲染为蓝色)
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
//
    UITabBarController *tabbarVC = [[UITabBarController alloc]init];
    tabbarVC.viewControllers = @[homeNav,categoryNav,finderNav,shopCartNav,mineNav,settingNav];
    tabbarVC.delegate = self;
    [self presentViewController:tabbarVC animated:YES completion:nil];
}


- (void) presentCustomTabBarVC
{
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"首页",@"热点",@"喜欢",@"个人中心", nil];
    NSMutableArray *imageNormalArr = [NSMutableArray arrayWithObjects:@"tab1_nor",@"tab2_nor",@"tab3_nor",@"tab4_nor", nil];
    NSMutableArray *imageSelectedArr = [NSMutableArray arrayWithObjects:@"tab1_sel",@"tab2_sel",@"tab3_sel",@"tab4_sel", nil];
    NSMutableArray *controllersArr = [NSMutableArray array];
    for (int i = 0; i < titleArr.count; i++)
    {
        FinderViewController *vc = [[FinderViewController alloc] init];
        vc.view.backgroundColor = kRandomColor;
        [controllersArr addObject:vc];

    }
    TabbarBaseConfig *config = [TabbarBaseConfig config];
    CustomTabBarController *tabBarVc = [[CustomTabBarController alloc] initWithTabBarControllers:controllersArr NorImageArr:imageNormalArr SelImageArr:imageSelectedArr TitleArr:titleArr Config:config];
    
    [config showNewBadgeAtIndex:1];
    [config showPointBadgeAtIndex:0];
    [config showNumberBadgeValue:@"2" AtIndex:2];
    [config showNumberBadgeValue:@"···" AtIndex:3]; // •••
    [self presentViewController:tabBarVc animated:YES completion:nil];
    
    
}

#pragma mark - tabbarControllerDelegete
// 是否允许选择分栏控制器上的不同控制器
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

// 选中分栏控制器其中一个时调用该方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"选中了：%@",NSStringFromClass([viewController class]));
}

/**
 * 点击moreNavigationController 中的edit按钮时会调用该方法
 * @pram viewControllers 可编辑的视图控制器，默认为tabbrController的viewcontrollers
 */
- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers
{
    NSLog(@"可编辑的视图控制器数组：%@",viewControllers);
}

// 即将完成编辑时候调用
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed
{
    NSLog(@"即将完成编辑");
}

// 结束编辑时调用
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed
{
    NSLog(@"结束编辑");
}

// UIInterfaceOrientationMask 枚举类型，屏幕旋转时，tabBarController 支持的方向，多选
/**
 * UIInterfaceOrientationMaskPortrait = (1 << UIInterfaceOrientationPortrait),
 * UIInterfaceOrientationMaskLandscapeLeft = (1 << UIInterfaceOrientationLandscapeLeft),
 * UIInterfaceOrientationMaskLandscapeRight = (1 << UIInterfaceOrientationLandscapeRight),
 * UIInterfaceOrientationMaskPortraitUpsideDown = (1 << UIInterfaceOrientationPortraitUpsideDown),
 * UIInterfaceOrientationMaskLandscape = (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
 * UIInterfaceOrientationMaskAll = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown),
 * UIInterfaceOrientationMaskAllButUpsideDown = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
 */
- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController
{
    return UIInterfaceOrientationMaskAll;
}

/**
 * UIInterfaceOrientation 枚举类型
 *  1. UIInterfaceOrientationUnknown 设备的朝向不能确定。
 *  2. UIInterfaceOrientationPortrait  该设备处于竖屏模式，设备保持直立，底部的Home键。
 *  3. UIInterfaceOrientationPortraitUpsideDown 该设备处于竖屏模式，但上下颠倒，设备保持直立，顶部的Home键。
 *  4. UIInterfaceOrientationLandscapeLeft 设备处于横向模式，设备保持直立，右侧Home键。
 *  5. UIInterfaceOrientationLandscapeRight 该设备处于横向模式，设备保持直立，左侧Home键。
 */
- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - 自定义转场动画

// 自定义 切换 交互式
// UIViewControllerInteractiveTransitioning 通过交互手段，通常是手势来驱动动画控制器实现的动画，使得用户能够控制整个过程
- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController 
{
    return nil;
}

// 自定义 切换 动画
- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC
{
    return [LMKScaleTransition new];
}


@end
