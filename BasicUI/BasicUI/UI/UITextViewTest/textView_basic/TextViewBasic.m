//
//  TextViewBasic.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/9.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TextViewBasic.h"
#import "BasicUIDemo.h"
@interface TextViewBasic ()<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TextViewBasic

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"textView基础";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTextViewConfig];
}

- (void)loadTextViewConfig
{
    self.textView.font = [UIFont systemFontOfSize:18];
    
    self.textView.textAlignment = NSTextAlignmentLeft;
    
    self.textView.layer.borderWidth = 2;
    
    self.textView.layer.borderColor = [UIColor blackColor].CGColor;
    
    NSRange range =  NSMakeRange(0, 10);
    
    self.textView.selectedRange = range;
    
    self.textView.editable = YES;
    
    self.textView.selectable = YES;
    
    /** 让什么文字成为链接 */
    self.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    /** 默认为NO */
    self.textView.allowsEditingTextAttributes = YES;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"这是一个链接：www.123456.com  。"];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"url1://www.baidu.com"
                             range:NSMakeRange(7, 14)];
    
    
    NSDictionary *linkAttributes = @{NSForegroundColorAttributeName: [UIColor redColor],
                                     NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                     NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid),
                                     NSFontAttributeName:[UIFont systemFontOfSize:19]
                                     };
    
    
    self.textView.linkTextAttributes = linkAttributes;
    
    self.textView.attributedText = attributedString;
    
    self.textView.delegate = self;
    
    self.textView.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    //滚动到文本的某个位置
    [self.textView scrollRangeToVisible:NSMakeRange(50, 5)];
    
    // 自定义弹出键盘
//    UIView *inputView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100)];
//    inputView.backgroundColor = [UIColor orangeColor];
//    self.textView.inputView = inputView;
    
    // 键盘增补视图
    UIView *inputAccessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    inputAccessoryView.backgroundColor = [UIColor cyanColor];
    self.textView.inputAccessoryView = inputAccessoryView;
    
    // 完成按钮 用于回收键盘
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [doneBtn setBackgroundColor:[UIColor purpleColor]];
    doneBtn.frame = CGRectMake(SCREEN_WIDTH-80, 10, 50, 20);
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventTouchUpInside];
    [self.textView.inputAccessoryView addSubview:doneBtn];
}

- (void)endEdit
{
    [self.textView resignFirstResponder];
}

#pragma mark - textView delegate
// textView 文字变化时调用
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSMutableDictionary * attributesDic = [textView.typingAttributes mutableCopy];
    [attributesDic setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    // 重新设置 接下来改变的文字 的属性字典
    textView.typingAttributes = attributesDic;
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"valuechange");
}

// 是否允许开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

// 开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"开始编辑");
}

// 是否允许结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

// 结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView
{
     NSLog(@"停止编辑");
}

// 选中区域改变
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    NSLog(@"选中区域改变");
}

// 是否允许对文本中的URL进行操作
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0)
{
    if ([[URL scheme] isEqualToString:@"url1"]) {
        NSString * url = [URL host];
        
        NSLog(@"%@",url);

        return NO;
    }
    return YES;
}

// 是否允许对文本中的富文本进行操作
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0)
{
    return YES;
}

// 10.0后 弃用，使用textView:shouldInteractWithURL:inRange:forInteractionType:代替
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead")
{
    if ([[URL scheme] isEqualToString:@"url1"]) {
        NSString * url = [URL host];
        
        NSLog(@"%@",url);
        
        return NO;
    }
    return YES;
}

// 10.0后 弃用 使用textView:shouldInteractWithTextAttachment:inRange:forInteractionType: 代替
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithTextAttachment:inRange:forInteractionType: instead")
{
    return YES;
}

@end
