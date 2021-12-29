//
//  PlistStoreViewController.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/9.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "PlistStoreViewController.h"

@interface PlistStoreViewController ()

@end

@implementation PlistStoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"plist文件存储";
}

#pragma mark - plist 存储

- (IBAction)storeToDocument:(UIButton *)sender
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"Document路径：%@", path);
    NSString *fileName = [path stringByAppendingPathComponent:@"testArrayPlist.plist"];
    NSArray *array = @[@"123", @"456", @"789"];
    [array writeToFile:fileName atomically:YES];
}

- (IBAction)storeToCache:(UIButton *)sender
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"Cache路径：%@", path);
    NSString *fileName = [path stringByAppendingString:@"testDicPlist.plist"];
    NSDictionary *dic = @{@"key1":@"Value1",@"key2":@"Value2"};
    [dic writeToFile:fileName atomically:YES];
}


- (IBAction)storeToPerferences:(UIButton *)sender
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:@"plist-perferrences" forKey:@"testPerferencesPlist"];
    [userdefaults synchronize];
}

- (IBAction)storeToTemp:(UIButton *)sender
{
    NSString *path = NSTemporaryDirectory();
    NSLog(@"%@", path);
    NSString *fileName = [path stringByAppendingString:@"testNumberPlist.plist"];
    NSString *str = @"测试plist文件中存入字符串";
    [str writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
  
}

#pragma mark - 读取

- (IBAction)readFromDocument:(UIButton *)sender
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"Document路径：%@", path);
    NSString *fileName = [path stringByAppendingPathComponent:@"testArrayPlist.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:fileName];
    [self alertWithTitle:@"读取成功" message:[NSString stringWithFormat:@"数据为%@",array]];
}


- (IBAction)readFromCache:(UIButton *)sender
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"Cache路径：%@", path);
    NSString *fileName = [path stringByAppendingString:@"testDicPlist.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileName];
    [self alertWithTitle:@"读取成功" message:[NSString stringWithFormat:@"数据为%@",dic]];
}


- (IBAction)readFromPerferences:(UIButton *)sender
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [userdefaults objectForKey:@"testPerferencesPlist"];
    [self alertWithTitle:@"读取成功" message:[NSString stringWithFormat:@"数据为%@",str]];
}

- (IBAction)readFromTemp:(UIButton *)sender
{
    NSString *path = NSTemporaryDirectory();
    NSLog(@"%@", path);
    NSString *fileName = [path stringByAppendingString:@"testNumberPlist.plist"];
    NSString *str = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    [self alertWithTitle:@"读取成功" message:[NSString stringWithFormat:@"数据为%@",str]];
}

#pragma mark - 删除
// 多次写重复代码，要考虑封装公共方法 类似-(BOOL)removePlist:(NSString*)fileName
- (IBAction)deletePlist:(UIButton *)sender
{
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *documentfileName = [documentPath stringByAppendingPathComponent:@"testArrayPlist.plist"];
    [fileManage removeItemAtPath:documentfileName error:nil];
    
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *cacheFileName = [cachePath stringByAppendingString:@"testDicPlist.plist"];
    [fileManage removeItemAtPath:cacheFileName error:nil];
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults removeObjectForKey:@"testPerferencesPlist"];
    [userdefaults synchronize];
    
    NSString *tempPath = NSTemporaryDirectory();
    NSString *tempFileName = [tempPath stringByAppendingString:@"testNumberPlist.plist"];
    [fileManage removeItemAtPath:tempFileName error:nil];
    
    [self alertWithTitle:@"提示" message:@"删除成功"];
    
}
// 删除plist
-(BOOL)removePlist:(NSString*)fileName{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *plistName = [NSString stringWithFormat:@"%@.plist",fileName];
    NSString *cacheFileName = [cachePath stringByAppendingString:plistName];
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:cacheFileName error:nil];
    return result;
}
#pragma mark - 封装警告框
-(void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}

@end
