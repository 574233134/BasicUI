//
//  CustomSearchBar.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSearchBar;

@protocol CustomSearchBarDelegate <NSObject>

@optional
- (void)searchBarTextDidBeginEditing:(CustomSearchBar *)searchBar;
- (void)searchBarTextDidEndEditing:(CustomSearchBar *)searchBar;
- (void)searchBar:(CustomSearchBar *)searchBar textDidChange:(NSString *)searchText;

@end
@interface CustomSearchBar : UIView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, weak) id <CustomSearchBarDelegate> delegate;
@property (nonatomic, strong) NSString *text;

@end
