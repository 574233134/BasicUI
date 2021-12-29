//
//  ViewControllerKeyBordCommand.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/26.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ViewControllerKeyBordCommand.h"

@interface ViewControllerKeyBordCommand ()

@end

@implementation ViewControllerKeyBordCommand

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快捷键";
    self.view.backgroundColor = [UIColor purpleColor];
    [self creatSubView];
}

- (void)creatSubView
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 350, 40)];
    label.numberOfLines = 0;
    label.text = @"在模拟器上运行点击shift + (1 .. 5)试试看！！！";
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (NSArray<UIKeyCommand *> *)keyCommands
{
    UIKeyCommand *command1 = [UIKeyCommand keyCommandWithInput:@"1" modifierFlags:UIKeyModifierShift action:@selector(commandAction:) discoverabilityTitle:@"action1"];
    [self addKeyCommand:command1];
    UIKeyCommand *command2 = [UIKeyCommand keyCommandWithInput:@"2" modifierFlags:UIKeyModifierShift action:@selector(commandAction:) discoverabilityTitle:@"action2"];
    [self addKeyCommand:command2];
    UIKeyCommand *command3 = [UIKeyCommand keyCommandWithInput:@"3" modifierFlags:UIKeyModifierShift action:@selector(commandAction:) discoverabilityTitle:@"action3"];
    [self addKeyCommand:command3];
    UIKeyCommand *command4 = [UIKeyCommand keyCommandWithInput:@"4" modifierFlags:UIKeyModifierShift action:@selector(commandAction:) discoverabilityTitle:@"action4"];
    [self addKeyCommand:command4];
    UIKeyCommand *command5 = [UIKeyCommand keyCommandWithInput:@"5" modifierFlags:UIKeyModifierShift action:@selector(commandAction:) discoverabilityTitle:@"action5"];
    [self addKeyCommand:command5];
    return @[command1,command2,command3,command4,command5];
    
}

- (void)commandAction:(UIKeyCommand *)command
{
    [self alertWithTitle:@"快捷键" message:command.discoverabilityTitle];
}

#pragma mark - 封装警告框
-(void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}

@end
