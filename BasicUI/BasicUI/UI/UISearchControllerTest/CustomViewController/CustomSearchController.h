//
//  CustomSearchController.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSearchBar.h"
@class CustomSearchController;

@protocol CustomSearchControllerDelegate <NSObject>

@optional

- (void)willPresentSearchController:(CustomSearchController *)searchController;
- (void)didPresentSearchController:(CustomSearchController *)searchController;
- (void)willDismissSearchController:(CustomSearchController *)searchController;
- (void)didDismissSearchController:(CustomSearchController *)searchController;

@end

@protocol CustomSearchControllerResultsUpdating <NSObject>

@required
- (void)updateSearchResultsForSearchController:(CustomSearchController *)searchController;

@end

@interface CustomSearchController : UIViewController

@property (nonatomic, strong) CustomSearchBar *searchBar;
@property (nonatomic, assign) BOOL hidesNavigationBarDuringPresentation;
@property (nonatomic, weak) id<CustomSearchControllerDelegate> delegate;
@property (nonatomic, weak) id<CustomSearchControllerResultsUpdating> searchResultsUpdater;
@property (nonatomic, strong) UIViewController *searchResultsController;

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController;

@end
