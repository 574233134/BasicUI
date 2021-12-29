//
//  CoreDataDemo.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/18.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "CoreDataDemo.h"
#import "StudentCardCell.h"
#import "Student+CoreDataClass.h"
#import <CoreData/CoreData.h>

@interface CoreDataDemo ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIButton *addBtn;

@property (strong, nonatomic) UIButton *deleteBtn;

@property (strong, nonatomic) UIButton *updateBtn;

@property (strong, nonatomic) UIButton *queryBtn;

@property (strong, nonatomic) UIButton *sortedBtn;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation CoreDataDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Core Data使用";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSqlite];
    [self loadData];
    [self creatTableView];
}

- (UIView *)headerView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    CGFloat btnWidth = self.view.frame.size.width/5.0;
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.backgroundColor = [UIColor redColor];
    [self.addBtn setTitle:@"插入" forState:UIControlStateNormal];
    self.addBtn.frame = CGRectMake(0*btnWidth, 0, btnWidth, 30);
    [self.addBtn addTarget:self action:@selector(insertData) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.addBtn];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.backgroundColor = [UIColor redColor];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    self.deleteBtn.frame = CGRectMake(1*btnWidth, 0, btnWidth, 30);
    [self.deleteBtn addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.deleteBtn];
    
    self.updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.updateBtn.backgroundColor = [UIColor redColor];
    [self.updateBtn setTitle:@"更新" forState:UIControlStateNormal];
    self.updateBtn.frame = CGRectMake(2*btnWidth, 0, btnWidth, 30);
    [self.updateBtn addTarget:self action:@selector(updateData) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.updateBtn];
    
    self.queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.queryBtn.backgroundColor = [UIColor redColor];
    [self.queryBtn setTitle:@"查询" forState:UIControlStateNormal];
    self.queryBtn.frame = CGRectMake(3*btnWidth, 0, btnWidth, 30);
    [self.queryBtn addTarget:self action:@selector(readData) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.queryBtn];
    
    self.sortedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sortedBtn.backgroundColor = [UIColor redColor];
    [self.sortedBtn setTitle:@"排序" forState:UIControlStateNormal];
    self.sortedBtn.frame = CGRectMake(4*btnWidth, 0, btnWidth, 30);
    [self.sortedBtn addTarget:self action:@selector(sort) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.sortedBtn];
    return view;
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 165;
    self.tableView.sectionHeaderHeight = 0.0000001;
    self.tableView.sectionFooterHeight = 0.0000001;
    self.tableView.tableHeaderView = [self headerView];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.0000001)];
    [self.view addSubview:self.tableView];
}

- (void)loadData
{
    //查询所有数据的请求 （EntityName：实体名）
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSArray *resArray = [self.context executeFetchRequest:request error:nil];
    self.dataArray = [NSMutableArray arrayWithArray:resArray];
}

// 创建数据库
// NSPersistentStoreCoordinator是持久化存储协调者，主要用于协调托管对象上下文和持久化存储区之间的关系
// NSManagedObjectContext使用协调者的托管对象模型将数据保存到数据库，或查询数据。
- (void)createSqlite
{
    // 1、创建模型对象
    // 获取模型路径
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    // 根据模型文件创建模型对象
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    
    // 2、创建持久化存储助理：数据库
    // 利用模型对象创建助理对象
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 数据库的名称和路径
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
    NSLog(@"数据库 path = %@", sqlPath);
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
    NSError *error = nil;
    // 设置数据库相关信息 添加一个持久化存储库并设置存储类型和路径，NSSQLiteStoreType：SQLite作为存储库
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
    
    if (error)
    {
        NSLog(@"添加数据库失败:%@",error);
    }
    else
    {
        NSLog(@"添加数据库成功");
    }
    
    // 3、创建上下文 保存信息 操作数据库
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 关联持久化助理
    context.persistentStoreCoordinator = store;
    
    self.context = context;
    
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    StudentCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell =[[StudentCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    Student *student = self.dataArray[indexPath.row];
    cell.nameLabel.text = student.name;
    cell.sexLabel.text = student.sex;
    cell.ageLabel.text = [NSNumber numberWithInt:student.age].stringValue;
    cell.heightLabel.text =[NSNumber numberWithInt:student.height].stringValue;
    return cell;
}

#pragma mark - btn callBack

//插入数据
- (void)insertData
{
    
    
    // 1.根据Entity名称和NSManagedObjectContext获取一个新的继承于NSManagedObject的子类Student
    Student * student = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Student"
                         inManagedObjectContext:self.context];
    
    // 2.根据表Student中的键值，给NSManagedObject对象赋值
    student.name = [NSString stringWithFormat:@"Mr-%d",arc4random()%100];
    student.age = arc4random()%20;
    student.sex = arc4random()%2 == 0 ?  @"女" : @"男" ;
    student.height = arc4random()%180 ;

    
    //查询所有数据的请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    self.dataArray = [NSMutableArray arrayWithArray:resArray];
    [self.tableView reloadData];
    
    // 3.保存插入的数据
    NSError *error = nil;
    if ([_context save:&error])
    {
        [self alertViewWithMessage:@"数据插入到数据库成功"];
    }
    else
    {
        [self alertViewWithMessage:[NSString stringWithFormat:@"数据插入到数据库失败, %@",error]];
    }
    
}

// 删除
- (void)deleteData
{
    
    //创建删除请求
    NSFetchRequest *deleRequest = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    //删除条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"age < %d", 10];
    deleRequest.predicate = pre;
    
    //返回需要删除的对象数组
    NSArray *deleArray = [_context executeFetchRequest:deleRequest error:nil];
    
    //从数据库中删除
    for (Student *stu in deleArray) {
        [_context deleteObject:stu];
    }
    
    // 没有任何条件就是读取所有的数据
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    self.dataArray = [NSMutableArray arrayWithArray:resArray];
    [self.tableView reloadData];
    
    NSError *error = nil;
    //保存--记住保存
    if ([_context save:&error]) {
        [self alertViewWithMessage:@"删除 age < 10 的数据"];
    }else{
        NSLog(@"删除数据失败, %@", error);
    }
    
}

//更新，修改
- (void)updateData
{
    
    //创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"sex = %@", @"男"];
    request.predicate = pre;
    
    //发送请求
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    
    //修改
    for (Student *stu in resArray) {
        stu.name = @"已修改_iOS";
    }
    
    self.dataArray = [NSMutableArray arrayWithArray:resArray];
    [self.tableView reloadData];
    
    //保存
    NSError *error = nil;
    if ([_context save:&error]) {
        [self alertViewWithMessage:@"更新所有男学生的的名字为“且行且珍惜_iOS”"];
    }else{
        NSLog(@"更新数据失败, %@", error);
    }
    
    
}

//读取查询
- (void)readData
{
    // 创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    // 查询条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"sex = %@", @"女"];
    request.predicate = pre;
    
    
    // 从第几页开始显示
    // 通过这个属性实现分页
    //request.fetchOffset = 0;
    
    // 每页显示多少条数据
    //request.fetchLimit = 6;
    
    
    // 发送查询请求,并返回结果
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    
    self.dataArray = [NSMutableArray arrayWithArray:resArray];
    [self.tableView reloadData];
    
    [self alertViewWithMessage:@"查询所有的女生"];
    
    
}

// 排序
- (void)sort
{
    
    // 创建排序请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    // 实例化排序对象
    NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age"ascending:YES];
    request.sortDescriptors = @[ageSort];
    
    // 发送请求
    NSError *error = nil;
    NSArray *resArray = [_context executeFetchRequest:request error:&error];
    
    self.dataArray = [NSMutableArray arrayWithArray:resArray];
    [self.tableView reloadData];
    
    if (error == nil)
    {
        [self alertViewWithMessage:@"按照age排序"];
    }
    else
    {
        NSLog(@"排序失败, %@", error);
    }
    
    
}

# pragma 封装警告框
- (void)alertViewWithMessage:(NSString *)message
{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:^{
        
        [NSThread sleepForTimeInterval:0.5];
        
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
}

@end
