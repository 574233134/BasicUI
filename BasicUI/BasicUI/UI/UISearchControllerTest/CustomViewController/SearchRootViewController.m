//
//  SearchRootViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "SearchRootViewController.h"
#import "CustomSearchController.h"
#import "CusSearchResultVC.h"
#import "UIView+frame.h"
#define kSafeAreaNavHeight (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO) ? 88 : 64)
@interface SearchRootViewController ()<UITableViewDataSource, UITableViewDelegate, CustomSearchControllerResultsUpdating, CustomSearchControllerDelegate, CustomSearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CustomSearchController *searchController;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SearchRootViewController

static NSString *CellIdentifier = @"cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"自定义搜索控制器";
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Home click index: %zd", indexPath.row);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    if (y < - kSafeAreaNavHeight + self.searchController.searchBar.height)
    {
        if (y < - kSafeAreaNavHeight + self.searchController.searchBar.height * 0.5)
        {
            [self.tableView setContentOffset:CGPointMake(0, - kSafeAreaNavHeight) animated:YES];
        }
        else
        {
            [self.tableView setContentOffset:CGPointMake(0, - kSafeAreaNavHeight + self.searchController.searchBar.height) animated:YES];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat y = scrollView.contentOffset.y;
    if (y < - kSafeAreaNavHeight + self.searchController.searchBar.height)
    {
        if (y < - kSafeAreaNavHeight + self.searchController.searchBar.height * 0.5)
        {
            [self.tableView setContentOffset:CGPointMake(0, - kSafeAreaNavHeight) animated:YES];
        }
        else
        {
            [self.tableView setContentOffset:CGPointMake(0, - kSafeAreaNavHeight + self.searchController.searchBar.height) animated:YES];
        }
    }
}

#pragma mark - JKRSearchControllerhResultsUpdating
- (void)updateSearchResultsForSearchController:(CustomSearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)", searchText];
    CusSearchResultVC *resultController = (CusSearchResultVC *)searchController.searchResultsController;
    if (!(searchText.length > 0)) resultController.filterDataArray = @[];
    else resultController.filterDataArray = [self.dataArray filteredArrayUsingPredicate:predicate];
}

#pragma mark - JKRSearchControllerDelegate
- (void)willPresentSearchController:(CustomSearchController *)searchController
{
    NSLog(@"willPresentSearchController, %@", searchController);
}

- (void)didPresentSearchController:(CustomSearchController *)searchController
{
    NSLog(@"didPresentSearchController, %@", searchController);
}

- (void)willDismissSearchController:(CustomSearchController *)searchController
{
    NSLog(@"willDismissSearchController, %@", searchController);
}

- (void)didDismissSearchController:(CustomSearchController *)searchController
{
    NSLog(@"didDismissSearchController, %@", searchController);
}

#pragma mark - JKRSearchBarDelegate
- (void)searchBarTextDidBeginEditing:(CustomSearchBar *)searchBar
{
    NSLog(@"searchBarTextDidBeginEditing %@", searchBar);
}

- (void)searchBarTextDidEndEditing:(CustomSearchBar *)searchBar
{
    NSLog(@"searchBarTextDidEndEditing %@", searchBar);
}

- (void)searchBar:(CustomSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"searchBar:%@ textDidChange:%@", searchBar, searchText);
}

#pragma mark - lazy load
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}

- (CustomSearchController *)searchController
{
    if (!_searchController)
    {
        CusSearchResultVC *resultSearchController = [[CusSearchResultVC alloc] init];
        _searchController = [[CustomSearchController alloc] initWithSearchResultsController:resultSearchController];
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.delegate = self;
        _searchController.delegate = self;
    }
    return _searchController;
}

- (NSArray<NSString *> *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc]init];
        for (int i=0; i<50; i++)
        {
            [_dataArray addObject:[NSString stringWithFormat:@"测试数据列表%d",i]];
        }
    }
    return _dataArray;
}


@end
