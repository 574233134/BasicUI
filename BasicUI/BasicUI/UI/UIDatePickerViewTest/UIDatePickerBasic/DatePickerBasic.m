//
//  DatePickerBasic.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/23.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "DatePickerBasic.h"

@interface DatePickerBasic ()<UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) IBOutlet UITextField *timeTextField;

@end

@implementation DatePickerBasic

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"pickeDate基础";
    [self loadDataPickerConfig];
}

- (void)loadDataPickerConfig
{
    // 设置地区 （zh - 中国）
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    // 设置日期模式
    self.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    
    // 设置当前显示时间
    [self.datePicker setDate:[NSDate date] animated:YES];
    
    // 设置显示最大时间（此处为当前时间）
    [self.datePicker setMaximumDate:[NSDate date]];
    
    // 监听DataPicker的滚动
    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    self.datePicker = self.datePicker;
    
    self.timeTextField.delegate = self;
    
}


- (void)dateChange:(UIDatePicker *)datePicker
{
    
    if (datePicker.datePickerMode == UIDatePickerModeDate)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        //设置时间格式
        formatter.dateFormat = @"yyyy年 MM月 dd日";
        NSString *dateStr = [formatter  stringFromDate:datePicker.date];
        
        self.timeTextField.text = dateStr;
    }
    else
    {
        self.timeTextField.text = @"";
    }
}


#pragma mark - textfield Delegate
//禁止用户输入文字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}

#pragma mark - xib Action

- (IBAction)changeDatePickerStyle:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.datePicker.datePickerMode = UIDatePickerModeTime;
            break;
        case 1:
            self.datePicker.datePickerMode = UIDatePickerModeDate;
            break;
        case 2:
            self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            break;
        case 3:
            self.datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
            break;
        default:
            break;
    }
}
@end
