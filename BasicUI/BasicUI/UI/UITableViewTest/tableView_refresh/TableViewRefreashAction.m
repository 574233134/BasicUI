//
//  TableViewRefreashAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/12.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TableViewRefreashAction.h"
#import <MJRefresh.h>
#import "DIY/MYDIYGifHeader.h"
#import "UIViewController+example.h"
#import "DIY/MYDIYRefreshControls.h"
#import "DIY/MYDIYAutoGifFooter.h"
#import "DIY/MYDIYBackGifFooter.h"
#import "DIY/MJDIYAutoFooter.h"
#import "DIY/MJDIYBackFooter.h"
#define RefreashRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
#define duration 2
@interface TableViewRefreashAction ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation TableViewRefreashAction

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatTableView];
    [self performSelector:NSSelectorFromString(self.method) withObject:nil];
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView DataSource
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

#pragma mark - 数据相关

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
        for (int i=0; i<5; i++)
        {
            [self.dataArray addObject:RefreashRandomData];
        }
    }
    return _dataArray;
}

/** 下拉加载数据 */
- (void)loadNewData
{
    for (int i=0; i<5; i++)
    {
        [self.dataArray addObject:RefreashRandomData];
    }
    __weak typeof (self) wekself = self;
    // 模拟网络请求加载数据的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wekself.tableView reloadData];
        [wekself.tableView.mj_header endRefreshing];
    });
}

/** 上拉加载数据 */
- (void)loadMoreData
{
    for (int i=0; i<5; i++)
    {
        [self.dataArray addObject:RefreashRandomData];
    }
    __weak typeof (self) wekself = self;
    // 模拟网络请求加载数据的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wekself.tableView reloadData];
        [wekself.tableView.mj_footer endRefreshing];
    });
}

/** 加载最后一份数据 */
- (void)loadLastData
{
    for (int i=0; i<5; i++)
    {
        [self.dataArray addObject:RefreashRandomData];
    }
    __weak typeof (self) wekself = self;
    // 模拟网络请求加载数据的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wekself.tableView reloadData];
        [wekself.tableView.mj_footer endRefreshingWithNoMoreData];
    });
}

/** 只加载一次h数据 */
- (void)loadOnceData
{
    for (int i=0; i<5; i++)
    {
        [self.dataArray addObject:RefreashRandomData];
    }
    __weak typeof (self) wekself = self;
    // 模拟网络请求加载数据的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wekself.tableView reloadData];
        wekself.tableView.mj_footer.hidden = YES;
    });
}

#pragma mark - 下拉刷新 示例
/** 下拉刷新: 默认 */
- (void)example01
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

/** 下拉刷新: 动画图片 */
- (void)example02
{
    
    self.tableView.mj_header = [MYDIYGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    [self.tableView.mj_header beginRefreshing];
}

/** 下拉刷新: 隐藏时间 */
- (void)example03
{

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header beginRefreshing];

    self.tableView.mj_header = header;
}

/** 下拉刷新: 隐藏状态和时间 */
- (void)example04
{
    MYDIYGifHeader *header = [MYDIYGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    [header beginRefreshing];
    
    self.tableView.mj_header = header;
}

/** 下拉刷新: 自定义文字 */
- (void)example05
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    [header beginRefreshing];
    
    self.tableView.mj_header = header;
}

/** 下拉刷新: 自定义刷新控件 */
- (void)example06
{
    self.tableView.mj_header = [MYDIYRefreshControls headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 上拉刷新
/** 上拉刷新: 默认 */
- (void)example11
{
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

/** 上拉刷新: 动画图片 */
- (void)example12
{
    self.tableView.mj_footer = [MYDIYAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

/** 上拉刷新: 隐藏刷新状态的文字 */
- (void)example13
{
    MYDIYAutoGifFooter *footer = [MYDIYAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（默认上拉控件100%出现时，才会自动刷新）
    footer.triggerAutomaticallyRefreshPercent = 0.5;
    footer.refreshingTitleHidden = YES;
    self.tableView.mj_footer = footer;
}

/** 上拉刷新: 全部加载完毕 */
- (void)example14
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"恢复数据加载" style:UIBarButtonItemStyleDone target:self action:@selector(reset)];
}

- (void)reset
{
    [self.tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.tableView.mj_footer resetNoMoreData];
}

/** 上拉刷新: 禁止自动加载 */
- (void)example15
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    // 禁止自动加载
    footer.automaticallyRefresh = NO;

    self.tableView.mj_footer = footer;
}

/** 上拉刷新: 自定义文字 */
- (void)example16
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    footer.stateLabel.textColor = [UIColor blueColor];
    self.tableView.mj_footer = footer;
}

/** 上拉刷新: 加载后隐藏 */
- (void)example17
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOnceData)];
}

/** 上拉刷新: 自动回弹的上拉01 */
- (void)example18
{
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置了底部inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    
    // 忽略掉底部inset
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
}

/** 上拉刷新: 自动回弹的上拉02 */
- (void)example19
{
    self.tableView.mj_footer = [MYDIYBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
}

/** 上拉刷新: 自定义刷新控件(自动刷新) */
- (void)example20
{
    self.tableView.mj_footer = [MJDIYAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

/** 上拉刷新: 自定义刷新控件(自动回弹) */
- (void)example21
{
    self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

@end
