//
//  StringDemoViewController.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/14.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "StringDemoViewController.h"

@interface StringDemoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableString *testStr;

@end

@implementation StringDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"字符串相关操作";
    [self loadData];
    [self createReloadBtn];
    [self creatTableView];
}

- (void)loadData
{
    self.testStr = [NSMutableString stringWithString:@"smnsdDbrVmcGk vNjoibjnk"];
    self.dataArray = [NSArray arrayWithObjects:
                      @"字符串子串from3",
                      @"字符串子串To7",
                      @"字符串子串range(1,3)",
                      @"字符串index=8的字符",
                      @"字符串与a比较",
                      @"字符串与z比较",
                      @"大写A与小写a比较",
                      @"大写A与小写a忽略大小写比较",
                      @"字符串是否与a相等比较",
                      @"字符串是否有前缀smn",
                      @"字符串是否有后缀bjn",
                      @"字符串是否包含sDb",
                      @"字符串忽略大小写是否包含sDb",
                      @"字符串Vmc所在位置",
                      @"字符串大写",
                      @"字符串小写",
                      @"字符串首字母大写",
                      @"字符串所有的s替换为a",
                      @"字符串insert 111 at 8",
                      @"字符串append, test",
                      @"字符串delete,range(1,3)",
                      nil];
}

- (void)createReloadBtn
{
    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc]initWithTitle:@"重置" style:UIBarButtonItemStyleDone target:self action:@selector(reloadTableViewData)];
    self.navigationItem.rightBarButtonItem = reloadItem;
}

- (void)reloadTableViewData
{
    self.testStr = [NSMutableString stringWithString:@"smnsdDbrVmcGk vNjoibjnk"];
    [self.tableView reloadData];
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
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    cell.detailTextLabel.text = self.testStr;
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            [self alertWithTitle:cell.textLabel.text message:[self.testStr substringFromIndex:3]];
        }
            break;
        case 1:
        {
            [self alertWithTitle:cell.textLabel.text message:[self.testStr substringToIndex:7]];
        }
            break;
        case 2:
        {
            [self alertWithTitle:cell.textLabel.text message:[self.testStr substringWithRange:NSMakeRange(1, 3)]];
        }
            break;
        case 3:
        {
            [self alertWithTitle:cell.textLabel.text message:[NSString stringWithFormat:@"%c",[self.testStr characterAtIndex:8]]];
            
            
        }
            break;
        case 4:
        {
            [self alertWithTitle:cell.textLabel.text message:[NSString stringWithFormat:@"%ld",(long)[self.testStr compare:@"a"]]];
        }
            break;
        case 5:
        {
            [self alertWithTitle:cell.textLabel.text message:[NSString stringWithFormat:@"%ld",(long)[self.testStr compare:@"z"]]];
        }
            break;
        case 6:
        {
            NSString *Astr = @"A";
            [self alertWithTitle:cell.textLabel.text message:[NSString stringWithFormat:@"%ld",(long)[Astr compare:@"a"]]];
        }
            break;
        case 7:
        {
            NSString *Astr = @"A";
            [self alertWithTitle:cell.textLabel.text message:[NSString stringWithFormat:@"%ld",(long)[Astr caseInsensitiveCompare:@"a"]]];
        }
            break;
        case 8:
        {
            [self alertWithTitle:cell.textLabel.text message:[NSString stringWithFormat:@"%d",[self.testStr isEqualToString:@"a"]]];
        }
        case 9:
        {
            [self alertWithTitle:cell.textLabel.text message:[NSString stringWithFormat:@"%d",[self.testStr hasPrefix:@"smn"]]];
        }
        case 10:
        {
             [self alertWithTitle:cell.textLabel.text message:[NSString stringWithFormat:@"%d",[self.testStr hasSuffix:@"bjn"]]];
        }
        case 11:
        {
            [self alertWithTitle:cell.textLabel.text message:[NSString stringWithFormat:@"%d",[self.testStr containsString:@"sDb"]]];
        }
        case 12:
        {
            [self alertWithTitle:cell.textLabel.text message:[NSString stringWithFormat:@"%d",[self.testStr localizedCaseInsensitiveContainsString:@"sDb"]]];
        }
        case 13:
        {
            NSRange range = [self.testStr rangeOfString:@"Vmc"];
            [self alertWithTitle:cell.textLabel.text message:NSStringFromRange(range)];
        }
        case 14:
        {
            [self alertWithTitle:cell.textLabel.text message:[self.testStr uppercaseString]];
        }
        case 15:
        {
            [self alertWithTitle:cell.textLabel.text message:[self.testStr lowercaseString]];
        }
        case 16:
        {
            [self alertWithTitle:cell.textLabel.text message:[self.testStr capitalizedString]];
        }
        case 17:
        {
            NSRange range = NSMakeRange(0, self.testStr.length);
            [self.testStr replaceOccurrencesOfString:@"s" withString:@"a" options:NSCaseInsensitiveSearch range:range];
            [self alertWithTitle:cell.textLabel.text message:self.testStr];
            
        }
        case 18:
        {
            [self.testStr insertString:@"111" atIndex:8];
            [self alertWithTitle:cell.textLabel.text message:self.testStr];
        }
        case 19:
        {
            [self.testStr appendString:@"test"];
            [self alertWithTitle:cell.textLabel.text message:self.testStr];
        }
        case 20:
        {
            [self.testStr deleteCharactersInRange:NSMakeRange(1, 3)];
            [self alertWithTitle:cell.textLabel.text message:self.testStr];
        }
        default:
            break;
    }
    self.testStr = [NSMutableString stringWithString:@"smnsdDbrVmcGk vNjoibjnk"];
}

#pragma mark - 警告框
-(void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}


@end
