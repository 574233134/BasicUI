//
//  NavigationControllerDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/15.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "NavigationControllerDemo.h"
#import "SystemNavigationTest.h"
#import "MyNavigationViewController.h"
#import "EmptyViewController.h"

@interface NavigationControllerDemo ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation NavigationControllerDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"导航控制器demo"; //    self.navigationItem.title 与self.title 区别
    self.view.backgroundColor =[UIColor whiteColor];
    [self initDataArray];
    [self creatTableView];
}

- (void)initDataArray
{
    self.dataArray = [NSArray arrayWithObjects:@"SystemNavigationTest",@"MyNavigationViewController",nil];
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
    switch (indexPath.row)
    {
        case 0:
        {
            SystemNavigationTest *systemNVCTest = [[SystemNavigationTest alloc]init];
            [self.navigationController pushViewController:systemNVCTest animated:YES];
        }
            break;
        case 1:
        {
            EmptyViewController *vc = [EmptyViewController new];
            MyNavigationViewController *navigation = [[MyNavigationViewController alloc]initWithRootViewController:vc];
            [self presentViewController:navigation animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
}




@end
