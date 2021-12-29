//
//  QRChangeColorViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/19.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "QRChangeColorViewController.h"
#import "BasicUIDemo.h"
#import "CustomButton.h"
#import "PoperViewControllerTwo.h"
#import "ColorPoperViewController.h"
#import "QRcodeManger.h"
#import "UIColor+hexColor.h"
@interface QRChangeColorViewController ()<ColorPoperViewControllerDelegate,UIPopoverControllerDelegate>


@property (nonatomic, strong)UIImageView *codeImageView;
@property (nonatomic, strong)UIView *footerView;

@property (nonatomic, strong)CustomButton *frontItem;
@property (nonatomic, strong)CustomButton *backItem;


@end

@implementation QRChangeColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.codeImageView];
    self.codeImageView.image = self.resultImage;
    self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-TARBARHEIGHT, SCREEN_WIDTH, TARBARHEIGHT)];
    self.footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.footerView];
    [self initBtnConfig];
    if (!self.frontColor) {
        self.frontColor = [UIColor blackColor];
    }
    if (!self.backgroundColor)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
}


- (void)cancleChangeColor
{
    self.completeBlock(NO, nil,nil,nil);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commitChangeColor
{
    UIImage *result = self.codeImageView.image;
    self.completeBlock(YES, result,self.frontColor,self.backgroundColor);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - UI设置
- (void)initBtnConfig
{
    
    self.frontItem = [CustomButton buttonWithType:UIButtonTypeSystem];
    self.frontItem.imagePosition = CustomButtonImagePositionTop;
    [self.frontItem setImage:[[UIImage imageNamed:@"frontIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.frontItem setTitle:@"前景色" forState:UIControlStateNormal];
    [self.frontItem setTintColor:[UIColor colorWithRed:150/255.0 green:205/255.0 blue:205/255.0 alpha:1]];
    self.frontItem.frame = CGRectMake(30, SCREEN_HEIGHT-TARBARHEIGHT-70, 80, 40);
    self.frontItem.tag = 101;
    [self.frontItem addTarget:self action:@selector(poper:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.frontItem];
    
    
    self.backItem =[CustomButton buttonWithType:UIButtonTypeSystem];
    self.backItem.imagePosition = CustomButtonImagePositionTop;
    self.backItem.tag = 102;
    [self.backItem setImage:[[UIImage imageNamed:@"backIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.backItem setTitle:@"背景色" forState:UIControlStateNormal];
    [self.backItem setTintColor:[UIColor colorWithRed:150/255.0 green:205/255.0 blue:205/255.0 alpha:1]];
    self.backItem.frame = CGRectMake(SCREEN_WIDTH-110, SCREEN_HEIGHT-TARBARHEIGHT-70, 80, 40);
    [self.backItem addTarget:self action:@selector(poper:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backItem];
    
    UIButton *cancleItem =[UIButton buttonWithType:UIButtonTypeSystem];
     [cancleItem setImage:[[UIImage imageNamed:@"cancle"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    cancleItem.frame = CGRectMake(30, 5, 40, 40);
    [cancleItem addTarget:self action:@selector(cancleChangeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:cancleItem];
    
    UIButton *commitItem =[UIButton buttonWithType:UIButtonTypeSystem];
    [commitItem setImage:[[UIImage imageNamed:@"commit"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    commitItem.frame = CGRectMake(SCREEN_WIDTH-70, 5, 40, 40);
    [commitItem addTarget:self action:@selector(commitChangeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:commitItem];

    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 5, 100, 40)];
    label.text = @"颜色";
    label.textAlignment = NSTextAlignmentCenter;
    [self.footerView addSubview:label];
}

- (NSArray *)getColorArr
{
    NSArray *colors =  @[[UIColor whiteColor],
                         [UIColor blackColor],
                         [UIColor redColor],
                         [UIColor orangeColor],
                         [UIColor purpleColor],
                         [UIColor blueColor],
                         [UIColor brownColor],
                         [UIColor colorWithHexString:@"#FA8072"],
                         [UIColor colorWithHexString:@"F4A460"],
                         [UIColor colorWithHexString:@"EE82EE"],
                         [UIColor colorWithHexString:@"CD8500"],
                         [UIColor colorWithHexString:@"C67171"],
                         [UIColor colorWithHexString:@"ABABAB"],
                         [UIColor colorWithHexString:@"9ACD32"],
                         [UIColor colorWithHexString:@"66CDAA"],
                         [UIColor colorWithHexString:@"00C5CD"],
                         [UIColor colorWithHexString:@"008B00"],
                         [UIColor colorWithHexString:@"#FFF68F"],
                         [UIColor colorWithHexString:@"#FFF0F5"],
                         [UIColor colorWithHexString:@"C71585"],
                         [UIColor colorWithHexString:@"9B30FF"],
                         [UIColor colorWithHexString:@"#FFE7BA"],
                         [UIColor colorWithHexString:@"#8B814C"],
                         [UIColor colorWithHexString:@"#528B8B"],
                         [UIColor colorWithHexString:@"#4682B4"],
                         [UIColor colorWithHexString:@"#FF1493"],
                         [UIColor colorWithHexString:@"#EE9A49"]
    ];
    
    return colors;
}

- (void)poper:(UIButton *)btn
{
    NSArray *array = [self getColorArr];
    ColorPoperViewController *poperTwoVC = [[ColorPoperViewController alloc]init];
    poperTwoVC.modalPresentationStyle = UIModalPresentationPopover;
    poperTwoVC.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, 120);
    poperTwoVC.fromTag = btn.tag;
    // 需要通过 sourceView 来判断位置的
    poperTwoVC.popoverPresentationController.sourceView = btn;
    poperTwoVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    // 指定箭头所指区域的矩形框范围（位置和尺寸）,以sourceView的左上角为坐标原点
    poperTwoVC.popoverPresentationController.sourceRect = btn.bounds;
    // 设置代理
    poperTwoVC.popoverPresentationController.delegate = self;
    poperTwoVC.popoverPresentationController.backgroundColor = [UIColor grayColor];
    poperTwoVC.delegate = self;
    [self presentViewController:poperTwoVC animated:YES completion:nil];
    poperTwoVC.dataList = [NSMutableArray arrayWithArray:array];
    [poperTwoVC reloadData];
}

- (UIImageView *)codeImageView
{
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc]init];
        _codeImageView.frame = CGRectMake(80, 80, SCREEN_WIDTH-160, SCREEN_WIDTH-160);
    }
    return _codeImageView;
}

#pragma mark - UIPopoverPresentationController Delegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone; //不适配
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    return YES; //点击蒙版popover消失， 默认YES
}

#pragma mark - ColorPoperViewControllerDelegate
- (void)selectAtIndex:(NSIndexPath *)indexPath data:(nonnull UIColor *)color fromTag:(NSInteger)fromTag
{
    if (fromTag == 101) {
        self.frontColor = color;
        self.resultImage = [QRcodeManger changeQRColor:self.qrImage qrcolor:color bgColor:self.backgroundColor];
    }
    else if(fromTag == 102)
    {
        self.backgroundColor = color;
        self.resultImage = [QRcodeManger changeQRColor:self.qrImage qrcolor:self.frontColor bgColor:color];
        
    }
    if (self.centerIcon) {
       UIImage *image = [QRcodeManger addCenterIcon:self.resultImage icon:self.centerIcon size:40];
        self.resultImage = image;
    }
    self.codeImageView.image = self.resultImage;

}

@end
