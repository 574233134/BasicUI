//
//  ImageButton.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/14.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "ImageButton.h"

@interface ImageButton ()

@property (strong, nonatomic) IBOutlet UIButton *photoButton;

@property (strong, nonatomic) IBOutlet UIButton *photoAndTitleBtn;


@end

@implementation ImageButton

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"带背景图的button";
    [self initImagePhotoBtn];
    [self initPhotoAndTitleBtn];
}

- (void)initImagePhotoBtn
{
    // 只有button类型为custom时设置image才能显示出来
    [self.photoButton setImage:[UIImage imageNamed:@"btn_normal.jpg"] forState:UIControlStateNormal];
    [self.photoButton setImage:[UIImage imageNamed:@"btn_highlighted.jpg"] forState:UIControlStateHighlighted];
    [self.photoButton setImage:[UIImage imageNamed:@"btn_disable.jpg"] forState:UIControlStateDisabled];
    
}

- (void)initBgImagePhotoBtn
{
    [self.photoButton setBackgroundImage:[UIImage imageNamed:@"btn_normal.jpg"] forState:UIControlStateNormal];
    [self.photoButton setBackgroundImage:[UIImage imageNamed:@"btn_highlighted.jpg"] forState:UIControlStateHighlighted];
    [self.photoButton setBackgroundImage:[UIImage imageNamed:@"btn_disable.jpg"] forState:UIControlStateDisabled];

    [self.photoButton setImage:nil forState:UIControlStateNormal];
    [self.photoButton setImage:nil forState:UIControlStateHighlighted];
    [self.photoButton setImage:nil forState:UIControlStateDisabled];
}

- (void)initPhotoAndTitleBtn
{
    [self.photoAndTitleBtn setImage:[UIImage imageNamed:@"btn_image_normal"] forState:UIControlStateNormal];
    [self.photoAndTitleBtn setImage:[UIImage imageNamed:@"btn_image_heightlighted"] forState:UIControlStateHighlighted];
    [self.photoAndTitleBtn setImage:[UIImage imageNamed:@"btn_image_disable"] forState:UIControlStateDisabled];
    
    [self.photoAndTitleBtn setBackgroundImage:[UIImage imageNamed:@"btn_normal.jpg"] forState:UIControlStateNormal];
    [self.photoAndTitleBtn setBackgroundImage:[UIImage imageNamed:@"btn_highlighted.jpg"] forState:UIControlStateHighlighted];
    [self.photoAndTitleBtn setBackgroundImage:[UIImage imageNamed:@"btn_disable.jpg"] forState:UIControlStateDisabled];
    
    [self.photoAndTitleBtn setTitle:@"正常态" forState:UIControlStateNormal];
    [self.photoAndTitleBtn setTitle:@"高亮状态" forState:UIControlStateHighlighted];
    [self.photoAndTitleBtn setTitle:@"不可用" forState:UIControlStateDisabled];
    
    // 设置image 的边缘距
    [self.photoAndTitleBtn setImageEdgeInsets:UIEdgeInsetsMake(20, 0, 5, 80)];
    // 设置文字的边缘距
    [self.photoAndTitleBtn setTitleEdgeInsets:UIEdgeInsetsMake(20, 80, 5, 10)];

    // 设置button内容展示部分在button.frame内的偏移量
    [self.photoAndTitleBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 120, 0, 20)];
}

- (IBAction)imgOrBgimage:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            [self initImagePhotoBtn];
            break;
        case 1:
            [self initBgImagePhotoBtn];
            break;
        default:
            break;
    }
}

- (IBAction)isUsed:(UISwitch *)sender
{
    [self.photoButton setEnabled:sender.on];
}


@end
