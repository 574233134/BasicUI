//
//  AttributedStringDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/1/3.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "AttributedStringDemo.h"

@interface AttributedStringDemo ()

@property (strong, nonatomic) IBOutlet UITextView *textView1;

@property (strong, nonatomic) IBOutlet UITextView *textView2;

@end

@implementation AttributedStringDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadStrAttribute];
}

- (void)loadStrAttribute
{
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString: self.textView1.text];
    NSDictionary *atttibutedDic1 = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:16],// 字体
                                    NSForegroundColorAttributeName:[UIColor blueColor],// 文字颜色
                                    NSBackgroundColorAttributeName:[UIColor yellowColor],//字体所在区域背景色
                                    NSLigatureAttributeName:@(1) ,// 连体属性
                                    NSKernAttributeName:@(3),// 字符间距
                                    NSStrikethroughStyleAttributeName:@(3),//删除线
                                    NSStrikethroughColorAttributeName:[UIColor redColor]//删除线颜色
                                    };
    [str1 addAttributes:atttibutedDic1 range:NSMakeRange(1, 60)];
    self.textView1.userInteractionEnabled = NO;
    self.textView1.attributedText = str1;
    
    
    self.textView2.text = @"An NSAttributedString object manages character strings and associated sets of attributes (for example, font and kerning) that apply to individual characters or ranges of characters in the string. An association of characters and their attributes is called an attributed string.";
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString: self.textView2.text];
    NSDictionary *atttibutedDic2 = @{
                                    NSUnderlineStyleAttributeName:@(NSUnderlineStyleDouble),// 下划线
                                    NSStrokeColorAttributeName:[UIColor brownColor],// 填充部分颜色
                                    NSStrokeWidthAttributeName:@(3), //设置笔画宽度
                                    NSLinkAttributeName:[NSURL URLWithString:@"https://www.baidu.com"] ,// 链接属性
                                    NSUnderlineColorAttributeName:[UIColor cyanColor],// 下划线颜色
                                    NSObliquenessAttributeName:@(0.5)//设置字形倾斜度
                                    };
    [str2 addAttributes:atttibutedDic2 range:NSMakeRange(1, 60)];
    self.textView2.userInteractionEnabled = NO;
    self.textView2.attributedText = str2;
}

@end
