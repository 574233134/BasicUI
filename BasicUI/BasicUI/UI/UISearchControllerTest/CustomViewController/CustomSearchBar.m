//
//  CustomSearchBar.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomSearchBar.h"
#import "CustomSearchTextField.h"
#import "UIView+frame.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface CustomSearchBar ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) CustomSearchTextField *searchTextField;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end


@implementation CustomSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, kScreenWidth, 44);
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor cyanColor];
    [self addSubview:self.searchTextField];
    [self addSubview:self.rightButton];
    [self addSubview:self.cancelButton];
    return self;
}

- (void)setIsEditing:(BOOL)isEditing
{
    _isEditing = isEditing;
    if (_isEditing)
    {
        [UIView animateWithDuration:0.2 animations:^
        {
            self.searchTextField.x = 10;
            self.rightButton.x = kScreenWidth - 38 - 40;
            self.backgroundImageView.width = kScreenWidth - 20 - 40;
            self.cancelButton.x = kScreenWidth - 40;
        } completion:^(BOOL finished)
        {
            self.searchTextField.width = kScreenWidth - 20 - 38 - 40;
        }];
        self.searchTextField.canTouch = YES;
        [self.searchTextField becomeFirstResponder];
    }
    else
    {
        self.searchTextField.text = @"";
        self.text = @"";
        [_rightButton setImage:[UIImage new] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage new] forState:UIControlStateHighlighted];
        [UIView animateWithDuration:0.2 animations:^
        {
            self.searchTextField.x = kScreenWidth * 0.5 - 40;
            self.rightButton.x = kScreenWidth - 38;
            self.backgroundImageView.width = kScreenWidth - 20;
            self.cancelButton.x = kScreenWidth;
        }
        completion:^(BOOL finished)
        {
            self.searchTextField.width = kScreenWidth * 0.5 + 20 - 38;
        }];
        self.searchTextField.canTouch = NO;
        [self.searchTextField resignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)])
    {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^
    {
        self.searchTextField.x = kScreenWidth * 0.5 - 40;
    }
    completion:^(BOOL finished)
    {
        self.searchTextField.width = kScreenWidth * 0.5 + 20 - 38 - 40;
    }];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^
    {
        self.searchTextField.x = 10;
    }
    completion:^(BOOL finished)
    {
        self.searchTextField.width = kScreenWidth - 20 - 38 - 40;
    }];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)])
    {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}

- (void)textFieldDidChange
{
    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [self.delegate searchBar:self textDidChange:self.searchTextField.text];
    }
    self.text = self.searchTextField.text;
    if (self.searchTextField.text.length)
    {
        [_rightButton setImage:[UIImage imageNamed:@"card_delete"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"card_delete"] forState:UIControlStateHighlighted];
    }
    else
    {
        [_rightButton setImage:[UIImage new] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage new] forState:UIControlStateHighlighted];
    }
}

- (void)cancelButtonClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SEARCH_CANCEL_NOTIFICATION_KEY" object:nil];
}

- (void)rightButtonClick
{
    if (self.searchTextField.text)
    {
        self.searchTextField.text = @"";
        self.text = nil;
        [_rightButton setImage:[UIImage new] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage new] forState:UIControlStateHighlighted];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.searchTextField.placeholder = self.placeholder;
}

- (UITextField *)searchTextField
{
    if (!_searchTextField)
    {
        _searchTextField = [[CustomSearchTextField alloc] initWithFrame:CGRectMake(kScreenWidth * 0.5 - 40, 0, kScreenWidth * 0.5 + 20 - 38, 44)];
        _searchTextField.canTouch = NO;
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchIcon"]];
        searchIcon.contentMode = UIViewContentModeScaleAspectFit;
        searchIcon.frame = CGRectMake(0, 0, 30, 14);
        _searchTextField.leftView = searchIcon;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.font = [UIFont systemFontOfSize:16.0f];
        [_searchTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}

- (UIButton *)rightButton
{
    if (!_rightButton)
    {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:[UIImage new] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage new] forState:UIControlStateHighlighted];
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.frame = CGRectMake(kScreenWidth - 38, 8, 28, 28);
    }
    return _rightButton;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(kScreenWidth, 0, 40, 44);
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelButton setTitle:@"取消  " forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

@end
