//
//  ViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "ViewController.h"
#import "SearchControllerDemo.h"
#import "NavigationControllerDemo.h"
#import "UILabelDemo.h"
#import "UIAlertViewControllerDemo.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"BasicUI";
    [self.navigationController setToolbarHidden:YES];
    self.view.backgroundColor =[UIColor whiteColor];
    [self initDataArray];
    [self creatTableView];
    self.restorationIdentifier = @"homeVC";
}


//代码较长时,考虑缩进
- (void)initDataArray
{
    self.dataArray = [NSArray arrayWithObjects:@"SearchControllerDemo",
                      @"NavigationControllerDemo",
                      @"UILabelDemo",
                      @"ButtonDemoViewController",
                      @"UITabbarViewControllerDemo",
                      @"UIAlertViewControllerDemo",
                      @"UISwitchDemo",
                      @"UISliderDemo",
                      @"UITableViewDemo",
                      @"UICollectionViewDemo",
                      @"UIWebViewDemo",
                      @"WKWebViewViewDemo",
                      @"UIScrollerViewDemo",
                      @"UISearchBarDemo",
                      @"UISegmentControlDemo",
                      @"UITextFieldDemo",
                      @"TextViewDemo",
                      @"UIImageViewDemo",
                      @"UIViewDemo",
                      @"UIPickerViewDemo",
                      @"UIDatePickerDemo",
                      @"UIViewControllerDemo",
                      @"ColorViewController",
                      @"UIBezierPathDisplay",
                      @"UIFontDemo",
                      @"UIImageDemo",
                      @"AttributedStringDemo",
                      @"CALayerDemo",
                      @"GenerateQRCodeViewController",
                      nil];
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.tableView];
}

// 添加代码块注释（pragma mark -），增加代码可读性
#pragma mark - tablevew delegate
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
