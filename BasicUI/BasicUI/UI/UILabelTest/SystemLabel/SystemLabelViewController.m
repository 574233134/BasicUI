//
//  SystemLabelViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/8/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "SystemLabelViewController.h"

@interface SystemLabelViewController ()

@property (strong, nonatomic) IBOutlet UILabel *testLabel;

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation SystemLabelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"UILabel属性及方法简介";
    [self initTestLabel];
    
}

/**
 * 属性解释
 * 1. shadowColor 阴影颜色
 * 2. shadowOffset 阴影位置 （x 正方向向右→， y正方向向下↓ ）默认为CGSizeMake(0, -1)
 * 3. textAlignment 枚举类型为NSTextAlignment  默认为NSTextAlignmentNatural (iOS9之前,默认是 NSTextAlignmentLeft)
 *      NSTextAlignmentLeft  左对齐
 *      NSTextAlignmentCenter  居中
 *      STextAlignmentRight  右对齐
 *      NSTextAlignmentJustified  最后一行自然对齐
 *      NSTextAlignmentNatural  默认对齐脚本
 * 4. lineBreakMode 枚举类型为NSLineBreakMode 默认为NSLineBreakByTruncatingTail
 *      NSLineBreakByWordWrapping = 0 以空格为边界，保留单词
 *      NSLineBreakByCharWrapping 保留整个字符
 *      NSLineBreakByClipping,   简单剪裁，到边界为止
 *      NSLineBreakByTruncatingHead,  按照"……文字"显示
 *      NSLineBreakByTruncatingTail,  按照"文字……"显示
 *      NSLineBreakByTruncatingMiddle  按照"文字……文字"显示
 * 5. attributedText 类型为NSAttributedString  如果设置，label将忽略上面的属性
 * 6. highlightedTextColor 高亮状态下的文字颜色
 * 7. highlighted 是否为高亮状态 默认为NO
 * 8. userInteractionEnabled 是否允许用户交互 默认为NO
 * 9. enabled Label是否可用 默认为yes
 * 10. numberOfLines 行数限制  设置为0表示不限制行数 默认为1
 * 11. adjustsFontSizeToFitWidth 设置是否自适应Label的font使Label可以放下所有文字内容 默认为NO
 * 12. baselineAdjustment 设置文字基线
 *       UIBaselineAdjustmentAlignBaselines  默认值文本最上端于label中线对齐
 *       UIBaselineAdjustmentAlignCenters 文本中线于label中线对齐
 *       UIBaselineAdjustmentNone  文本最低端与label中线对齐
 * 13. minimumScaleFactor 最小文字大小（与 adjustsFontSizeToFitWidth 属性一起使用）
 * 14. allowsDefaultTighteningForTruncation 默认为NO NS_AVAILABLE_IOS(9_0)
       这个属性是用来设置多行label的最大宽度的
       当自动布局的时候约束这个label的时候这个属性会起作用，
       在自动布局添加约束中，若文本超过了指定的最大宽度的时候文本会另起一行，从而增加了label的高度
 * 15.
 */
- (void) initTestLabel
{
    self.testLabel.backgroundColor = [UIColor blackColor];
    
    self.testLabel.text = @"测试Label123属性及方法测试";
    
    self.testLabel.font = [UIFont systemFontOfSize:20];
    
    self.testLabel.textColor = [UIColor redColor];
    
    self.testLabel.shadowColor = [UIColor cyanColor];
    
    self.testLabel.shadowOffset = CGSizeMake(-1, 1);
    
    self.testLabel.textAlignment = NSTextAlignmentCenter;
    
    self.testLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
    self.testLabel.highlightedTextColor = [UIColor whiteColor];
    
    self.testLabel.highlighted = NO;
    
    self.testLabel.userInteractionEnabled = YES;
    
    self.testLabel.enabled = YES;
    
    self.testLabel.numberOfLines = 1;
    
    self.testLabel.adjustsFontSizeToFitWidth = YES;
    
    self.testLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    self.testLabel.minimumScaleFactor = 10;
    
    self.testLabel.allowsDefaultTighteningForTruncation = YES;
    
}

- (void) setLabelAttributedString
{
    NSString *str = @"为Label设置属性字符串";
    NSDictionary *fontAttributeDic = @{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                       NSForegroundColorAttributeName:[UIColor blueColor],
                                       NSStrokeColorAttributeName:[UIColor orangeColor],
                                       NSStrokeWidthAttributeName: @(-5),
                                       NSUnderlineStyleAttributeName: @(NSUnderlineStyleDouble),
                                       NSUnderlineColorAttributeName: [UIColor blackColor]};
    NSMutableAttributedString *mutableAttributedStr = [[NSMutableAttributedString alloc]initWithString:str attributes:fontAttributeDic];
    self.testLabel.attributedText = mutableAttributedStr;
}

- (IBAction)textTypeChange:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex==0)
    {
        [self initTestLabel];
    }
    else if (sender.selectedSegmentIndex == 1)
    {
        [self setLabelAttributedString];
    }
}


@end
