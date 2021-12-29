//
//  UISearchBarDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/27.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "UISearchBarDemo.h"

@interface UISearchBarDemo ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation UISearchBarDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"搜索框";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self creatTableView];
}

- (void)loadData
{
    self.dataArray = [NSArray arrayWithObjects:@"SearchBarBasic", @"CustomSearchBarDisplayViewController",nil];
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
}

#pragma mark - tablevew dataSource
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

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = [[NSClassFromString(self.dataArray[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}



@end
