//
//  StudentCardCell.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/18.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "StudentCardCell.h"
#import <Masonry.h>
@implementation StudentCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView
{
    UILabel *name = [[UILabel alloc]init];
    name.text = @"姓名:";
    name.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    self.nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.font = [UIFont systemFontOfSize:20];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_right).offset(5);
        make.top.equalTo(name.mas_top);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    UILabel *sex = [[UILabel alloc]init];
    sex.text = @"性别:";
    [self.contentView addSubview:sex];
    [sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(name.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    self.sexLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.sexLabel];
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo (sex.mas_top);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    UILabel *age = [[UILabel alloc]init];
    age.text = @"年龄:";
    [self.contentView addSubview:age];
    [age mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(sex.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    self.ageLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.ageLabel];
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(age.mas_top);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    
    UILabel *height = [[UILabel alloc]init];
    height.text = @"身高:";
    [self.contentView addSubview:height];
    [height mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(age.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    self.heightLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.heightLabel];
    [self.heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(height.mas_top);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
}

@end
