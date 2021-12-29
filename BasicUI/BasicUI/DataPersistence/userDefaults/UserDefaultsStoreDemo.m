//
//  UserDefaultsStoreDemo.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/8.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "UserDefaultsStoreDemo.h"
#import "Person.h"
@interface UserDefaultsStoreDemo ()


@property (strong, nonatomic) IBOutlet UISegmentedControl *basicDataStype;

@end

@implementation UserDefaultsStoreDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"NSUserDefault存储数据";
}

#pragma mark - 基础数据类型存取操作
- (IBAction)storeBasic:(UIButton *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    switch (self.basicDataStype.selectedSegmentIndex)
    {
        case 0: // 数组
        {
            NSArray *array = [[NSArray alloc]initWithObjects:@"test1",@"test2", nil];
            [userDefaults setObject:array forKey:@"basicArray"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"数组存储成功"];
        }
            break;
        case 1: // 字典
        {
            NSDictionary *dictionry = @{@"key1":@"Value1"};
            [userDefaults setObject:dictionry forKey:@"basicDictionry"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"字典存储成功"];
        }
            break;
        case 2: // integer
        {
            NSInteger integer = 1;
            [userDefaults setInteger:integer forKey:@"basicInteger"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"integer存储成功"];
        }
            break;
        case 3: // double
        {
            double doubleValue = 2.0;
            [userDefaults setDouble:doubleValue forKey:@"basicDouble"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"字典存储成功"];
        }
            break;
        case 4: // data
        {
            NSData *data = [[NSData alloc]initWithBase64EncodedString:@"testData" options:NSDataBase64DecodingIgnoreUnknownCharacters];
            [userDefaults setObject:data forKey:@"basicData"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"data存储成功"];
        }
            break;
        case 5: // float
        {
            float floatValue = 1.0;
            [userDefaults setFloat:floatValue forKey:@"basicFloat"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"float存储成功"];
        }
            break;
        case 6: // bool
        {
            BOOL boolValue = YES;
            [userDefaults setBool:boolValue forKey:@"basicBool"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"Bool存储成功"];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)readBasic:(UIButton *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    switch (self.basicDataStype.selectedSegmentIndex)
    {
        case 0: // 数组
        {
            NSArray *array = [userDefaults objectForKey:@"basicArray"];
            [self alertWithTitle:@"读取数据成功" message:[NSString stringWithFormat:@"数组数据为%@",array]];
        }
            break;
        case 1: // 字典
        {
            NSDictionary *dictionry = [userDefaults dictionaryForKey:@"basicDictionry"];
            [self alertWithTitle:@"读取数据成功" message:[NSString stringWithFormat:@"字典数据为%@",dictionry]];
        }
            break;
        case 2: // integer
        {
            NSInteger integer = [userDefaults integerForKey:@"basicInteger"];
            [self alertWithTitle:@"读取数据成功" message:[NSString stringWithFormat:@"integer数据为%u",integer]];
        }
            break;
        case 3: // double
        {
            double doubleValue = [userDefaults doubleForKey:@"basicDouble"];
            [self alertWithTitle:@"读取数据成功" message:[NSString stringWithFormat:@"double数据为%.4lf",doubleValue]];
        }
            break;
        case 4: // data
        {
            NSData *data = [userDefaults objectForKey:@"basicData"];
            [self alertWithTitle:@"读取数据成功" message:[NSString stringWithFormat:@"data数据为%@",data]];
        }
            break;
        case 5: // float
        {
            float floatValue = [userDefaults floatForKey:@"basicFloat"];
            [self alertWithTitle:@"读取数据成功" message:[NSString stringWithFormat:@"float数据为%.2f",floatValue]];
        }
            break;
        case 6: // bool
        {
            BOOL boolValue = [userDefaults boolForKey:@"basicBool"];
            [self alertWithTitle:@"读取数据成功" message:[NSString stringWithFormat:@"Bool数据为%d",boolValue]];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)deleteBasic:(UIButton *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    switch (self.basicDataStype.selectedSegmentIndex)
    {
        case 0: // 数组
        {
            [userDefaults removeObjectForKey:@"basicArray"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"数组删除成功"];
            
        }
            break;
        case 1: // 字典
        {
            [userDefaults removeObjectForKey:@"basicDictionry"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"字典删除成功"];
        }
            break;
        case 2: // integer
        {
            [userDefaults removeObjectForKey:@"basicInteger"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"integer删除成功"];
        }
            break;
        case 3: // double
        {
            [userDefaults removeObjectForKey:@"basicDouble"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"Double删除成功"];
        }
            break;
        case 4: // data
        {
            [userDefaults removeObjectForKey:@"basicData"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"data删除成功"];
        }
            break;
        case 5: // float
        {
            [userDefaults removeObjectForKey:@"basicFloat"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"float删除成功"];
        }
            break;
        case 6: // bool
        {
            [userDefaults removeObjectForKey:@"basicBool"];
            [userDefaults synchronize];
            [self alertWithTitle:@"提示" message:@"bool删除成功"];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 序列化对象存取

- (IBAction)objectStore:(UIButton *)sender
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
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    if (array && [NSKeyedArchiver archivedDataWithRootObject:array]) {
        [userdefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:array] forKey:@"userdefaultsStoreArchiveObject"];
    }
    [userdefaults synchronize];
    [self alertWithTitle:@"提示" message:@"序列化对象存储成功"];
}

- (IBAction)objectRead:(UIButton *)sender
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userdefaults objectForKey:@"userdefaultsStoreArchiveObject"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self alertWithTitle:@"读取成功" message:[NSString stringWithFormat:@"人数为：%u",array.count]];
    
}

- (IBAction)objectDelete:(UIButton *)sender
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults removeObjectForKey:@"userdefaultsStoreArchiveObject"];
    [self alertWithTitle:@"提示" message:@"序列化对象删除成功"];
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
