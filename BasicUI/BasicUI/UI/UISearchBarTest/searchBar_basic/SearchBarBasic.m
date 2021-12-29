//
//  SearchBarBasic.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/30.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "SearchBarBasic.h"
#import "UIView+frame.h"
@interface SearchBarBasic ()<UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation SearchBarBasic

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"搜索框基础";
    [self loadSearchBarSetting];
    self.view.backgroundColor = [UIColor cyanColor];
}

/**
 * searBar 属性
 * placeholder: 提示文字
 */
- (void)loadSearchBarSetting
{
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    self.searchBar.searchBarStyle = UISearchBarStyleProminent;
}

#pragma mark - xib action
/** barStyle: 设置搜索框风格 */
- (IBAction)setSearchBarStyle:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.searchBar.barStyle = UIBarStyleDefault;
            break;
        case 1:
            self.searchBar.barStyle = UIBarStyleBlack;
            break;
    }
}

/** showsBookmarkButton: 是否在右侧展示书本标记 */
- (IBAction)isShowBookmarkBtn:(UISwitch *)sender
{
    self.searchBar.showsBookmarkButton = sender.on;
}

/** showsCancelButton: 是否展示取消按钮 */
- (IBAction)isShowCancleBtn:(UISwitch *)sender
{
    self.searchBar.showsCancelButton = sender.on;
}

/** showsSearchResultsButton: 是否展示搜索结果按钮 */
- (IBAction)isShowSearchResultBtn:(UISwitch *)sender
{
    self.searchBar.showsSearchResultsButton = sender.on;
}

/** searchResultsButtonSelected: 设置搜索结果按钮是否选中 */
- (IBAction)setSearchResulysBtnIsSelected:(UISwitch *)sender
{
    self.searchBar.searchResultsButtonSelected = sender.on;
}

/** tintColor: 更改光标及取消按钮颜色 */
- (IBAction)changeTincolor:(UIButton *)sender
{
    self.searchBar.tintColor = [UIColor redColor];
}

/** barTintColor: 更改搜索框边框颜色 */
- (IBAction)changeBarTintColor:(UIButton *)sender
{
    self.searchBar.barTintColor = [UIColor orangeColor];
}

/** 展示搜索框的附件选择视图 */
- (IBAction)showScopeBar:(UIButton *)sender
{
    self.searchBar.showsScopeBar = YES;
    self.searchBar.scopeButtonTitles = @[@"1",@"2",@"3"];
    self.searchBar.selectedScopeButtonIndex = 1;
}

/** 设置搜索框的背景图 */
- (IBAction)setSearchBarBackgroundImage:(UIButton *)sender
{
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"searchBarBG"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

/** 设置scopeBar的背景图片 */
- (IBAction)setScopeBarBackgroundImage:(UIButton *)sender
{
    [self.searchBar setScopeBarBackgroundImage:[UIImage imageNamed:@"scopeBarBG"]];
}

/** setSearchFieldBackgroundImage 该方法设置的背景区域过大 */
- (IBAction)setTextFieldBackgroungImage:(UIButton *)sender
{
    UITextField *searchField = [self.searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = [UIColor cyanColor];
//    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"textfieldBG"] forState:UIControlStateNormal];
}

/** 设置搜索icon(UISearchBarIconBookmark等也可设置) */
- (IBAction)setSearchIcon:(UIButton *)sender
{
    [self.searchBar setImage:[UIImage imageNamed:@"searchIcon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
}

/** 设置scopeTitle 某个状态下的背景图 */
- (IBAction)setScopeBtnBackgroundImage:(UIButton *)sender
{
    [self.searchBar setScopeBarButtonBackgroundImage:[UIImage imageNamed:@"scopeBtnBG"] forState:UIControlStateNormal];
}

/** 设置scopeBar 分隔线背景 */
- (IBAction)setScopeBarSperectorImage:(UIButton *)sender
{
    [self.searchBar setScopeBarButtonDividerImage:[UIImage imageNamed:@"sperector"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected];
}

/** 设置scopeTitle 的富文本属性 */
- (IBAction)setScopeTitleAttribute:(UIButton *)sender
{
    NSDictionary *attubites = @{NSForegroundColorAttributeName:[UIColor redColor],
                                NSBackgroundColorAttributeName:[UIColor greenColor]};

    [self.searchBar setScopeBarButtonTitleTextAttributes:attubites forState:UIControlStateSelected];
}

#pragma mark - searchBarDelegate
/** 是否允许searchBar编辑 */
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

/** searchBar 已经开始编辑时调用 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBar 开始编辑");
}

/** 是否允许结束编辑 */
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    return YES;
}

/** 结束编辑时调用 */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBar 结束编辑");
}

/** 文字改变时调用 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"文字改变，当前文字是：%@",searchText);
}

/**
 * 文字改变前会调用该方法，返回NO则不能加入新的编辑文字
 * 当使用自动更正功能，把输入的文字修改为推荐的文字时，就会调用这个方法。
 * 可以跟踪字段内所做的最后一次修改，也可以对所有编辑做日志记录。
 * 这个方法的参数中有一个NSRange对象，指明了被改变文字的位置。建议修改的文本也在其中
 *
 */
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"%@",text);
    return YES;
}

/** 搜索按钮被按下时调用 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSLog(@"按下搜索按钮");
}

/** 书本按钮按下时调用 */
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED
{
     NSLog(@"按下书本按钮");
}

/** 取消按钮按下时调用 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED
{
     NSLog(@"按下取消按钮");
}

/** 搜索结果按钮按下时调用 */
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED
{
     NSLog(@"按下搜索结果按钮");
}

/** scopeBtn 选中项改变时调用该方法 */
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"scope 的当前选中项为：%lu",selectedScope);
}


@end
