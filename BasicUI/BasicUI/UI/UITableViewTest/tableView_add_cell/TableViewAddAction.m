//
//  TableViewAddAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/15.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TableViewAddAction.h"

@interface TableViewAddAction ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation TableViewAddAction

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"tableView添加操作";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataArray];
    [self creatTableView];
    [self creatNavigatioRightButton];
   
}

- (void)initDataArray
{
    self.dataArray = [NSMutableArray array];
    for(int i=0; i<10; i++)
    {
        NSString *dataStr = [NSString stringWithFormat:@"初始数据: %d",i];
        [self.dataArray addObject:dataStr];
    }
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
}

- (void)creatNavigatioRightButton
{
    UIBarButtonItem *addOneItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addOne:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:addOneItem, nil];
}

-(void)addOne:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:@"添加"])
    {
        item.title = @"完成";
        [self.tableView setEditing:YES animated:YES];
    }
    else
    {
        item.title = @"添加";
        [self.tableView setEditing:NO animated:YES];
    }
}


#pragma mark - tableview Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma 添加

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleInsert;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray insertObject:[NSString stringWithFormat:@"测试数据：%u",indexPath.row] atIndex:indexPath.row];
    NSIndexPath *refreshCell = [NSIndexPath
                                indexPathForRow:indexPath.row inSection:indexPath.section];
    
   
    [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:refreshCell] withRowAnimation:UITableViewRowAnimationRight];
}

@end
