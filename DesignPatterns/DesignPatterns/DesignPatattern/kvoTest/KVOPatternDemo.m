//
//  KVOPatternDemo.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/15.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "KVOPatternDemo.h"

@interface KVOPatternDemo ()

@property (assign, nonatomic) NSInteger num;

@property (strong, nonatomic) IBOutlet UILabel *label;


@end

@implementation KVOPatternDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"KVO模式";
    self.num = 1;
    //    1.注册当前对下为被观察者。
    //    option中：
    //    NSKeyValueObservingOptionOld 以字典的形式提供 “初始对象数据”;
    //    NSKeyValueObservingOptionNew 以字典的形式提供 “更新后新的数据”;
    [self addObserver:self
                 forKeyPath:@"num" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew
                    context:nil];
}

#pragma mark - Event Click
- (IBAction)changeNumber:(UIButton *)sender
{
    self.num = self.num+1;
    
}

#pragma mark - KVO
/**
 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更
 
 @param keyPath 属性名称
 @param object 被观察的对象
 @param change 变化前后的值都存储在 change 字典中
 @param context 注册观察者时，context 传过来的值
 */
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSString *,id> *)change
                      context:(void *)context
{
    if([keyPath isEqualToString:@"num"] && object == self)
    {
        // 响应变化处理：UI更新（label文本改变）
        self.label.text = [NSString stringWithFormat:@"当前的num值为：%@",
                           [change valueForKey:@"new"]];
        
        //上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
        NSLog(@"\noldnum:%@ newnum:%@",
        [change valueForKey:@"old"],
        [change valueForKey:@"new"]);
    }
}

#pragma mark - 移除KVO
- (void)dealloc {
    
    [self removeObserver:self
              forKeyPath:@"num"
                 context:nil];
}
@end
