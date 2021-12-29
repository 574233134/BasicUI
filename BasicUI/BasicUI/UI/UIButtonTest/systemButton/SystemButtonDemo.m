//
//  SystemButtonDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "SystemButtonDemo.h"

@interface SystemButtonDemo ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation SystemButtonDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"系统button属性方法练习";
    [self initDataArray];
    [self creatTableView];
}

- (void)initDataArray
{
    self.dataArray = [NSArray arrayWithObjects:@"ButtonTypeShow",@"ReadOnlyProperty",@"PureTextButton" ,@"ImageButton",nil];
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
