//
//  MySearchBar.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/4.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySearchBar : UISearchBar

- (void)setTextFont:(UIFont *)font;
- (void)setTextColor:(UIColor *)textColor;
- (void)setCancelButtonTitle:(NSString *)title;
/**
 *  设置取消按钮字体
 *
 *  @param font 字体
 */
- (void)setCancelButtonFont:(UIFont *)font;

@end
