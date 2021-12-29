//
//  CustomSearchBarDisplayViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/4.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomSearchBarDisplayViewController.h"
#import "MySearchBar.h"
#import "BasicUIDemo.h"
@interface CustomSearchBarDisplayViewController ()<UISearchBarDelegate>

@property (strong, nonatomic)MySearchBar *searchBar;


@end

@implementation CustomSearchBarDisplayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义searchBar";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatCustomSearchBar];
}

- (void)creatCustomSearchBar
{
    self.searchBar = [[MySearchBar alloc]initWithFrame:CGRectMake(15, 100, SCREEN_WIDTH-30, 44)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    /** 设置背景颜色,设置背景图是为了去掉上下黑线 */
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    /** 设置SearchBar的颜色主题为白色 */
    self.searchBar.barTintColor = [UIColor whiteColor];
    
    /** 设置圆角和边框颜色 */
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    if (searchField)
    {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.borderColor = [UIColor colorWithRed:247/255.0 green:75/255.0 blue:31/255.0 alpha:1].CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
    }
    
    /** 设置按钮文字和颜色 */
    [self.searchBar setCancelButtonTitle:@"取消"];
    self.searchBar.tintColor = [UIColor colorWithRed:247/255.0 green:75/255.0 blue:31/255.0 alpha:1];
    /** 设置取消按钮字体 */
    [self.searchBar setCancelButtonFont:[UIFont systemFontOfSize:22]];
    /** 设置光标颜色 */
    [searchField setTintColor:[UIColor blackColor]];
    
    /** 设置输入框文字颜色和字体 */
    [self.searchBar setTextColor:[UIColor blackColor]];
    [self.searchBar setTextFont:[UIFont systemFontOfSize:14]];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar endEditing:YES];
}

@end
