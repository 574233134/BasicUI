//
//  CustomTabbarItem.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMKBadgeValue.h"
#import "TabbarBaseConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomTabbarItem : UIView

/** 图片 */
@property (nonatomic, strong) UIImageView *imageView;
/** 标题 */
@property (nonatomic, strong) UILabel *title;
/** badgeValue */
@property (nonatomic, strong) LMKBadgeValue *badgeValue;
/** type */
@property (nonatomic, assign) LMKConfigTypeLayout typeLayout;

@end

NS_ASSUME_NONNULL_END
