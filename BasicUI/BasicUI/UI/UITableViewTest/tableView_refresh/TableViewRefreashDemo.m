//
//  TableViewRefreashDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/12.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TableViewRefreashDemo.h"
#import "RefrshExample.h"
#import "UIViewController+example.h"
#import "TableViewRefreashAction.h"

@interface TableViewRefreashDemo ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *examples;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation TableViewRefreashDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MJRefrash演示";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
}

#pragma mark - 数据
- (NSArray *)examples
{
    if (!_examples) {
        RefrshExample *exam0 = [[RefrshExample alloc] init];
        exam0.header = @"下拉刷新";
        exam0.vcClass = [TableViewRefreashAction class];
        exam0.titles = @[@"默认", @"动画图片", @"隐藏时间", @"隐藏状态和时间", @"自定义文字", @"自定义刷新控件"];
        exam0.methods = @[@"example01", @"example02", @"example03", @"example04", @"example05", @"example06"];
        
        RefrshExample *exam1 = [[RefrshExample alloc] init];
        exam1.header = @"上拉刷新";
        exam1.vcClass = [TableViewRefreashAction class];
        exam1.titles = @[@"默认", @"动画图片", @"隐藏刷新状态的文字", @"全部加载完毕", @"禁止自动加载", @"自定义文字", @"加载后隐藏", @"自动回弹的上拉01", @"自动回弹的上拉02", @"自定义刷新控件(自动刷新)", @"自定义刷新控件(自动回弹)"];
        exam1.methods = @[@"example11", @"example12", @"example13", @"example14", @"example15", @"example16", @"example17", @"example18", @"example19", @"example20", @"example21"];
        
        self.examples = @[exam0, exam1];
    }
    return _examples;
}

#pragma mark - tableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.examples.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RefrshExample *exam = self.examples[section];
    return exam.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"example";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    
    RefrshExample *exam = self.examples[indexPath.section];
    cell.textLabel.text = exam.titles[indexPath.row];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", exam.vcClass, exam.methods[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    RefrshExample *exam = self.examples[section];
    return exam.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RefrshExample *exam = self.examples[indexPath.section];
    UIViewController *vc = [[exam.vcClass alloc] init];
    vc.title = exam.titles[indexPath.row];
    [vc setValue:exam.methods[indexPath.row] forKeyPath:@"method"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
