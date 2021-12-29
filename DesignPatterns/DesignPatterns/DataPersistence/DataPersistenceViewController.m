//
//  DataPersistenceViewController.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/4.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "DataPersistenceViewController.h"

@interface DataPersistenceViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation DataPersistenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self creatTableView];
    
}

- (void)loadData
{
    self.dataArray = [NSArray arrayWithObjects:
                      @"UserDefaultsStoreDemo",
                      @"PlistStoreViewController",
                      @"ArchiveUseageViewController",
                      @"SQL3DemoViewController",
                      @"FMDBDemoViewController",
                      @"CoreDataDemo",
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
    UIViewController *viewController = [[NSClassFromString(self.dataArray[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}



@end
