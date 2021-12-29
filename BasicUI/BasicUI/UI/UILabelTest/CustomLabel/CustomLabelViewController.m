//
//  CustomLabelViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/6.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomLabelViewController.h"
#import "CustomLabel.h"

@interface CustomLabelViewController ()

@property (strong, nonatomic) CustomLabel *label1;

@property (strong, nonatomic) IBOutlet UILabel *allRoundedCornersLabel;

@property (strong, nonatomic) IBOutlet UILabel *upCornersLabel;

@property (strong, nonatomic) IBOutlet UILabel *downCornersLabel;

@property (strong, nonatomic) IBOutlet UILabel *sigleCornersLabel;

@property (strong, nonatomic) IBOutlet CustomLabel *siglekeywordChange;

@property (strong, nonatomic) IBOutlet CustomLabel *allkeywordsChange;

@property (strong, nonatomic) IBOutlet CustomLabel *autoHeightLabel;

@property (strong, nonatomic) IBOutlet CustomLabel *autoWidthLabel;


@end

@implementation CustomLabelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义Label样式";
    [self.view addSubview:self.label1];
    [self initRoundedCorners];
    [self assignForLabel];
    [self oneLableHasDifferentColorTest];
    [self adaptiveHeightOrWidth];
}

- (CustomLabel *)label1
{
    if (_label1 == nil)
    {
        _label1 = [[CustomLabel alloc]init];
        _label1.frame = CGRectMake(100, 80, 300, 40);
    }
    return _label1;
}

- (void)assignForLabel
{
    self.label1.text = @"重写label两个方法";
    self.label1.font = [UIFont systemFontOfSize:30];
    self.allRoundedCornersLabel.layer.cornerRadius = 10;
    self.allRoundedCornersLabel.clipsToBounds = YES;
    self.autoWidthLabel.numberOfLines = 0;
    self.autoHeightLabel.numberOfLines = 0;
}


- (void)initRoundedCorners
{

    UIBezierPath *upmaskPath = [UIBezierPath bezierPathWithRoundedRect:_upCornersLabel.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *upmaskLayer = [[CAShapeLayer alloc] init];
    upmaskLayer.frame = _upCornersLabel.bounds;
    upmaskLayer.path = upmaskPath.CGPath;
    _upCornersLabel.layer.mask = upmaskLayer;
    
    UIBezierPath *downmaskPath = [UIBezierPath bezierPathWithRoundedRect:_downCornersLabel.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *downmaskLayer = [[CAShapeLayer alloc] init];
    downmaskLayer.frame = _downCornersLabel.bounds;
    downmaskLayer.path = downmaskPath.CGPath;
    _downCornersLabel.layer.mask = downmaskLayer;
    
    UIBezierPath *singlemaskPath = [UIBezierPath bezierPathWithRoundedRect:_sigleCornersLabel.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *singlemaskLayer = [[CAShapeLayer alloc] init];
    singlemaskLayer.frame = _sigleCornersLabel.bounds;
    singlemaskLayer.path = singlemaskPath.CGPath;
    _sigleCornersLabel.layer.mask = singlemaskLayer;

}

- (void)oneLableHasDifferentColorTest
{
    [self.siglekeywordChange expicalWords:@"红色" color:[UIColor redColor]];
    [self.allkeywordsChange  containWords:@"红色" color:[UIColor redColor]];
}

- (void)adaptiveHeightOrWidth
{
    CGFloat width = [self.autoWidthLabel calculateRowWidthString:self.autoWidthLabel.text withHeight:142 andFont:[UIFont systemFontOfSize:17]];
    self.autoWidthLabel.frame = CGRectMake(self.autoWidthLabel.frame.origin.x,self.autoWidthLabel.frame.origin.y, width, 142);
    
    
    CGFloat height = [self.autoHeightLabel calculateRowHeightString:self.autoHeightLabel.text withWidth:107 andFont:[UIFont systemFontOfSize:17]];
    self.autoHeightLabel.frame = CGRectMake(self.autoHeightLabel.frame.origin.x, self.autoHeightLabel.frame.origin.y, 107, height);
}

@end
