//
//  DictionoryDemoViewController.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/16.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "DictionoryDemoViewController.h"

@interface DictionoryDemoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)NSArray *dataArray;

@property (strong, nonatomic)UITableView *tableView;

@end

@implementation DictionoryDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"字典相关操作";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self creatTableView];
 
}

- (void)loadData
{
    self.dataArray = [NSArray arrayWithObjects:
                      @"字典初始化",
                      @"查看字典内容",
                      @"字典遍历",
                      @"可变字典操作",
                      nil];
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    self.tableView.sectionHeaderHeight = 0.0000001;
    self.tableView.sectionFooterHeight = 0.0000001;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.0000001)];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.0000001)];
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView数据源及代理方法
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
    if([self.dataArray[indexPath.row] isEqualToString:@"字典初始化"])
    {
        [self createDictionry];
    }
    else if ([self.dataArray[indexPath.row] isEqualToString:@"查看字典内容"])
    {
        [self accessDictionaryValue];
    }
    else if ([self.dataArray[indexPath.row] isEqualToString:@"字典遍历"])
    {
        [self traverseDictionry];
    }
    else if ([self.dataArray[indexPath.row] isEqualToString:@"可变字典操作"])
    {
        [self variableDictionaryAction];
    }
}

- (void)createDictionry
{
    NSLog(@"初始化方式一：initWithObjects:forKeys:");
    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjects:@[@"qwe",@"asd",@"zxc",@"qaz",@"wsx"] forKeys:@[@"111",@"222",@"333",@"444",@"555"]];
    NSLog(@"dic1: %@",dic1);
    
    NSLog(@"初始化方式二：dictionaryWithObjectsAndKeys:");
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"湘琴",@"玛蒂娜",@"天策",@"豆豆",@"祥一",@"逗战圣佛", nil];
    NSLog(@"dic2:%@",dic2);
    
    NSLog(@"初始化方式三：@{}");
    NSDictionary *dic3 = @{@"key1":@"value1"};
    NSLog(@"dic3:%@",dic3);
}

- (void)accessDictionaryValue
{
    NSDictionary *dic = [[NSDictionary alloc]initWithObjects:@[@"qwe",@"asd",@"zxc",@"qaz",@"wsx"] forKeys:@[@"111",@"222",@"333",@"444",@"555"]];
    NSLog(@"字典内容：%@",dic);
    
    NSArray *keys = [dic allKeys];
    NSLog(@"keys 数组：%@",keys);
    
    NSArray *values = [dic allValues];
    NSLog(@"values 数组：%@",values);
    
    NSLog(@"key = 222 value = %@",dic[@"222"]);
}

- (void)traverseDictionry
{
     NSDictionary *dic = [[NSDictionary alloc]initWithObjects:@[@"qwe",@"asd",@"zxc",@"qaz",@"wsx"] forKeys:@[@"111",@"222",@"333",@"444",@"555"]];
    for (id key in dic)
    {
        id value=[dic objectForKey:key];
        NSLog(@"%@:%@",key,value);
    }
    
    
}

- (void)variableDictionaryAction
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"1":@"a",@"2":@"b",@"3":@"c"}];
    NSLog(@"初始dic :%@",dic);
    
    NSLog(@"%@ = %@",@"2",dic[@"2"]);
    NSLog(@"更改 key = 2 时 value = f");
    [dic setObject:@"f" forKey:@"2"];
    NSLog(@"%@ = %@",@"2",dic[@"2"]);
    
    NSDictionary *dic2 = @{@"3":@"test",@"4":@"d",@"5":@"f"};
    NSLog(@"dic 2 :%@",dic2);
    NSLog(@"拼接dic 和 dic2");
    [dic addEntriesFromDictionary:dic2];
    NSLog(@"dic:%@",dic);
    
    NSLog(@"[dic setObject:jiu forKey:9]");
    [dic setObject:@"jiu" forKey:@"9"];
    NSLog(@"dic:%@",dic);
    
}

@end
