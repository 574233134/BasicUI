//
//  PoperViewControllerTest.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/24.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "PoperViewControllerTest.h"

#define CELL_HEIGHT 45
#define POPER_WIDEH 175

@interface PoperViewControllerTest () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSInteger rowCount;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation PoperViewControllerTest

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 弹出视图风格
    self.modalPresentationStyle = UIModalPresentationPopover;
    self.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    self.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
}

- (void)loadCustomViewWithData:(NSArray *)dataArray
{
    self.dataArray = [NSArray arrayWithArray:dataArray];
    self.rowCount = [self.dataArray count];
    self.preferredContentSize = CGSizeMake(175, self.rowCount * CELL_HEIGHT);
    self.tableView.frame = CGRectMake(0, 0, POPER_WIDEH, CELL_HEIGHT * self.rowCount);
    [self.tableView reloadData];
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, POPER_WIDEH, CELL_HEIGHT * self.rowCount) style:UITableViewStylePlain];
    self.tableView.layer.cornerRadius = 6;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate actionViewClickedButtonAtIndex:indexPath.row title:[self.dataArray objectAtIndex:indexPath.row]];
    [self dismissViewControllerAnimated:NO completion:^{
    }];
}
@end
