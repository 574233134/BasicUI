//
//  CALayerDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/1/3.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "CALayerDemo.h"
#import <QuartzCore/QuartzCore.h>
@interface CALayerDemo ()

@property (strong ,nonatomic)CALayer *testLayer;

@end

@implementation CALayerDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTestLayer];
    [self creatBtn];
}

- (void)creatTestLayer
{
    self.testLayer = [[CALayer alloc]init];
    self.testLayer.frame = CGRectMake(100, 100, 200, 200);
    [self.view.layer addSublayer:self.testLayer];
    
    self.testLayer.backgroundColor = [UIColor cyanColor].CGColor;
    self.testLayer.cornerRadius = 5;
    self.testLayer.borderWidth = 3;
    self.testLayer.borderColor = [UIColor blackColor].CGColor;
    
}

- (void)creatBtn
{
    UIButton *changeFrame = [UIButton buttonWithType:UIButtonTypeSystem];
    changeFrame.frame = CGRectMake(100, 320, 150, 40);
    changeFrame.backgroundColor = [UIColor redColor];
    [changeFrame setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeFrame setTitle:@"改变layer的frame" forState:UIControlStateNormal];
    [changeFrame addTarget:self action:@selector(displayLayerAnimate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeFrame];
    
    UIButton *screenshots =[UIButton buttonWithType:UIButtonTypeSystem];
    screenshots.frame = CGRectMake(100, 380, 150, 40);
    screenshots.backgroundColor = [UIColor redColor];
    [screenshots setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [screenshots setTitle:@"截图" forState:UIControlStateNormal];
    [screenshots addTarget:self action:@selector(screenShots) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:screenshots];
    
    
}

- (void)displayLayerAnimate
{
    self.testLayer.frame = CGRectMake(100, 100, 100, 100);
}


- (void)screenShots
{
    //Document目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"1.png"]];
    [self clipScreenWithPath:filePath type:@"png" UIView:self.view];
}

/**
 
  *  把一个UIView生成PNG或者JPG格式的图片,保存在指定路径
 
  *  @param path   图片要保存到的路径
 
  *  @param type   图片的格式png或者jpg
 
  *  @param view 要转成图片的UIView
 
  */

- (void)clipScreenWithPath:(NSString *)path type:(NSString *)type UIView:(UIView *)view

{
    
    //1. 开启一个和传进来的View大小一样的位图上下文
    UIGraphicsBeginImageContextWithOptions (view.bounds.size , YES , 0);
    
    //2. 把控制器的View绘制到上下文当中
    
    //想把UIView上面的东西绘制到上下文当中,必须得使用渲染的方式
    //renderInContext:就是渲染的方式
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx ];
    
    //3. 从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //4. 关闭上下文
    UIGraphicsEndImageContext();
    
    //5.把生成的图片写入到桌面(以文件的方式进行传输:二进制流NSData,即把图片转为二进制流)
    NSData *data;
    if ([type isEqualToString:@"png"])
    {
        //生成PNG格式的图片
        data = UIImagePNGRepresentation(newImage);
     }
    else if ([type isEqualToString:@"jpg"])
    {
        // 5.1把图片转为二进制流(第一个参数是图片,第2个参数是图片压缩质量:1是最原始的质量)
        data = UIImageJPEGRepresentation(newImage,1);
    }
   

    // 保存到相册
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), @"123");

    [data writeToFile:path atomically:YES];
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil)
    {
        [self alertWithTitle:@"提示" message:@"已存入相册"];
    }
    else
    {
        [self alertWithTitle:@"提示" message:@"保存失败"];
    }
    
}

#pragma mark - 封装警告框
-(void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}


@end
