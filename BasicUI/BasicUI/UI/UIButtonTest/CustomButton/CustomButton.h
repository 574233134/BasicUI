//
//  CustomButton.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CustomButtonImagePosition)
{
    CustomButtonImagePositionTop,
    CustomButtonImagePositionLeft,
    CustomButtonImagePositionBottom,
    CustomButtonImagePositionRight
};

@interface CustomButton : UIButton

@property (assign, nonatomic) CGFloat titleImageSpacing; //title 和 image的间距
@property (assign, nonatomic) CustomButtonImagePosition imagePosition; //图片的相对位置
@property (assign, nonatomic) CGFloat imageCornerRadius;   // 图片圆角半径

@end
