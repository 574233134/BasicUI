//
//  TextViewCustom.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/10.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TextViewCustom.h"
#import "LMKTextView.h"
@interface TextViewCustom ()

@property (strong, nonatomic) LMKTextView *textView;

@end

@implementation TextViewCustom

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义textView";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTextView];
}

- (void)creatTextView
{
    self.textView = [[LMKTextView  alloc]initWithFrame:CGRectMake(50, 100, 250, 100)];
    
    self.textView.layer.borderWidth = 2;
    
    self.textView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //1.设置提醒文字
    self.textView.placeholder=@"请输入文字";
    //2.设置提醒文字颜色
    self.textView.placeholderColor= [UIColor lightGrayColor];
    [self.view addSubview:self.textView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
}


@end
