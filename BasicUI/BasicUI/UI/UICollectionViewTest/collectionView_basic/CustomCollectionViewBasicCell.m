//
//  CustomCollectionViewBasicCell.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/12.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomCollectionViewBasicCell.h"

@implementation CustomCollectionViewBasicCell

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
    self.textLabel = [[UILabel alloc]init];
    if (self.contentView.frame.size.height<40)
    {
        return;
    }
    self.textLabel.frame = CGRectMake(0, (self.contentView.frame.size.height-40)/2,self.contentView.frame.size.width , 40);
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.textLabel];
    
}

@end
