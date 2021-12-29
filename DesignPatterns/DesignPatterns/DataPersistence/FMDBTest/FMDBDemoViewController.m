//
//  FMDBDemoViewController.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/14.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "FMDBDemoViewController.h"
#import "Person.h"
#import "FMDB.h"
@interface FMDBDemoViewController ()<UITextFieldDelegate>

@property (strong, nonatomic)FMDatabase *db;

@property (strong, nonatomic) IBOutlet UITextField *theNameTF;

@property (strong, nonatomic) IBOutlet UITextField *theAgeTf;

@property (strong, nonatomic) IBOutlet UISegmentedControl *sexType;

@property (strong, nonatomic) IBOutlet UITextField *theQueryName;

@property (strong, nonatomic) IBOutlet UITextField *theOldName;

@property (strong, nonatomic) IBOutlet UITextField *theNewName;

@end

@implementation FMDBDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"FMDB的使用";
    [self creatDB];
    [self loadTFDelegate];
}

- (void)loadTFDelegate
{
    self.theNewName.delegate = self;
    self.theAgeTf.delegate = self;
    self.theQueryName.delegate = self;
    self.theOldName.delegate = self;
    self.theNewName.delegate = self;
}

- (void)creatDB
{
    NSString *string = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dbPath = [string stringByAppendingString:@"FMDBTest.sqlite"];
    NSLog(@"数据库路径：%@",dbPath);
    self.db = [FMDatabase databaseWithPath:dbPath];
    if ([self.db open])
    {
        BOOL result = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_person (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL,sex text NOT NULL);"];
        if (result)
        {
            NSLog(@"人员表创建成功");
        }
        else
        {
            NSLog(@"人员表创建失败");
        }
    }
}

// 插入数据
- (void)insertValue:(Person *)person
{
    BOOL result = [self.db executeUpdate:[NSString stringWithFormat:@"insert into t_person (name,age,sex) values ('%@','%lu','%@')",person.name,(long)person.age,person.sex]];
    if (result)
    {
        NSLog(@"插入成功");
    }
    else
    {
        NSLog(@"插入失败");
    }
    
}

// 删除数据
- (void)deleteValue:(NSString *)nameValue
{
    BOOL result = [self.db executeUpdate:[NSString stringWithFormat:@"delete from t_person where name = '%@'",nameValue]];
    if (result)
    {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
}

// 更新数据
- (void)updateValue:(NSString *)oldName useNewValue:(NSString *)newName
{
    BOOL result = [self.db executeUpdate:[NSString stringWithFormat:@"update t_person set name = '%@' where name = '%@'",newName,oldName]];
    if (result)
    {
        NSLog(@"更新成功");
    }
    else
    {
        NSLog(@"更新失败");
    }
    
}

// 查询数据
- (void)queryValue:(NSString *)nameValue
{
   FMResultSet *result = [self.db executeQuery:[NSString stringWithFormat:@"select * from t_person where name = '%@'",nameValue]];
    while ([result next])
    {
        NSString *name = [result stringForColumnIndex:1];
        int age = [result intForColumn:@"age"];
        NSString *sex = [result stringForColumn:@"sex"];
        NSLog(@"name: %@, age: %d,sex:%@",name, age,sex);
    }
    
}

// 关闭数据库
- (void)closeSqlite
{
    
    int result = [self.db close];
    if (result)
    {
        NSLog(@"数据库关闭成功");
    }
    else
    {
        NSLog(@"数据库关闭失败");
    }
}

#pragma xib action
- (IBAction)insert:(UIButton *)sender
{
    Person *person = [[Person alloc]init];
    NSString *name = self.theNameTF.text;
    person.name = name;
    NSInteger age = self.theAgeTf.text.integerValue;
    person.age = age;
    NSString *sex = self.sexType.selectedSegmentIndex ? @"women" : @"man";
    person.sex = sex;
    [self insertValue:person];
}

- (IBAction)delete:(UIButton *)sender
{
    NSString *name = self.theQueryName.text;
    [self deleteValue:name];
    
}

- (IBAction)query:(id)sender
{
    NSString *name = self.theQueryName.text;
    [self queryValue:name];
}


- (IBAction)update:(UIButton *)sender
{
    NSString *oldName = self.theOldName.text;
    NSString *currentName = self.theNewName.text;
    [self updateValue:oldName useNewValue:currentName];
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
