//
//  TextFieldBasic.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/6.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TextFieldBasic.h"

@interface TextFieldBasic () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;


@end

@implementation TextFieldBasic

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"textfield 基础";
    [self textfieldConfig];
}

/** 常用属性
 * textColor 设置文字颜色
 * font 设置字体及大小
 * textAlignment 设置文字对齐方式
 * defaultTextAttributes 设置text文字属性
 * placeholder 设置提示文字
 * attributedPlaceholder 设置提示富文本文字
 * background 设置textfield背景图，背景图和背景颜色只能二选一
 * disabledBackground 设置不可用状态下的背景图
 * minimumFontSize 文字最下字号
 * adjustsFontSizeToFitWidth 宽度自适应 默认为NO,设置为YES时textfield 会自动调整文字font 适应宽度（最小font 不能比 minimumFontSize 小）
 * leftView 左侧视图
 * rightView 右侧视图
 *
 */
- (void)textfieldConfig
{

    self.textField.textColor = [UIColor redColor];
    
    self.textField.font = [UIFont systemFontOfSize:18];
    
    self.textField.textAlignment = NSTextAlignmentLeft;
    
  
     NSDictionary *attributeDic = @{NSFontAttributeName : [UIFont systemFontOfSize:20] , NSStrokeColorAttributeName : [UIColor redColor] , NSStrokeWidthAttributeName : @(3)};
    self.textField.defaultTextAttributes = attributeDic;
    
   
    self.textField.placeholder = @"请输入文字";
    
    
    NSDictionary *placeholderDic =  @{NSFontAttributeName : [UIFont systemFontOfSize:18] , NSForegroundColorAttributeName : [UIColor yellowColor] };
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"请输入文字" attributes:placeholderDic];;
    self.textField.attributedPlaceholder = string;
    
    self.textField.background = [[UIImage imageNamed:@"textfieldBG"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.textField.clearButtonMode = UITextFieldViewModeNever;
    
    self.textField.delegate = self;
    
    UIImageView *leftView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"leftView"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.textField.leftView = leftView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *rightView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"rightView"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.textField.rightView = rightView;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    
}

#pragma mark - xib action
/** UITextBorderStyleNone UITextBorderStyleLine 区别不是很大*/
- (IBAction)setBorderStyle:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            self.textField.borderStyle = UITextBorderStyleNone;
            break;
        case 1:
            self.textField.borderStyle = UITextBorderStyleLine;
            break;
        case 2:
            self.textField.borderStyle = UITextBorderStyleBezel;
            break;
        case 3:
            self.textField.borderStyle = UITextBorderStyleRoundedRect;
            break;
        default:
            break;
    }
}

- (IBAction)setClearBtnMode:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            self.textField.clearButtonMode = UITextFieldViewModeNever;
            break;
        case 1:
            self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            break;
        case 2:
            self.textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
            break;
        case 3:
            self.textField.clearButtonMode = UITextFieldViewModeAlways;
            break;
        default:
            break;
    }
}

#pragma mark - tableView delegate
// 是否允许编辑，返回NO不允许 默认为YES
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// 开始编辑(成为第一响应者)时调用
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textField 开始编辑");
}

// 是否允许结束编辑
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

// 结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textField 结束编辑");
}

// 结束编辑带结束原因 NS_AVAILABLE_IOS(10_0);
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0)
{
    NSLog(@"textfield 结束编辑，结束原因：%u",reason);
}

// 更新文字时调用  string 为新文字  range为文字位置
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"textfield 文字即将改变,替换字符串：%@,range:%@",string,NSStringFromRange(range));
    return YES;
}


// 是否允许清除（点击清除按钮时调用）
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

// retern 按钮被按下时调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
