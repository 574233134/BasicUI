//
//  PoperCollectionViewCell.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/25.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "PoperCollectionViewCell.h"
#import <Masonry.h>

#define Distance_To_Top 26.5

@implementation PoperCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
    _logoMA = [[UIImageView alloc] init];
    [self.contentView addSubview:_logoMA];
    [_logoMA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(Distance_To_Top);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _textLabel.textColor = [UIColor colorWithRed:46 / 255.0 green:45 / 255.0 blue:45 / 255.0 alpha:1];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logoMA.mas_centerX);
        make.top.equalTo(self.logoMA.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(86, 12));
    }];
}

@end
