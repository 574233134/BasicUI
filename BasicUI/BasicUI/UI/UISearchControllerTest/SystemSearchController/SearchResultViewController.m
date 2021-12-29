//
//  SearchResultViewController.m
//  BasicUIDemo
//
//  Created by 李梦珂 on 2018/8/1.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "SearchResultViewController.h"
#define STATEBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVIGATIONBAR_HEIGHT  self.navigationController.navigationBar.frame.size.height
static NSString *identify = @"cell";

@interface SearchResultViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *resultArray;

@property (strong, nonatomic) NSMutableArray *searchRangeArray;

@end

@implementation SearchResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataArray];
    [self creatTableView];
    [self initSearchControllerConfig];
}

- (void)initDataArray
{
    _searchRangeArray = [NSMutableArray array];
    for (int i=0; i<100; i++)
    {
        [_searchRangeArray addObject:[NSString stringWithFormat:@"测试数据：%d",i]];
    }
}

- (void) creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.systemSearchController.searchBar.frame.size.height-STATEBAR_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
    self.edgesForExtendedLayout =UIRectEdgeNone;
}

- (void)initSearchControllerConfig
{
    self.systemSearchController.searchResultsUpdater = self;
    self.systemSearchController.searchBar.delegate = self;
}

# pragma mark - tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = _resultArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultArray.count;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

# pragma mark - UISearchResultsUpdating

//每输入一个字符都会执行一次
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    searchController.searchResultsController.view.hidden = NO;
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchController.searchBar.text];
    if (self.resultArray!= nil)
    {
        [self.resultArray removeAllObjects];
    }
    self.resultArray = [NSMutableArray arrayWithArray:[_searchRangeArray filteredArrayUsingPredicate:preicate]];
    [self.tableView reloadData];
}

#pragma mark - searchBar Delegate
// 点击键盘上搜索按钮会调用该方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

// 点击取消按钮的回调方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}

@end
