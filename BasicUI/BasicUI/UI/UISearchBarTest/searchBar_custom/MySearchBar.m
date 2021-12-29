//
//  MySearchBar.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/4.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "MySearchBar.h"
#define IS_IOS9 [[UIDevice currentDevice].systemVersion doubleValue] >= 9
@implementation MySearchBar

- (void)setTextFont:(UIFont *)font
{
    if (IS_IOS9)
    {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].font = font;
    }
    else
    {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:font];
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    if (IS_IOS9)
    {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = textColor;
    }
    else
    {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:textColor];
    }
}

- (void)setCancelButtonTitle:(NSString *)title
{
    if (IS_IOS9)
    {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:title];
    }
    else
    {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}

- (void)setCancelButtonFont:(UIFont *)font
{
    NSDictionary *textAttr = @{NSFontAttributeName : font};
    if (IS_IOS9)
    {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    }
    else
    {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    }
}

@end
