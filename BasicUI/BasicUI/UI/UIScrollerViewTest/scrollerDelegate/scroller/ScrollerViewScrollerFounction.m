//
//  ScrollerViewScrollerFounction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/22.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ScrollerViewScrollerFounction.h"
#import "BasicUIDemo.h"
@interface ScrollerViewScrollerFounction ()<UIScrollViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;

/** Xib控件 */
@property (strong, nonatomic) IBOutlet UITextField *pointX;

@property (strong, nonatomic) IBOutlet UITextField *pointY;

@property (strong, nonatomic) IBOutlet UITextField *rectX;

@property (strong, nonatomic) IBOutlet UITextField *rectY;

@property (strong, nonatomic) IBOutlet UITextField *rectWidth;

@property (strong, nonatomic) IBOutlet UITextField *rectHeight;

@property (strong, nonatomic) IBOutlet UILabel *scrollerStateLabel;

@end

@implementation ScrollerViewScrollerFounction

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"滑动代理方法";
    [self creatScrollerView];
    [self divisionScrollerView];
    [self textFieldSetUp];
}

- (void)creatScrollerView
{
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 300)];
    self.scrollerView.backgroundColor = [UIColor redColor];
    self.scrollerView.delegate = self;
    [self.view addSubview:self.scrollerView];
    
    /** scrollerView滑动区域的大小 */
    self.scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH * 3,300*3);
    /** 初始偏移位置 */
    self.scrollerView.contentOffset = CGPointMake(0, 0);
}

/** 用九个label将scroller分为九块,便于展示scrollerView的功能 */
- (void)divisionScrollerView
{
    UILabel *label11 = [[UILabel alloc]init];
    label11.backgroundColor = [UIColor orangeColor];
    label11.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    label11.text = @"Scroller左上部分";
    label11.textAlignment = NSTextAlignmentCenter;
    [self.scrollerView addSubview:label11];
    
    UILabel *label12 = [[UILabel alloc]init];
    label12.text = @"Scroller上部";
    label12.textAlignment = NSTextAlignmentCenter;
    label12.backgroundColor = [UIColor greenColor];
    label12.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 300);
    [self.scrollerView addSubview:label12];
    
    UILabel *label13 = [[UILabel alloc]init];
    label13.text = @"Scroller右上部";
    label13.textAlignment = NSTextAlignmentCenter;
    label13.backgroundColor = [UIColor yellowColor];
    label13.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, 300);
    [self.scrollerView addSubview:label13];
    
    UILabel *label21 = [[UILabel alloc]init];
    label21.text = @"Scroller左部";
    label21.textAlignment = NSTextAlignmentCenter;
    label21.backgroundColor = [UIColor purpleColor];
    label21.frame = CGRectMake(0, 300, SCREEN_WIDTH, 300);
    [self.scrollerView addSubview:label21];
    
    UILabel *label22 = [[UILabel alloc]init];
    label22.text = @"scroller中心";
    label22.textAlignment = NSTextAlignmentCenter;
    label22.backgroundColor = [UIColor whiteColor];
    label22.frame = CGRectMake(SCREEN_WIDTH, 300, SCREEN_WIDTH, 300);
    [self.scrollerView addSubview:label22];
    
    UILabel *label23 = [[UILabel alloc]init];
    label23.text = @"Scroller右部";
    label23.textAlignment = NSTextAlignmentCenter;
    label23.backgroundColor = [UIColor blueColor];
    label23.frame = CGRectMake(SCREEN_WIDTH*2, 300, SCREEN_WIDTH, 300);
    [self.scrollerView addSubview:label23];
    
    UILabel *label31 = [[UILabel alloc]init];
    label31.text = @"Scroller左下";
    label31.textAlignment = NSTextAlignmentCenter;
    label31.frame = CGRectMake(0, 600, SCREEN_WIDTH, 300);
    label31.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    [self.scrollerView addSubview:label31];
    
    UILabel *label32 = [[UILabel alloc]init];
    label32.text = @"Scroller下";
    label32.textAlignment = NSTextAlignmentCenter;
    label32.frame = CGRectMake(SCREEN_WIDTH, 600, SCREEN_WIDTH, 300);
    label32.backgroundColor = [UIColor cyanColor];
    [self.scrollerView addSubview:label32];
    
    UILabel *label33 = [[UILabel alloc]init];
    label33.text = @"Scroller右下";
    label33.backgroundColor = [UIColor brownColor];
    label33.textAlignment = NSTextAlignmentCenter;
    label33.frame = CGRectMake(SCREEN_WIDTH*2, 600, SCREEN_WIDTH, 300);
    [self.scrollerView addSubview:label33];
}

- (void)textFieldSetUp
{
    self.pointX.delegate = self;
    self.pointY.delegate = self;
    self.rectX.delegate = self;
    self.rectY.delegate = self;
    self.rectWidth.delegate = self;
    self.rectHeight.delegate = self;
}

/** 点击空白区域使键盘消失 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.pointX resignFirstResponder];
    [self.pointY resignFirstResponder];
    [self.rectX resignFirstResponder];
    [self.rectY resignFirstResponder];
    [self.rectWidth resignFirstResponder];
    [self.rectHeight resignFirstResponder];
}

#pragma mark - textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - scrollerView 滚动相关代理方法
/** 开始拖动时调用(可能需要一些时间或移动距离) */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.scrollerStateLabel.text = @"开始拖动";
}

/** 将要结束拖动时调用 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0)
{
    self.scrollerStateLabel.text = @"将要结束拖动";
}

/** 已经结束拖动 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.scrollerStateLabel.text = @"结束拖动";
}

/** 将要开始减速 */
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    self.scrollerStateLabel.text = @"将要减速";
}

/** 减速结束 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.scrollerStateLabel.text = @"减速结束";
}

/** 当 setContentOffset/scrollRectVisible:animated: 有动画时调用,没有动画的时候就不调用 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.scrollerStateLabel.text = @"已经滚动到指定位置";
}

/** 点击状态栏滑动到顶部后调用 */
-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    self.scrollerStateLabel.text = @"滑动到顶部";
}

#pragma mark - Xib Action

/** 设置scrollerView 的偏移量 */
- (IBAction)scrollerToPoint:(UIButton *)sender
{
    CGPoint point = CGPointMake([self.pointX.text floatValue], [self.pointY.text floatValue]);
    [self.scrollerView setContentOffset:point animated:YES];
}

/** 将rect区域滚动到可见位置，如果rect区域已经完全可见则不做任何操作 */
- (IBAction)scrollerToRect:(UIButton *)sender
{
    CGRect rect = CGRectMake([self.rectX.text floatValue], [self.rectY.text floatValue], [self.rectWidth.text floatValue], [self.rectHeight.text floatValue]);
    [self.scrollerView scrollRectToVisible:rect animated:YES];
}

- (IBAction)clearScrollerState:(UIButton *)sender
{
    self.scrollerStateLabel.text = @"";
}

/** scrollsToTop:该属性为yes时点击状态栏Scrollerview会滚动到顶部,默认为YES */
- (IBAction)allowScrollerToTop:(UISwitch *)sender
{
    self.scrollerView.scrollsToTop = sender.on;
}


@end
