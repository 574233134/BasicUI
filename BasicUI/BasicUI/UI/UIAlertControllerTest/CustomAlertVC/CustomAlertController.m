//
//  CustomAlertController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/26.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomAlertController.h"
#import "CustomAlertView.h"
#import "CustomActionSheetView.h"
#import "UIView+frame.h"
#import "CustomModalTransitionDelegate.h"
#import "CustomModelActionSheetDelegate.h"
 static UIWindow *alertWindow;
@interface CustomAlertController () <CustomActionSheetViewDelegete,CustomAlertViewDelegate>
    
@property (nonatomic, weak) UIViewController *fromController;
@property (nonatomic, strong) CustomAlertView *alertView; //alertView
@property (nonatomic, strong) CustomActionSheetView *actionSheetView; //actionSheetView
@property (strong, nonatomic) CustomModalTransitionDelegate *alertDelegate;
@property (strong, nonatomic) CustomModelActionSheetDelegate *actionSheetDelegate;
    
@end

@implementation CustomAlertController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message style:(CustomAlertControllerStyle)style
{
    CustomAlertController *alertController = [[CustomAlertController alloc] init];
    alertController.style = style;
    CustomAlertLayoutStyle layoutStyle = style == CustomAlertLayoutStyleAlert ? CustomAlertLayoutStyleAlert : CustomAlertLayoutStyleActionSheet;
    alertController.layout = [[CustomAlertLayout alloc] initWithStyle:layoutStyle];
    alertController.modalPresentationStyle = UIModalPresentationCustom;
    if (style == CustomAlertControllerStyleAlert) {
        alertController.alertDelegate = [CustomModalTransitionDelegate new];
        alertController.transitioningDelegate = alertController.alertDelegate;
        alertController.alertView = [CustomAlertView alertViewWith:title message:message];
        [alertController.view addSubview:alertController.alertView];
        alertController.alertView.clickActionDelegate = alertController;
    }
    else
    {
        alertController.actionSheetDelegate = [CustomModelActionSheetDelegate new];
        alertController.transitioningDelegate = alertController.actionSheetDelegate;
        alertController.actionSheetView = [CustomActionSheetView actionSheetViewWith:title message:message];
        [alertController.view addSubview:alertController.actionSheetView];
        alertController.actionSheetView.clickActionSheetDelegate = alertController;
    }
    [alertController layoutSettings];
    return alertController;
}

- (void)layoutSettings
{
    if (self.style == CustomAlertControllerStyleAlert)
    {
        self.alertView.layout = self.layout;
    }
    else
    {
        self.actionSheetView.layout = self.layout;
    }
}

- (void)addAction:(CustomAlertAction *_Nonnull)action
{
    [action setActionLayout:self.layout];
    if (self.style == CustomAlertControllerStyleAlert)
    {
        [self.alertView addAction:action];
        [self.alertView layoutSubviews];
        self.view.bounds = self.alertView.bounds;
    }
    else
    {
        [self.actionSheetView addAction:action];
        [self.actionSheetView layoutSubviews];
        self.view.bounds = self.actionSheetView.bounds;
    }
    
    [action addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - alertDelegate & actionSheetDelegate
- (void)didClickAlertAction
{
    [self dismiss];
}

- (void)didClickActionSheet
{
    [self dismiss];
}

@end
