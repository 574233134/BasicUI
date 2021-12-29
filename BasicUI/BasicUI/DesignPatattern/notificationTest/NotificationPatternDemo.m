//
//  NotificationPatternDemo.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/22.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "NotificationPatternDemo.h"
#import "PostNotifacationController.h"
@interface NotificationPatternDemo ()

@end

@implementation NotificationPatternDemo
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"通知";
    [self addNotification];
}

- (void)addNotification
{
    // 不带参数的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification1) name:@"notifyName1" object:nil];
    
    // 使用object 传递消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification2:) name:@"notifyName2" object:nil];
    
    // 使用userInfo 传递消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification3:) name:@"nitifyName3" object:nil];

}

-(void)notification1
{
    NSLog(@"接收 不带参数的消息");
}

-(void)notification2:(NSNotification *)noti
{
    //使用object处理消息
    NSString *info = [noti object];
    NSLog(@"接收 object传递的消息：%@",info);
}

//实现方法
-(void)notification3:(NSNotification *)noti
{
    //使用userInfo处理消息
    NSDictionary  *dic = [noti userInfo];
    NSString *info = [dic objectForKey:@"param"];
    NSLog(@"接收 userInfo传递的消息：%@",info);
}



- (IBAction)push:(UIButton *)sender
{
    PostNotifacationController *vc = [[PostNotifacationController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
