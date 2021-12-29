//
//  PostNotifacationController.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/22.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "PostNotifacationController.h"

@interface PostNotifacationController ()

@end

@implementation PostNotifacationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发送通知";
}

- (IBAction)btn1Click:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyName1" object:nil];

}

- (IBAction)btn2Click:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyName2" object:[NSString stringWithFormat:@"%@",sender.titleLabel.text]];

}

- (IBAction)btn3Click:(UIButton *)sender
{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"userInfo消息" forKey:@"param"];
//    NSDictionary *dic =@{@"":@""};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nitifyName3" object:nil userInfo:dic];
}




@end
