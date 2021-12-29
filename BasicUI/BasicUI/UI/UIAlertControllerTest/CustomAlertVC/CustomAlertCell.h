//
//  CustomAlertCell.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/26.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomAlertAction;

typedef NS_ENUM(NSInteger,YXTableViewCellStyle) {
    YXTableViewCellStyleAlert = 0,
    YXTableViewCellStyleActionSheet
};

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlertCell : UITableViewCell
/**
 是否隐藏分割线 默认 NO
 */
@property (nonatomic, assign) BOOL isHidenLine;

/**
 标题
 */
@property (nonatomic, strong, nonnull) UILabel *titleLabel;

/**
 加载数据
 
 @param action 弹框动作
 */
- (void)loadDataWithAlertAction:(CustomAlertAction *_Nonnull)action;

- (instancetype _Nullable )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *_Nonnull)reuseIdentifier cellType:(YXTableViewCellStyle)type;
@end

NS_ASSUME_NONNULL_END
