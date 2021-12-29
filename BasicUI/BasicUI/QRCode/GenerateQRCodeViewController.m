//
//  GenerateQRCodeViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/19.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "GenerateQRCodeViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "BasicUIDemo.h"
#import "UIImage+SGExtend.h"
#import "QRChangeColorViewController.h"
#import "QRAddCenterLogoViewController.h"
#import "CustomButton.h"
#import "QRcodeManger.h"
#import "ColorfulQRCodeOCVerView.h"
#import "QRCocerImageViewController.h"
#import "GradientViewController.h"
@interface GenerateQRCodeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UIImageView *codeImageView;

@property (nonatomic, strong)UIImage *qrImage;

@property (nonatomic, strong)UIImage *resultImage;

@property (nonatomic, strong)UITextField *codeTextfield;

@property (nonatomic, strong)UIButton *generateQRCode;

@property (nonatomic, strong)UIView *footerView;

@property (nonatomic, strong)UIColor *frontColor;

@property (nonatomic, strong)UIColor *bgColor;

@property (nonatomic, strong)UIImage *centerIcon;

@end

@implementation GenerateQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.codeImageView];
    self.currentLevel = SGQR_CURRENTIONLEVEL_H;
    self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NARBARHEIGHT-TARBARHEIGHT, SCREEN_WIDTH, TARBARHEIGHT)];
    self.footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.footerView];
    [self initBtnConfig];
    [self.view addSubview:self.codeTextfield];
    self.codeTextfield.delegate = self;
    [self.view addSubview:self.generateQRCode];
    [self.generateQRCode addTarget:self action:@selector(generateQRCodeImage) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)generateQRCodeImage
{
    [self.codeTextfield resignFirstResponder];
    if (self.codeTextfield.text.length>0) {
        self.qrImage = [QRcodeManger generateQRCode:self.codeTextfield.text size:CGSizeMake(SCREEN_WIDTH-160, SCREEN_WIDTH-160)];
        self.resultImage = self.qrImage;
        self.codeImageView.image = self.resultImage;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)initBtnConfig
{
    CGFloat space = (SCREEN_WIDTH-40*4)/5;
    
    CustomButton *colorItem = [CustomButton buttonWithType:UIButtonTypeSystem];
    colorItem.imagePosition = CustomButtonImagePositionTop;
    [colorItem setImage:[[UIImage imageNamed:@"edit1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [colorItem setTitle:@"颜色" forState:UIControlStateNormal];
    [colorItem setTintColor:[UIColor colorWithRed:150/255.0 green:205/255.0 blue:205/255.0 alpha:1]];
    colorItem.frame = CGRectMake(space, 5, 40, 40);
    [colorItem addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:colorItem];
    
    
    CustomButton *textItem =[CustomButton buttonWithType:UIButtonTypeSystem];
    textItem.imagePosition = CustomButtonImagePositionTop;
    [textItem setImage:[[UIImage imageNamed:@"edit2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [textItem setTitle:@"渐变" forState:UIControlStateNormal];
    [textItem addTarget:self action:@selector(addGradient) forControlEvents:UIControlEventTouchUpInside];
    [textItem setTintColor:[UIColor colorWithRed:150/255.0 green:205/255.0 blue:205/255.0 alpha:1]];
    textItem.frame = CGRectMake(space*2+40, 5, 40, 40);
    [self.footerView addSubview:textItem];
    
    CustomButton *logoItem =[CustomButton buttonWithType:UIButtonTypeSystem];
    logoItem.imagePosition = CustomButtonImagePositionTop;
     [logoItem setImage:[[UIImage imageNamed:@"edit3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
     [logoItem setTitle:@"logo" forState:UIControlStateNormal];
     [logoItem setTintColor:[UIColor colorWithRed:150/255.0 green:205/255.0 blue:205/255.0 alpha:1]];
    logoItem.frame = CGRectMake(space*3+40*2, 5, 40, 40);
    [logoItem addTarget:self action:@selector(addCenterIcon) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:logoItem];
    
    CustomButton *bgItem =[CustomButton buttonWithType:UIButtonTypeSystem];
    bgItem.imagePosition = CustomButtonImagePositionTop;
    [bgItem setImage:[[UIImage imageNamed:@"edit4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [bgItem setTitle:@"底图" forState:UIControlStateNormal];
    [bgItem setTintColor:[UIColor colorWithRed:150/255.0 green:205/255.0 blue:205/255.0 alpha:1]];
    bgItem.frame = CGRectMake(space*4+40*3, 5, 40, 40);
    [bgItem addTarget:self action:@selector(changebg) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:bgItem];

}

- (void)changeColor
{
    QRChangeColorViewController *changecolorVC = [[QRChangeColorViewController alloc]init];
    changecolorVC.frontColor = self.frontColor;
    changecolorVC.backgroundColor = self.bgColor;
    changecolorVC.qrImage = self.qrImage;
    changecolorVC.resultImage = self.resultImage;
    changecolorVC.centerIcon = self.centerIcon;
    changecolorVC.completeBlock = ^(BOOL ischange, UIImage * _Nullable resultImage, UIColor *frontColor, UIColor *bgColor) {
      if (ischange) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.codeImageView.image = resultImage;
                self.resultImage = resultImage;
                if (frontColor) {
                    self.frontColor = frontColor;
                    self.bgColor = bgColor;
                }
            });
        }
    };
    [self.navigationController pushViewController:changecolorVC animated:YES];
}

- (void)addGradient
{
    GradientViewController *vc = [[GradientViewController alloc]init];
    vc.qrImage = self.qrImage;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addCenterIcon
{
    
    QRAddCenterLogoViewController *addIconVC = [[QRAddCenterLogoViewController alloc]init];
    addIconVC.qrImage = self.qrImage;
    addIconVC.resultImage = self.resultImage;
    addIconVC.frontColor = self.frontColor;
    addIconVC.backgroundColor = self.bgColor;
     addIconVC.completeBlock = ^(BOOL ischange, UIImage * _Nullable resultImage,UIImage *centerIcon) {
         if (ischange) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.codeImageView.image = resultImage;
                 self.resultImage = resultImage;
                 self.centerIcon = centerIcon;
             });
         }
     };
     [self.navigationController pushViewController:addIconVC animated:YES];
}

- (void)changebg

{
    QRCocerImageViewController *vc = [QRCocerImageViewController new];
    vc.qrImage = self.qrImage;
    vc.code = self.codeTextfield.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIImageView *)codeImageView
{
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc]init];
        _codeImageView.frame = CGRectMake(80, 150, SCREEN_WIDTH-160, SCREEN_WIDTH-160);
    }
    return _codeImageView;
}

- (UITextField *)codeTextfield
{
    if (!_codeTextfield) {
        _codeTextfield = [[UITextField alloc]initWithFrame:CGRectMake(40, 80, SCREEN_WIDTH-110, 30)];
        _codeTextfield.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _codeTextfield;
}

- (UIButton *)generateQRCode
{
    if (!_generateQRCode) {
        _generateQRCode = [UIButton buttonWithType:UIButtonTypeSystem];
        _generateQRCode.frame = CGRectMake(SCREEN_WIDTH-90, 80, 80, 30);
        [_generateQRCode setTitle:@"生成" forState:UIControlStateNormal];
    }
    return _generateQRCode;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.codeTextfield resignFirstResponder];
}

@end
