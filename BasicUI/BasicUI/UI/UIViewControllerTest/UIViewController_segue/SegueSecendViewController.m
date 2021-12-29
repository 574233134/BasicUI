//
//  SegueSecendViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/25.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "SegueSecendViewController.h"

@interface SegueSecendViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *dataTF;



@end

@implementation SegueSecendViewController

@synthesize param;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataTF.userInteractionEnabled = NO;
    self.dataTF.delegate = self;
    self.dataTF.text = self.param;
}

- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -  textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
