//
//  ImageCollectionViewCell.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/13.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self creatSubviews];
    }
    return self;
}

- (void)creatSubviews
{
    self.targetImageView = [[UIImageView alloc] init];
    self.targetImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.targetImageView.layer.cornerRadius = 5;
    self.targetImageView.clipsToBounds = YES;
    self.targetImageView.frame = self.contentView.frame;
    [self.contentView addSubview:self.targetImageView];
}

- (void)dragStateDidChange:(UICollectionViewCellDragState)dragState {
     // 在该方法监控到最新的拖动状态，可添加自定义外观和行为
    [super dragStateDidChange:dragState];
    
    switch (dragState) {
        case UICollectionViewCellDragStateNone:
            NSLog(@"UICollectionViewCellDragStateNone");
            break;
            
        case UICollectionViewCellDragStateLifting:
            NSLog(@"UICollectionViewCellDragStateLifting");
            break;
            
        case UICollectionViewCellDragStateDragging:
            NSLog(@"UICollectionViewCellDragStateDragging");
            break;
            
        default:
            break;
    }
    
}

@end
