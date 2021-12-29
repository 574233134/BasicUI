//
//  DelegatePatternDemo.h
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/15.
//  Copyright © 2019 李梦珂. All rights reserved.
//

/**
 
 一、 代理模式简介
  代理模式是一种消息传递方式，一个完整的代理模式包括：委托对象、代理对象和协议。
    协议：用来指定代理双方可以做什么，必须做什么。
    委托对象：根据协议指定代理对象需要完成的事，即调用协议中的方法。
    代理对象：根据协议实现委托方需要完成的事，即实现协议中的方法。
 
 二、 使用场景
 该模式常用在一个类需要让另一个类帮自己做一些事情但并不关心另一个类是谁，通常使用代理来做消息的传递
 
 注意点：代理属性使用weak属性修饰不能强引用，否则会造成循环引用。
 
 */

#import <UIKit/UIKit.h>

@interface DelegatePatternDemo : UIViewController

@end
