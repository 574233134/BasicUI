//
//  LMKSegement.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSegmentDelegate <NSObject>

- (void)customSegmentedValueChanged:(UISegmentedControl *)segment;

@end

@interface LMKSegement : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) id<CustomSegmentDelegate> delegate;

@property (nonatomic, strong) UIScrollView * customScr;

@property (nonatomic, strong) NSArray * titleArr;

@property (nonatomic, strong) UIFont * fontSize;

@property (nonatomic, assign) float View_W;

@property (nonatomic, assign) float itmeViewW;

/**
  * @pram background          背景色
  * @pram titleArr            文字Ary
  * @pram fontSize            文字Normal大小（选中时会+2）
  * @pram titleSelectColor    文字Select颜色
  * @pram normalColor         文字Normal颜色
  * @pram index               初始选中
  */
- (void)setSegmentWithBackground:(UIColor *)background titleArray:(NSArray *)titleArr titleFont:(UIFont *)fontSize titleLineSelectColor:(UIColor *)titleSelectColor normal:(UIColor *)normalColor withselectedIndex:(NSInteger)index;

-(void)setselectedIndex:(NSInteger)index;

//添加右角标
-(void)setRightTopLabelWithAry:(NSArray*)topNumAry;

@end
