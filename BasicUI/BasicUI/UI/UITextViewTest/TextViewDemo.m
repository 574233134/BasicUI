//
//  TestViewDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/9.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TextViewDemo.h"

@interface TextViewDemo () <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation TextViewDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"textView功能";
    [self loadData];
    [self creatTableView];
}

- (void)loadData
{
    self.dataArray = [[NSArray alloc]initWithObjects:
                      @"TextViewBasic",
                      @"TextViewCustom",
                      nil];
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
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
