//
//  TextFieldCustom.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TextFieldCustom.h"
#import "LMKTextfield.h"
@interface TextFieldCustom ()<UITextFieldDelegate>

@property (strong, nonatomic)LMKTextfield *customTF;// 该textfield 中重写了textfield的几个方法

@end

@implementation TextFieldCustom

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义textfield";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCustomTF];
}

- (void)createCustomTF
{
    self.customTF = [[LMKTextfield alloc]initWithFrame:CGRectMake(30, 100, 200, 40)];
    self.customTF.layer.cornerRadius = 5;
    self.customTF.placeholder = @"请输入文字";
    self.customTF.backgroundColor = [UIColor redColor];
    self.customTF.delegate = self;
    [self.view addSubview:self.customTF];
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
