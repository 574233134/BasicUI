//
//  SQL3DemoViewController.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/10.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "SQL3DemoViewController.h"
#import <sqlite3.h>
#import "Person.h"
static sqlite3 *db;
@interface SQL3DemoViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *theNameTF;

@property (strong, nonatomic) IBOutlet UITextField *theAgeTf;

@property (strong, nonatomic) IBOutlet UISegmentedControl *sexType;

@property (strong, nonatomic) IBOutlet UITextField *theQueryName;

@property (strong, nonatomic) IBOutlet UITextField *theOldName;

@property (strong, nonatomic) IBOutlet UITextField *theNewName;

@end

@implementation SQL3DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"SQLite3数据库操作";
    [self openSqlite];
    [self creatTable];
    [self loadTFDelegate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self closeSqlite];
}

- (void)loadTFDelegate
{
    self.theNewName.delegate = self;
    self.theAgeTf.delegate = self;
    self.theQueryName.delegate = self;
    self.theOldName.delegate = self;
    self.theNewName.delegate = self;
}

#pragma mark - 数据库增删改查

// 打开数据库
- (BOOL)openSqlite
{
    if (db!=nil)
    {
        NSLog(@"数据库已打开");
        return YES;
    }
    NSString *string = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dbPath = [string stringByAppendingString:@"Person.sqlite"];
    NSLog(@"数据库路径：%@",dbPath);
    int result = sqlite3_open(dbPath.UTF8String, &db);
    if (result==SQLITE_OK)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 创建表
- (void)creatTable
{
    NSString *sqlString = [NSString stringWithFormat:@"create table if not exists person (id integer primary key autoincrement, name text not null, age integer, sex text)"];
    char *error = NULL;
    int result = sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    if (result==SQLITE_OK)
    {
        NSLog(@"创建表成功");
    }
    else
    {
        NSLog(@"创建表失败%s",error);
    }
}

// 插入数据
- (void)insertValue:(Person *)person
{
    NSString *sqlString = [NSString stringWithFormat:@"insert into person (name,age,sex) values ('%@','%lu','%@')",person.name,(long)person.age,person.sex];
    char *error = NULL;
    int result = sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    if (result==SQLITE_OK)
    {
        NSLog(@"插入数据成功");
    }
    else
    {
        NSLog(@"插入数据失败%s",error);
    }
    
}

// 删除数据
- (void)deleteValue:(NSString *)nameValue
{
    //1.准备sqlite语句
    NSString *sqlite = [NSString stringWithFormat:@"delete from person where name = '%@'",nameValue];
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
    if (result == SQLITE_OK)
    {
        NSLog(@"删除数据成功");
    }
    else
    {
        NSLog(@"删除数据失败%s",error);
    }
}

// 更新数据
- (void)updateValue:(NSString *)oldName useNewValue:(NSString *)newName
{
    //1.sqlite语句
    NSString *sqlString = [NSString stringWithFormat:@"update person set name = '%@' where name = '%@'",newName,oldName];
    sqlite3_stmt *stmt;
    int result = sqlite3_prepare_v2(db, sqlString.UTF8String, -1, &stmt, NULL);// 查询句柄
    if (result == SQLITE_OK)
    {
        if (sqlite3_step(stmt) == SQLITE_DONE)
        {
            NSLog(@"更新信息完成");
        }
    }
    else
    {
        NSLog(@"更新信息不合法");
    }
    sqlite3_finalize(stmt);

}

// 查询数据
- (NSArray *)queryValue:(NSString *)nameValue
{
    NSMutableArray *resultArray = [NSMutableArray array];
    NSString *sqlString = [NSString stringWithFormat:@"select * from person where name = '%@'",nameValue];
    // 查询句柄
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(db, sqlString.UTF8String, -1, &stmt, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            Person *person = [[Person alloc] init];
            //从伴随指针获取数据,第1列
            person.name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)] ;
            //从伴随指针获取数据,第2列
            person.age = sqlite3_column_int(stmt, 2);
            //从伴随指针获取数据,第3列
            person.sex = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)] ;
            [resultArray addObject:person];
        }
    
    }
    else
    {
        NSLog(@"查询失败");
    }
    sqlite3_finalize(stmt);
    NSLog(@"查询成功：结果为%@",resultArray);
    return resultArray;
}

// 删除整个表
-(void)dropTable
{
    if ([self openSqlite])
    {
        NSString * sql = @"drop table person";
        
        sqlite3_stmt * stmt = nil ;
        
        int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
        
        if (result == SQLITE_OK) {
            NSLog(@"成功删除当前表");
            sqlite3_step(stmt);
        }
        
        sqlite3_finalize(stmt);
    }
}

// 关闭数据库
- (void)closeSqlite
{
    
    int result = sqlite3_close(db);
    if (result == SQLITE_OK)
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
    [self openSqlite];
    [self insertValue:person];
}

- (IBAction)delete:(UIButton *)sender
{
    NSString *name = self.theQueryName.text;
    [self openSqlite];
    [self deleteValue:name];
  
}

- (IBAction)query:(id)sender
{
    NSString *name = self.theQueryName.text;
    [self openSqlite];
    [self queryValue:name];
}


- (IBAction)update:(UIButton *)sender
{
    NSString *oldName = self.theOldName.text;
    NSString *currentName = self.theNewName.text;
    [self openSqlite];
    [self updateValue:oldName useNewValue:currentName];
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
