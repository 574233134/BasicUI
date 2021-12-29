//
//  SegueFirstViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/25.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "SegueFirstViewController.h"
#import "SegueSecendViewController.h"
@interface SegueFirstViewController ()<UITextFieldDelegate>
@end

@implementation SegueFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataTF.delegate = self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *data = self.dataTF.text;
    SegueSecendViewController* VC = segue.destinationViewController;
    VC.param = data;
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
