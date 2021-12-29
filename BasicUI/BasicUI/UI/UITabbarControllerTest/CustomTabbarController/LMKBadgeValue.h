//
//  LMKBadgeValue.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LMKBadgeValueType) {
    LMKBadgeValueTypePoint, //点
    LMKBadgeValueTypeNew, //new
    LMKBadgeValueTypeNumber, //number
};

NS_ASSUME_NONNULL_BEGIN

@interface LMKBadgeValue : UIView

/** badgeL */
@property (nonatomic, strong) UILabel *badgeL;

@property (nonatomic, strong) UIImageView *bgImageView;

/** type */
@property (nonatomic, assign) LMKBadgeValueType type;

@end

NS_ASSUME_NONNULL_END
