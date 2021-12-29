//
//  PageControlBasic.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/26.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "PageControlBasic.h"

@interface PageControlBasic ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutlet UITextField *allPageTextField;

@property (strong, nonatomic) IBOutlet UITextField *currentPageTextField;


@end

@implementation PageControlBasic

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"pageControl 基础";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatPageControl];
}

/** defersCurrentPageDisplay
 *  这个属性如果设置为YES，点击时并不会改变控制器显示的当前页码点（但是currentPage 属性的值会改变）
 *  必须手动调用- (void)updateCurrentPageDisplay; 这个方法，才会更新。
 */
- (void)creatPageControl
{
    
    self.pageControl.defersCurrentPageDisplay = YES;
    [self.view addSubview:self.pageControl];
    [self.pageControl addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventTouchUpInside];
}

/**
 * updateCurrentPageDisplay方法
 * 更新当前页码的小圆点，当defersCurrentPageDisplay 属性为yes 时如果为调用该方法则显示的当前页一直不会变
 *
 * sizeForNumberOfPages 方法
 * 通过页数得到pagecontrol大小
 *
 */
- (void)valueChange
{
    [self.pageControl updateCurrentPageDisplay];
    NSLog(@"%@",NSStringFromCGSize([self.pageControl sizeForNumberOfPages:self.pageControl.currentPage]));
}


#pragma mark -  xib action
/** numberOfPages: 设置pageControl的总页数 */
- (IBAction)setAllPageCount:(UIButton *)sender
{
    self.pageControl.numberOfPages = self.allPageTextField.text.integerValue;
    CGSize size = [self.pageControl sizeForNumberOfPages:self.allPageTextField.text.integerValue];
    self.pageControl.frame = CGRectMake(self.pageControl.frame.origin.x, self.pageControl.frame.origin.x, size.width, size.height);
}

/** currentPage: 设置currentPage的当前页 */
- (IBAction)setCurrentPage:(UIButton *)sender
{
    self.pageControl.currentPage = self.currentPageTextField.text.integerValue;
}

/** hidesForSinglePage: 只有一页的时候是否隐藏pageControl */
- (IBAction)isHiddenWhenPageOnlyOne:(UISwitch *)sender
{
    self.pageControl.hidesForSinglePage = sender.on;
}

/** pageIndicatorTintColor: 设置原点指示器颜色 */
- (IBAction)setIndicatorTingColor:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
            break;
        case 1:
            self.pageControl.pageIndicatorTintColor = [UIColor redColor];
            break;
        case 2:
            self.pageControl.pageIndicatorTintColor = [UIColor blueColor];
            break;
        default:
            break;
    }
}

/** currentPageIndicatorTintColor: 设置当前页原点指示器颜色 */
- (IBAction)setCurrentIndicatorColor:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
            break;
        case 1:
            self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
            break;
        case 2:
            self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
            break;
        default:
            break;
    }
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




@end
