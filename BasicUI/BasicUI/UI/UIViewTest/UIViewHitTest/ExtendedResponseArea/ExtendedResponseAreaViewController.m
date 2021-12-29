//
//  ExtendedResponseAreaViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/21.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ExtendedResponseAreaViewController.h"
#import "HeadPortraitImageView.h"
#import "HitTestViewTwo.h"
@interface ExtendedResponseAreaViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet HeadPortraitImageView *img2;

@property (strong, nonatomic) IBOutlet HitTestViewTwo *hittestViewTwo;

@property (strong, nonatomic) IBOutlet HeadPortraitImageView *img3;

@property (strong, nonatomic) IBOutlet HeadPortraitImageView *img4;

@property (strong, nonatomic) IBOutlet UIView *View4;


@end

@implementation ExtendedResponseAreaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"扩大点击区域";
    
    self.imageView.userInteractionEnabled = YES;
    
    self.img2.userInteractionEnabled = YES;
    
    self.img3.userInteractionEnabled = YES;
    
    self.hittestViewTwo.responderView = self.img3;
    
    self.View4.userInteractionEnabled = YES;
    
    self.img4.userInteractionEnabled = YES;
    
    self.img4.minimumHitTestWidth = 108;
    
    self.img4.minimumHitTestHeight = 109;
    
}





@end
