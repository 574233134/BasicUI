//
//  CustomLabel.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/10.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLabel : UILabel

@property (assign, nonatomic) UIEdgeInsets edgeInsets;


/**
 *  给label中的特殊字添加颜色（keyword 出现的每一个字符 只要Label中的文字有该字符 字符就会标记为所设置的颜色）
 *
 *  @parm keyWords 需要改变颜色的文字
 *  @parm color 文字标注的颜色
 **/
- (void)expicalWords:(NSString *)keyWords color:(UIColor *)color;


/**
 *  给label中的特殊字添加颜色（只要Label中的含有keyword keyword就会标记为所设置的颜色）
 *
 *  @parm keyWords 需要改变颜色的文字
 *  @parm color 文字标注的颜色
 **/
- (void)containWords:(NSString *)keyWords color:(UIColor *)color;

/**
 * 自适应宽度
 *
 * @parm string 字符串
 * @parm height 高度
 * @parm font 文字大小
 */
- (CGFloat)calculateRowWidthString:(NSString *)string withHeight:(CGFloat)height andFont:(UIFont *)font;

/**
 * 自适应高度
 *
 * @parm string 字符串
 * @parm width 宽度
 * @parm font 文字大小
 */
- (CGFloat)calculateRowHeightString:(NSString *)string withWidth:(CGFloat)width andFont:(UIFont *)font;
@end
