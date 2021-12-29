//
//  DeleteCollectionViewCell.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/15.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "DeleteCollectionViewCell.h"
CGFloat const cornerRadius = 5.0f;
@implementation DeleteCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.deleteButton.hidden = YES;
    [self.deleteButton addTarget:self action:@selector(deletingAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)deletingAction:(UIButton *)sender
{
    [self.deleteDelegate deleteCellAction:self.center];
}

@end
