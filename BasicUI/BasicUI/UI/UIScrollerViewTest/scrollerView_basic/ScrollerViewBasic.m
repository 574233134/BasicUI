//
//  ScrollerViewBasic.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/21.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ScrollerViewBasic.h"
#import "BasicUIDemo.h"
@interface ScrollerViewBasic ()<UITextFieldDelegate>

@property (strong, nonatomic)UIScrollView *scrollerView;

/** XIB 控件 */
@property (strong, nonatomic) IBOutlet UISwitch *directionLockEnableSW;

@property (strong, nonatomic) IBOutlet UISwitch *bounceSW;

@property (strong, nonatomic) IBOutlet UISwitch *bounceVerticalSW;

@property (strong, nonatomic) IBOutlet UISwitch *bounceHorizonSW;

@property (strong, nonatomic) IBOutlet UISwitch *pagingEnableSW;

@property (strong, nonatomic) IBOutlet UISwitch *scrollerEnableSW;

@property (strong, nonatomic) IBOutlet UISwitch *verticalIndicatorSW;

@property (strong, nonatomic) IBOutlet UISwitch *horizonIndicatorSW;

@property (strong, nonatomic) IBOutlet UITextField *offsetX;

@property (strong, nonatomic) IBOutlet UITextField *offsetY;

@property (strong, nonatomic) IBOutlet UITextField *leftIndicaror;// indicator 左侧偏移

@property (strong, nonatomic) IBOutlet UITextField *topIndicator;// indicator 上侧偏移

@property (strong, nonatomic) IBOutlet UITextField *rightIndicator; // indicator 右侧偏移

@property (strong, nonatomic) IBOutlet UITextField *bottomIndicator; // indicator 下侧偏移

@end

@implementation ScrollerViewBasic

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"scrollerView 基础";
    self.view.backgroundColor = [UIColor whiteColor];
    [self textfieldSetup];
    [self creatScrollerView];
    [self divisionScrollerView];
}

- (void)creatScrollerView
{
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 300)];
    self.scrollerView.backgroundColor = [UIColor redColor];
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

- (void)textfieldSetup
{
    self.offsetX.delegate = self;
    self.offsetY.delegate = self;
    self.leftIndicaror.delegate = self;
    self.topIndicator.delegate  = self;
    self.rightIndicator.delegate = self;
    self.bottomIndicator.delegate = self;
}

#pragma mark - xib action
/** directionalLockEnabled:设置滑动视图是否锁定滚动方向 */
- (IBAction)directionalLock:(UISwitch *)sender
{
    self.scrollerView.directionalLockEnabled = sender.on;
}

/** bounces: 设置滚动视图是否反弹 */
- (IBAction)bounces:(UISwitch *)sender
{
    self.scrollerView.bounces = sender.on;
}

/** alwaysBounceVertical：如果为YES并且bounces是YES，即使内容小于界限，也允许垂直拖动  */
- (IBAction)bounceVertical:(UISwitch *)sender
{
    self.scrollerView.alwaysBounceVertical = sender.on;
}

/** alwaysBounceHorizontal: 如果为YES并且bounces是YES，即使内容小于界限，也允许水平拖动 */
- (IBAction)bounceHorizontal:(UISwitch *)sender
{
    self.scrollerView.alwaysBounceHorizontal = sender.on;
}

/** pagingEnabled：是否分页滚动 */
- (IBAction)pagingEnabled:(UISwitch *)sender
{
    self.scrollerView.pagingEnabled = sender.on;
}

/** scrollEnabled: 是否允许滚动 */
- (IBAction)scrollEnabled:(UISwitch *)sender
{
    self.scrollerView.scrollEnabled = sender.on;
}

/** showsVerticalScrollIndicator: 是否展示垂直方向滚动条 */
- (IBAction)showsVerticalScrollIndicator:(UISwitch *)sender
{
    self.scrollerView.showsVerticalScrollIndicator = sender.on;
}

/** showsHorizontalScrollIndicator: 是否展示水平方向滚动条 */
- (IBAction)showsHorizontalScrollIndicator:(UISwitch *)sender

{
    self.scrollerView.showsHorizontalScrollIndicator = sender.on;
}

/** contentOffset：scrollerView 内容的偏移量 */
- (IBAction)setScrollerOffset:(UIButton *)sender
{
    CGFloat X = [self.offsetX.text floatValue];
    CGFloat Y = [self.offsetY.text floatValue];
    self.scrollerView.contentOffset = CGPointMake(X, Y);
}

/** 设置scrollerview滚动条位置(上下左右都是滚动条距离scrollerView的距离) */
- (IBAction)setIndicatorInsets:(UIButton *)sender
{
    CGFloat top = [self.topIndicator.text floatValue];
    CGFloat left = [self.leftIndicaror.text floatValue];
    CGFloat right = [self.rightIndicator.text floatValue];
    CGFloat bottom = [self.bottomIndicator.text floatValue];
    self.scrollerView.scrollIndicatorInsets = UIEdgeInsetsMake(top, left, bottom, right);
}

/** indicatorStyle：设置滚动条风格 */
- (IBAction)setIndicatorStyle:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            self.scrollerView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
            break;
        case 1:
            self.scrollerView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
            break;
        case 2:
            self.scrollerView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
            break;
        default:
            break;
    }
}

/** flashScrollIndicators：短时间展示一下滚动条 */
- (IBAction)showIdicator:(UIButton *)sender
{
    [self.scrollerView flashScrollIndicators];
}


@end
