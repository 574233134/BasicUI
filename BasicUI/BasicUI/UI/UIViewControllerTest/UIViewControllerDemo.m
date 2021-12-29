//
//  UIViewControllerDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/23.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "UIViewControllerDemo.h"
#import "SegueFirstViewController.h"
@interface UIViewControllerDemo ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation UIViewControllerDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"UIViewControllerDemo";
    [self loadData];
    [self creatTableView];
    self.restorationIdentifier = @"UIViewControllerDemo";
}

- (void)loadData
{
    self.dataArray = [NSArray arrayWithObjects:
                      @"ViewControllerLifeCircle",
                      @"ViewControllerChildVC",
                      @"OriginViewController",
                      @"SegueFirstViewController",
                      @"ModelFirstViewController",
                      @"ViewControllerPreView",
                      @"ViewControllerKeyBordCommand",
                      @"ViewControllerDirection",
                      @"ViewControllerRestoration",
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
    if (indexPath.row == 3)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"FirstSegueViewController" bundle:[NSBundle mainBundle]];
        SegueFirstViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"first"];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    UIViewController *viewController = [[NSClassFromString(self.dataArray[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
}



@end
