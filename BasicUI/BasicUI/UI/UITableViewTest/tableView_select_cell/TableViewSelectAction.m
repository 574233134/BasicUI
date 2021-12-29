//
//  TableViewSelectAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/15.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TableViewSelectAction.h"

@interface TableViewSelectAction ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;


@end

@implementation TableViewSelectAction
{
    UIBarButtonItem *_selectOne;
    UIBarButtonItem *_selectAll;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"tableView选择操作";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataArray];
    [self creatTableView];
    [self creatNavigatioRightButton];
}

- (void)initDataArray
{
    self.dataArray = [NSMutableArray array];
    for(int i=0; i<300; i++)
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
    _selectOne = [[UIBarButtonItem alloc]initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(selectOne:)];
    _selectAll = [[UIBarButtonItem alloc]initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(selectAll:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:_selectOne, nil];
}

-(void)selectOne:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:@"选择"])
    {
        item.title = @"完成";
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:_selectOne,_selectAll, nil];
        [self.tableView setEditing:YES animated:YES];
    }
    else
    {
        item.title = @"选择";
        [_selectAll setTitle:@"全选"];
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:_selectOne, nil];
        [self.tableView setEditing:NO animated:YES];
    }
}

-(void)selectAll:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:@"全选"])
    {
        [item setTitle:@"全不选"];
        for (int i = 0; i < self.dataArray.count; i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }
    else
    {
        [item setTitle:@"全选"];
        for (int i = 0; i < self.dataArray.count; i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
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

#pragma mark - tableview 选中

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self alertWithTitle:[NSString stringWithFormat:@"您选中了%u行",indexPath.row+1] message:[NSString stringWithFormat:@"数据为：%@",self.dataArray[indexPath.row]]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self alertWithTitle:[NSString stringWithFormat:@"您取消选中第%u行",indexPath.row+1] message:[NSString stringWithFormat:@"数据为：%@",self.dataArray[indexPath.row]]];
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
