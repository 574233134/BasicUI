//
//  AppDelegate.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/3.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "AppDelegate.h"
#import "DesignPatatternViewController.h"
#import "DataPersistenceViewController.h"
#import "OCContainerViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    DesignPatatternViewController *designVC = [[DesignPatatternViewController alloc]init];
    DataPersistenceViewController *dataStoreVC = [[DataPersistenceViewController alloc]init];
    OCContainerViewController *contatinVC = [[OCContainerViewController alloc]init];
    
    designVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"design_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    dataStoreVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"dataStore_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    contatinVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"contain_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    designVC.tabBarItem.image = [[UIImage imageNamed:@"design"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    dataStoreVC.tabBarItem.image = [[UIImage imageNamed:@"dataStore"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    contatinVC.tabBarItem.image = [[UIImage imageNamed:@"contain"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    designVC.title = @"设计模式";
    dataStoreVC.title = @"数据存储";
    contatinVC.title = @"OC容器";
    
    
    UINavigationController *designNVC = [[UINavigationController alloc]initWithRootViewController:designVC];
    designNVC.navigationBar.opaque = NO;
    [designNVC.navigationBar setBarTintColor:[UIColor colorWithRed:38.0/255 green:188.0/255 blue:213.0/255 alpha:1]];
    UINavigationController *dataStoreNVC = [[UINavigationController alloc]initWithRootViewController:dataStoreVC];
    dataStoreNVC.navigationBar.opaque = NO;
    [dataStoreNVC.navigationBar setBarTintColor:[UIColor colorWithRed:38.0/255 green:188.0/255 blue:213.0/255 alpha:1]];
    UINavigationController *contatinNVC = [[UINavigationController alloc]initWithRootViewController:contatinVC];
    contatinNVC.navigationBar.opaque = NO;
    [contatinNVC.navigationBar setBarTintColor:[UIColor colorWithRed:38.0/255 green:188.0/255 blue:213.0/255 alpha:1]];
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UITabBarController *mainTabar = [[UITabBarController alloc]init];
    mainTabar.tabBar.opaque = NO;
    [mainTabar.tabBar setBarTintColor:[UIColor colorWithRed:38.0/255 green:188.0/255 blue:213.0/255 alpha:1]];
    mainTabar.viewControllers = @[designNVC,dataStoreNVC,contatinNVC];
    
    // 改变tabbar 文字选中颜色(默认渲染为蓝色)
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    self.window.rootViewController = mainTabar;
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}


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


@end
