//
//  SystemCellStylePresentationViewController.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/9.
//  Copyright © 2018 李梦珂. All rights reserved.
//
/**
 * 展示系统自带的tableViewCell 样式 （四种）
 *
 * 1. default 左侧图片（不设置图片默认为nil） 图片右侧为标题
 * 2. SubTitle 左侧图片（不设置图片默认为nil）图片右侧为标题 标题下方为副标题，标题及副标题颜色一致为黑色，并且标题和副标题左对齐
 * 3. Value1 左侧图片（不设置图片默认为nil） 图片右侧为标题 最右侧为副标题靠近cell最右侧，副标题（淡灰色）与标题（黑色）颜色不一致
 * 4. Value2  左侧为标题（蓝色），标题右侧为副标题（黑色）
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SystemCellStylePresentationViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
