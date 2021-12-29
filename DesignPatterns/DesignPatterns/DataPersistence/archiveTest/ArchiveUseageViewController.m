//
//  ArchiveUseageViewController.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/9.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "ArchiveUseageViewController.h"
#import "Person.h"
@interface ArchiveUseageViewController ()

@end

@implementation ArchiveUseageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"序列化与反序列化";
}

#pragma mark - 单个序列化对象操作
- (IBAction)oneStore:(UIButton *)sender
{
    Person *person = [[Person alloc]init];
    person.sex = @"man";
    person.name = @"John";
    person.age = 20;
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.data"];
    [NSKeyedArchiver archiveRootObject:person toFile:file];
     [self alertWithTitle:@"提示" message:@"序列化对象存储成功"];
    
}

- (IBAction)oneRead:(UIButton *)sender
{
    
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.data"];
    
    Person *person = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    [self alertWithTitle:@"读取成功" message:[NSString stringWithFormat:@"sex:%@,name:%@,age:%lu",person.sex,person.name,person.age]];
}

- (IBAction)oneDelete:(UIButton *)sender
{
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.data"];
    BOOL isdirectory;
    if ([fileManger fileExistsAtPath:file isDirectory:&isdirectory])
    {
        NSLog(@"isdirector：%d",isdirectory);
        [fileManger removeItemAtPath:file error:nil];
        [self alertWithTitle:@"提示" message:@"序列化对象删除成功"];
    }
}

#pragma mark - 多个序列化对象操作

- (IBAction)manyStore:(UIButton *)sender
{
    Person *person1 = [[Person alloc]init];
    person1.name = @"张三";
    person1.sex = @"man";
    person1.age = 21;
    
    Person *person2 = [[Person alloc]init];
    person2.name = @"白小倩";
    person2.sex  =@"women";
    person2.age = 28;
    
    NSArray *array = @[person1,person2];
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"personArray.data"];
    [NSKeyedArchiver archiveRootObject:array toFile:file];
    [self alertWithTitle:@"提示" message:@"序列化对象数组存储成功"];

}


- (IBAction)manyRead:(UIButton *)sender
{
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"personArray.data"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    [self alertWithTitle:@"读取成功" message:[NSString stringWithFormat:@"person 人数为：%lu",array.count]];
    for (int i=0; i<array.count; i++)
    {
        Person *person = array[i];
        NSLog(@"name:%@,sex:%@,age:%lu",person.name,person.sex,person.age);
    }
}

- (IBAction)manyDelete:(UIButton *)sender
{
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"personArray.data"];
    BOOL isdirectory;
    if ([fileManger fileExistsAtPath:file isDirectory:&isdirectory])
    {
        NSLog(@"isdirector：%d",isdirectory);
        [fileManger removeItemAtPath:file error:nil];
        [self alertWithTitle:@"提示" message:@"序列化对象数组删除成功"];
    }
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
