//
//  UILabelDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "UILabelDemo.h"

@interface UILabelDemo ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation UILabelDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"UILabelDemo";
    self.view.backgroundColor =[UIColor whiteColor];
    [self initDataArray];
    [self creatTableView];
}

- (void)initDataArray
{
    self.dataArray = [NSArray arrayWithObjects:@"SystemLabelViewController", @"CustomLabelViewController",nil];
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
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newVC = [[NSClassFromString(self.dataArray[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:newVC animated:YES];
}


@end
