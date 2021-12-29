//
//  SystemSearchViewController.m
//  BasicUIDemo
//
//  Created by 李梦珂 on 2018/8/1.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "SystemSearchViewController.h"
#import "SearchResultViewController.h"

#define STATEBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVIGATIONBAR_HEIGHT  self.navigationController.navigationBar.frame.size.height
static NSString *identify = @"cell";

@interface SystemSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>

@property (strong, nonatomic) UISearchController *systemSearchController; //8.0 之后的控件

@property (strong, nonatomic) SearchResultViewController *resultVC;

@property (strong, nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *firstList;

@end

@implementation SystemSearchViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.title = @"系统搜索控制器";
    [self initDataArray];
    [self creatTableView];
    [self initSearchControllerConfig];
}

- (void)initDataArray
{
    _firstList = [[NSMutableArray alloc]init];
    for (int i=0; i<50; i++)
    {
        [_firstList addObject:[NSString stringWithFormat:@"测试数据列表%d",i]];
    }
}

- (void) creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
}

#pragma mark - 初始化搜索控制器信息
/*
 * initWithSearchResultsController (nullable UIViewController *)
 * 参数为空，表示使用当前控制器作为展示结果的控制器。否则，使用指定的控制器作为显示结果的控制器
 * 一、 UISearchController 属性
 * 以下三个属性默认值都为YES
 * 1. dimsBackgroundDuringPresentation 搜索时，背景是否变暗色
 * 2. obscuresBackgroundDuringPresentation 开始搜索时背景是否显示
 * 3. hidesNavigationBarDuringPresentation 点击搜索的时候,是否隐藏导航栏
 *
 * 二、 UISearchBar属性
 * 1. barTintColor 搜索框的北京色
 * 2. valueForKey:@"_searchField" 可拿到中间的输入框对其进行设置
 */
- (void)initSearchControllerConfig
{
    self.resultVC = [[SearchResultViewController alloc]init];
    self.systemSearchController = [[UISearchController alloc]initWithSearchResultsController:self.resultVC];
    self.resultVC.systemSearchController = self.systemSearchController;
    self.systemSearchController.delegate = self;
    self.definesPresentationContext = YES;
    UIView *view = [[UIView alloc]initWithFrame:self.systemSearchController.searchBar.frame];
    view.backgroundColor = [UIColor whiteColor];
    
    self.systemSearchController.dimsBackgroundDuringPresentation = YES;
    if (@available(iOS 9.1, *)) {
        self.systemSearchController.obscuresBackgroundDuringPresentation = YES;
    } else {
        // Fallback on earlier versions
    }
    self.systemSearchController.hidesNavigationBarDuringPresentation = YES;
    
    self.systemSearchController.searchBar.barTintColor = [UIColor whiteColor];
    self.systemSearchController.searchBar.layer.borderWidth = 1;
    self.systemSearchController.searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    [view addSubview:self.systemSearchController.searchBar];
    self.tableView.tableHeaderView = view;
    
    UITextField *searchTextField = [self.systemSearchController.searchBar valueForKey:@"_searchField"];
    searchTextField.backgroundColor = [UIColor groupTableViewBackgroundColor];
    searchTextField.layer.masksToBounds = YES;
}

#pragma mark - tableView dataSource (required)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _firstList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = _firstList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


# pragma mark - SearchController Delegate
/*
 * 当搜索结果页自动显示或消失时，将调用这些方法。如果自己呈现或dismiss搜索控制器，以下四个方法将不会被调用。
 */

// 结果视图控制器即将出现时调用该方法（可在此处对取消按钮进行设置）
- (void)willPresentSearchController:(UISearchController *)searchController
{
    searchController.searchBar.showsCancelButton = YES;
    for(UIView *view in  [[[searchController.searchBar subviews] objectAtIndex:0] subviews])
    {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]])
        {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTintColor:[UIColor redColor]];
        }
        else
        {
            NSLog(@"noResult");
        }
    }
    NSLog(@"结果控制器即将出现时搜索框的frame：%@",NSStringFromCGRect(searchController.searchBar.frame));
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"结果控制器已经出现时搜索框的frame：%@",NSStringFromCGRect(searchController.searchBar.frame));
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"结果控制器即将消失时搜索框的frame：%@",NSStringFromCGRect(searchController.searchBar.frame));
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"结果控制器已经消失时搜索框的frame：%@",NSStringFromCGRect(searchController.searchBar.frame));
}

/*
 * 当搜索控制器的搜索栏同意开始编辑或“active”设置为YES时调用。如果选择自己不亲自呈现控制器或不实现此方法，则执行默认操作。
 */
- (void)presentSearchController:(UISearchController *)searchController
{
    
}

@end
