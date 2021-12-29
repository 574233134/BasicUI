//
//  LMKSegement.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "LMKSegement.h"
#import "UIView+frame.h"
#define index_width 13.0

#define index_height 13.0

@interface LMKSegement ()

@property (nonatomic,strong) UIView *vLineRed;

@property (nonatomic,strong) UISegmentedControl *segChoose;

@end

@implementation LMKSegement

- (void)setSegmentWithBackground:(UIColor *)background titleArray:(NSArray *)titleArr titleFont:(UIFont *)fontSize titleLineSelectColor:(UIColor *)titleSelectColor normal:(UIColor *)normalColor withselectedIndex:(NSInteger)index
{
    for (UIView*tmpV in self.subviews)
    {
        [tmpV removeFromSuperview];
    }
    BOOL isScr = YES;
    _titleArr = [[NSArray alloc]initWithArray:titleArr];
    _fontSize = fontSize;
    _View_W = self.frame.size.width;
    _itmeViewW = _View_W/titleArr.count;
    if (titleArr.count>1)
    {
      _customScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
      _customScr.backgroundColor = [UIColor clearColor];
      _customScr.showsHorizontalScrollIndicator = NO;
      _customScr.delegate = self;
      _customScr.contentSize = CGSizeMake(_View_W, self.frame.size.height);
      isScr = YES;
      [self addSubview:_customScr];
    }
    else
    {
       isScr = NO;
    }
    _segChoose = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0.5, _View_W, self.frame.size.height-1)];
    _segChoose.backgroundColor = background;
    _segChoose.tag = self.tag;
    [_segChoose setTintColor:background];
    _segChoose.layer.borderColor = background.CGColor;
    for (int i = 0; i < titleArr.count; i ++)
    {
        [_segChoose insertSegmentWithTitle:titleArr[i] atIndex:i animated:NO];
    }
    [_segChoose setTitleTextAttributes:@{NSFontAttributeName:fontSize,NSForegroundColorAttributeName:normalColor} forState:UIControlStateNormal];
    float seleSize = fontSize.pointSize+2.0;
    if (self.frame.size.width<301)
    {
        seleSize = fontSize.pointSize+1.0;
    }
    [_segChoose setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:seleSize],NSForegroundColorAttributeName:titleSelectColor} forState:UIControlStateSelected];
    [_segChoose addTarget:self action:@selector(segmentedValueChanged:) forControlEvents:UIControlEventValueChanged];
    _segChoose.selectedSegmentIndex = index;
    //选项卡红色的标识条
    CGSize t_s = [self getTextWidth:_titleArr[index] withSize:CGSizeMake(_itmeViewW, 20) withFont:_fontSize];
    _vLineRed = [[UIView alloc]initWithFrame:CGRectMake(index * _itmeViewW+(_itmeViewW-t_s.width-20)/2.0 , self.frame.size.height- 2, t_s.width+20, 2)];
    _vLineRed.backgroundColor = titleSelectColor;
    if (isScr==NO)
    {
        [self addSubview:_segChoose];
        [self addSubview:_vLineRed];
    }
    else
    {
        [_customScr addSubview:_segChoose];
        [_customScr addSubview:_vLineRed];
        
    }
    
}

- (void)segmentedValueChanged:(UISegmentedControl *)seg
{
    CGSize t_s = [self getTextWidth:_titleArr[seg.selectedSegmentIndex] withSize:CGSizeMake(_itmeViewW, 20) withFont:_fontSize];
    _vLineRed.frame = CGRectMake(seg.selectedSegmentIndex * _itmeViewW+(_itmeViewW-t_s.width-20)/2.0 , self.frame.size.height- 2, t_s.width+20, 2);
    if ([_delegate respondsToSelector:@selector(customSegmentedValueChanged:)])
    {
        [_delegate customSegmentedValueChanged:_segChoose];
    }
    
}

-(void)setselectedIndex:(NSInteger)index
{
    CGSize t_s = [self getTextWidth:_titleArr[index] withSize:CGSizeMake(_itmeViewW, 20) withFont:_fontSize];
    _vLineRed.frame = CGRectMake(index * _itmeViewW + (_itmeViewW-t_s.width-20)/2.0, self.height-2, t_s.width + 20, 2);
    _segChoose.selectedSegmentIndex = index;
    
}

//添加标记：
-(void)setRightTopLabelWithAry:(NSArray*)topNumAry
{
    for (int i=0; i<topNumAry.count; i++)
    {
        [[_customScr viewWithTag:100+i] removeFromSuperview];
        [[_customScr viewWithTag:200+i] removeFromSuperview];
    }
    for (int i=0; i<topNumAry.count; i++)
    {
        NSString*titleStr = _titleArr[i];
        CGSize titleSize = [self getTextWidth:titleStr withSize:CGSizeMake(_itmeViewW, 30) withFont:[UIFont systemFontOfSize:15]];
        NSString * text = topNumAry[i];
        UIView*superView = [[UIView alloc]initWithFrame:CGRectMake((_itmeViewW+titleSize.width)/2+_itmeViewW*i, 5, 5, 40)];
        superView.backgroundColor = [UIColor clearColor];
        [_customScr addSubview:superView];
        superView.tag = 100+i;
        if ((![text isEqualToString:@"0"])&&(![text isEqualToString:@""]))
        {
            [self createRightTopIndexLabelWithSize:CGSizeMake(index_width, index_height) tag:200+i borderWidth:1.5 borderColor:[UIColor redColor].CGColor text:text font:[UIFont systemFontOfSize:10] textColor:[UIColor whiteColor] SuperView:superView];
        }
        
    }
    
}

//计算字的尺寸：
-(CGSize)getTextWidth:(NSString*)text withSize:(CGSize)size withFont:(UIFont*)font
{
    NSDictionary *attrs=@{NSFontAttributeName:font};
    CGSize s=[text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    return s;
}

//右上角标记
- (UILabel *)createRightTopIndexLabelWithSize:(CGSize)size tag:(NSInteger)tag borderWidth:(CGFloat)borderWidth borderColor:(CGColorRef)borderColor text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor SuperView:(UIView *)superView
{
    CGFloat w = size.height/2;
    CGRect superFrame = superView.frame;
    CGFloat x = CGRectGetWidth(superFrame)-10;
    CGFloat y = -2;
    CGFloat height = size.height;
    CGFloat width;
    if (text.length == 1)
    {
      width = size.width;
     }
    else if (text.length == 2)
    {
        width = size.width*1.5;
            
    }
    else
    {
       width = size.width*2;
                
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
    label.backgroundColor = [UIColor redColor];
    label.layer.cornerRadius = w;
    label.layer.masksToBounds = YES;
    label.layer.borderWidth = borderWidth;
    label.layer.borderColor = borderColor;
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    [superView addSubview:label];
    return label;
    
}

@end
