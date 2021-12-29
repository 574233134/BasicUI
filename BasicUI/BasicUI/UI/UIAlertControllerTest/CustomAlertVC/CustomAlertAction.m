//
//  CustomAlertAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/26.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomAlertAction.h"
#import "UIView+frame.h"
#import "CustomAlertLayout.h"
#import "CustomAlertController.h"

@interface CustomAlertAction ()

@property (strong, nonatomic) CustomAlertLayout *layout;
    
@end

@implementation CustomAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(CustomAlertActionStyle)style handler:(void (^)(CustomAlertAction * _Nonnull))hanlder
{
    CustomAlertAction *button = [CustomAlertAction buttonWithType:UIButtonTypeCustom];
    [button callback];
    button.handler = hanlder;
    button.style = style;
    button.title = title;
    return button;
}

- (void)callback
{
    [self addTarget:self action:@selector(buttonDidClick) forControlEvents:UIControlEventTouchUpInside];
}
    
#pragma mark - action
// 点击按钮后执行回调
- (void)buttonDidClick
{
    self.handler ? self.handler(self) : nil;
}
    
    
#pragma mark - setUI
    
- (void)setActionLayout:(CustomAlertLayout *)layout
{
    if (layout == nil)
    {
        return;
    }
    self.layout = layout;
    switch (self.style)
    {
        case CustomAlertActionStyleCancel:
        {
            [self setTitleColor:layout.cancelActionTitleColor forState:UIControlStateNormal];
            self.backgroundColor = layout.cancelActionBackgroundColor;
            self.titleLabel.font = layout.cancelActionTitleFont;
            
        }
        break;
        case CustomAlertActionStyleDone:
        {
            [self setTitleColor:layout.doneActionTitleColor forState:UIControlStateNormal];
            self.backgroundColor = layout.doneActionBackgroundColor;
            self.titleLabel.font = layout.doneActionTitleFont;
            
        }
        break;
        default:
        {
            [self setTitleColor:layout.defaultActionTitleColor forState:UIControlStateNormal];
            self.backgroundColor = layout.defaultActionBackgroundColor;
            self.titleLabel.font = layout.defaultActionTitleFont;
        }
        break;
    }
}
    
- (CustomAlertLayout *)getActionLayout
{
    return self.layout;
}
    
- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}
@end
