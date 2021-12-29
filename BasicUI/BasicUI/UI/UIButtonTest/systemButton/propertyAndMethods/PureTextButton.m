//
//  PureTextButton.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "PureTextButton.h"

@interface PureTextButton ()

@property (strong, nonatomic) IBOutlet UIButton *pureTextButton;

@end

@implementation PureTextButton

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"纯文本button";
    [self initButton];
}

- (void)initButton
{
//    [self.pureTextButton setSelected:YES];
    
    self.pureTextButton.backgroundColor = [UIColor greenColor];
    [self.pureTextButton setTitle:@"正常态" forState:UIControlStateNormal];
    [self.pureTextButton setTitle:@"高亮状态" forState:UIControlStateHighlighted];
    [self.pureTextButton setTitle:@"不可用" forState:UIControlStateDisabled];
    [self.pureTextButton setTitle:@"选中状态" forState:UIControlStateSelected];
    
    [self.pureTextButton setTitle:@"Focused" forState:UIControlStateFocused]; //NS_ENUM_AVAILABLE_IOS(9_0) 未找到何时触发
    [self.pureTextButton setTitle:@"Application" forState:UIControlStateApplication];// 未找到何时触发
    [self.pureTextButton setTitle:@"Reserved" forState:UIControlStateReserved];// 未找到何时触发
    
    // 设置不同状态下button的文字颜色
    [self.pureTextButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.pureTextButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.pureTextButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    // 设置button的阴影偏移
    self.pureTextButton.layer.shadowOffset =  CGSizeMake(10, 10);
    self.pureTextButton.layer.shadowColor = [UIColor redColor].CGColor;
    self.pureTextButton.layer.shadowOpacity = 0.8;
    
    // 设置不同状态下button中文字阴影部分颜色
    [self.pureTextButton setTitleShadowColor:[UIColor cyanColor] forState:UIControlStateNormal]; // 未找到何时触发
    [self.pureTextButton setTitleShadowColor:[UIColor purpleColor] forState:UIControlStateHighlighted];// 未找到何时触发
    [self.pureTextButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateDisabled];// 未找到何时触发
    
   // 标题的阴影改变时，按钮是否高亮显示。默认为NO
    self.pureTextButton.reversesTitleShadowWhenHighlighted = YES;
    
    // 高亮时 是否显示一个小光圈 默认为NO
    self.pureTextButton.showsTouchWhenHighlighted = YES;
    
    [self.pureTextButton addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)isUseable:(UISwitch *)sender
{
    self.pureTextButton.enabled = sender.on;
}

- (IBAction)buttonIsSelected:(UISwitch *)sender
{
    [self.pureTextButton setSelected:sender.on];
}

- (void)clickButton
{
    NSLog(@"点击了button");
}

@end
