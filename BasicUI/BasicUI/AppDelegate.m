//
//  AppDelegate.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MyNavigationViewController.h"
#import "UIViewControllerDemo.h"
#import "ViewControllerPreView.h"
#import "DesignPatatternViewController.h"
#import "DataPersistenceViewController.h"
#import "OCContainerViewController.h"
@interface AppDelegate ()

@property (strong, nonatomic)UIApplicationShortcutItem *quickEnterItem;

@property (strong, nonatomic) UINavigationController *nav;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    DesignPatatternViewController *designVC = [[DesignPatatternViewController alloc]init];
    DataPersistenceViewController *dataStoreVC = [[DataPersistenceViewController alloc]init];
    OCContainerViewController *contatinVC = [[OCContainerViewController alloc]init];
    
    ViewController *homeVC = [[ViewController alloc]init];
    
    
    designVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"design_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    dataStoreVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"dataStore_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    contatinVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"contain_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"component_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    designVC.tabBarItem.image = [[UIImage imageNamed:@"design"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    dataStoreVC.tabBarItem.image = [[UIImage imageNamed:@"dataStore"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    contatinVC.tabBarItem.image = [[UIImage imageNamed:@"contain"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.image =[[UIImage imageNamed:@"component"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    designVC.title = @"设计模式";
    dataStoreVC.title = @"数据存储";
    contatinVC.title = @"OC容器";
    homeVC.title = @"UI组件";
    
    
    UINavigationController *designNVC = [[UINavigationController alloc]initWithRootViewController:designVC];
    designNVC.navigationBar.opaque = NO;
    [designNVC.navigationBar setBarTintColor:[UIColor colorWithRed:38.0/255 green:188.0/255 blue:213.0/255 alpha:1]];
    UINavigationController *dataStoreNVC = [[UINavigationController alloc]initWithRootViewController:dataStoreVC];
    dataStoreNVC.navigationBar.opaque = NO;
    [dataStoreNVC.navigationBar setBarTintColor:[UIColor colorWithRed:38.0/255 green:188.0/255 blue:213.0/255 alpha:1]];
    UINavigationController *contatinNVC = [[UINavigationController alloc]initWithRootViewController:contatinVC];
    contatinNVC.navigationBar.opaque = NO;
    [contatinNVC.navigationBar setBarTintColor:[UIColor colorWithRed:38.0/255 green:188.0/255 blue:213.0/255 alpha:1]];
    self.nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    self.nav.navigationBar.opaque = NO;
    self.nav.navigationBar.translucent = NO;
    [self.nav.navigationBar setBarTintColor:[UIColor colorWithRed:38.0/255 green:188.0/255 blue:213.0/255 alpha:1]];
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UITabBarController *mainTabar = [[UITabBarController alloc]init];
    [mainTabar.tabBar setBarTintColor:[UIColor colorWithRed:38.0/255 green:188.0/255 blue:213.0/255 alpha:1]];
    mainTabar.viewControllers = @[self.nav,designNVC,dataStoreNVC,contatinNVC];
    mainTabar.tabBar.opaque = NO;
    // 改变tabbar 文字选中颜色(默认渲染为蓝色)
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    self.window.rootViewController = mainTabar;
    
    
    self.nav.restorationIdentifier = @"nav";
    [self.window makeKeyAndVisible];
    
    
#ifdef __IPHONE_9_0
    [self createShortcutItems];
#endif
    UIApplicationShortcutItem *item = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (item)
    {
        NSLog(@"快捷方式启动 %@", item.localizedTitle);
    }
    else
    {
        NSLog(@"正常启动");
    }
    return YES;
}


// 开启应用状态保存
- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}
// 开启应用状态恢复
- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    return YES;
}

//// 如果不提供 Controller 的restorationClass属性, 我们可以在该方法中再次处理部分页面的恢复事件,
//- (nullable UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0);
//{
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.restorationIdentifier = [identifierComponents lastObject];
//    return vc;
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
   
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog(@"shortcutType = %@  %@",shortcutItem.type,shortcutItem.localizedTitle);
    if ([shortcutItem.localizedTitle isEqualToString:@"预览页面"])
    {
        NSLog(@"111");
        ViewController *homeVC = [[ViewController alloc]init];
        UIViewControllerDemo *demoVC = [[UIViewControllerDemo alloc]init];
        ViewControllerPreView *preVC = [[ViewControllerPreView alloc]init];
        [self.nav setViewControllers:@[homeVC,demoVC,preVC] animated:YES];
    }
}

/**
 *  创建3D Touch选项
 */
- (void)createShortcutItems
{
    //最简单的形式
    UIApplicationShortcutItem * item1 = [[UIApplicationShortcutItem alloc]initWithType:@"item1"
                                                                        localizedTitle:@"预览页面"];
    
    //可以自定义选项
    UIApplicationShortcutIcon * icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIApplicationShortcutItem * item2 = [[UIApplicationShortcutItem alloc]initWithType:@"item2"
                                                                        localizedTitle:@"Item2"
                                                                     localizedSubtitle:@"Item2"
                                                                                  icon:icon2
                                                                              userInfo:nil];
    //使用自定义的图片定义选项
    UIApplicationShortcutIcon * icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"delete"] ;
    UIApplicationShortcutItem * item3 = [[UIApplicationShortcutItem alloc]initWithType:@"item3"
                                                                        localizedTitle:@"Item3"
                                                                     localizedSubtitle:@"item3"
                                                                                  icon:icon3
                                                                              userInfo:nil];
    //响应到APP端
    [UIApplication sharedApplication].shortcutItems = @[item1,item2,item3];
}

@end
