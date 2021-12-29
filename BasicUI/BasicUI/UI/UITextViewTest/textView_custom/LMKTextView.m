//
//  LMKTextView.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/10.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "LMKTextView.h"
#import "UIView+frame.h"
@interface LMKTextView ()

@property (nonatomic,weak) UILabel *placeholderLabel;

@end


@implementation LMKTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.font= [UIFont systemFontOfSize:15]; //设置默认的字体
        [self creatPlaceHoderLabel];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self]; //通知:监听文字的改变
    }
    return self;
}

- (void)creatPlaceHoderLabel
{
    UILabel *placeholderLabel = [[UILabel alloc]init];//添加一个占位label
    placeholderLabel.backgroundColor= [UIColor clearColor];
    placeholderLabel.numberOfLines=0; //设置可以输入多行文字时可以自动换行
    [self addSubview:placeholderLabel];
    self.placeholderLabel= placeholderLabel; //赋值保存
    self.placeholderColor= [UIColor lightGrayColor]; // 设置占位文字默认颜色
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.y=8;  //设置UILabel 的 y值
    self.placeholderLabel.x=5; //设置 UILabel 的 x 值
    self.placeholderLabel.width=self.width-self.placeholderLabel.x*2.0; //设置 UILabel 的 x
    
    //根据文字计算高度
    CGSize maxSize =CGSizeMake(self.placeholderLabel.width,MAXFLOAT);
    
    // NS_AVAILABLE_IOS(7_0);
    self.placeholderLabel.height= [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
}

#pragma mark - 文字改变

// hasText 是一个系统的BOOL属性，如果UITextView输入了文字hasText就是YES，反之就为 NO。
- (void)textDidChange
{
    self.placeholderLabel.hidden = self.hasText;
}

#pragma mark - setter
- (void)setPlaceholder:(NSString*)myPlaceholder
{
    _placeholder= [myPlaceholder copy];
    //设置文字
    self.placeholderLabel.text= myPlaceholder;
    //重新计算子控件frame
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor*)myPlaceholderColor
{
    _placeholderColor= myPlaceholderColor;
    //设置颜色
    self.placeholderLabel.textColor= myPlaceholderColor;
}

#pragma mark - 重写系统方法
//重写这个set方法保持font一致
- (void)setFont:(UIFont*)font
{
    [super setFont:font];
    self.placeholderLabel.font= font;
    //重新计算子控件frame
    [self setNeedsLayout];
}

- (void)setText:(NSString*)text
{
    
    [super setText:text];
    [self textDidChange]; //这里调用的就是 UITextViewTextDidChangeNotification 通知的回调
}

- (void)setAttributedText:(NSAttributedString*)attributedText
{
    [super setAttributedText:attributedText];
    [self textDidChange]; //这里调用的就是UITextViewTextDidChangeNotification 通知的回调
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
}


@end
