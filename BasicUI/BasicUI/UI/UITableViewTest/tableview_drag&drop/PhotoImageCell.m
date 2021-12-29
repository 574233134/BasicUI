//
//  PhotoImageCell.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "PhotoImageCell.h"

@implementation PhotoImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self creatUI];
    }
    return self;
}

- (void)creatUI
{
    [self.contentView addSubview:self.targetImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 20;
    self.targetImageView.frame = CGRectMake(margin, margin, self.bounds.size.width-2*margin, self.bounds.size.height-2*margin);
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - setters && getters
- (UIImageView *)targetImageView
{
    if (!_targetImageView)
    {
        _targetImageView = [[UIImageView alloc] init];
        _targetImageView.contentMode = UIViewContentModeScaleAspectFill;
        _targetImageView.layer.cornerRadius = 10;
        _targetImageView.clipsToBounds = YES;
    }
    return _targetImageView;
}


@end
