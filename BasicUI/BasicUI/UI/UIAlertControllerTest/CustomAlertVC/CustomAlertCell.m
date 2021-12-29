//
//  CustomAlertCell.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/26.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomAlertCell.h"
#import "UIView+frame.h"
#import "CustomAlertLayout.h"
#import "CustomAlertAction.h"
@interface CustomAlertCell()
    
@property (nonatomic, strong) UIView *line;
    
@end

@implementation CustomAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(YXTableViewCellStyle)type
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        if (type == YXTableViewCellStyleAlert)
        {
            self.contentView.frame = CGRectMake(0, 0, WIDTHSCALE(270), 44.0);
        }
        else
        {
            self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH - left_X * 2, 57.0);
        }
        [self createUI];
    }
    return self;
}
    
- (void)loadDataWithAlertAction:(CustomAlertAction *)action
{
    if (action == nil)
    {
        return;
    }
    CustomAlertLayout *layout = [action getActionLayout];
    switch (action.style)
    {
        case CustomAlertActionStyleDone:
        {
            self.titleLabel.textColor = layout.doneActionTitleColor;
            self.titleLabel.font = layout.doneActionTitleFont;
            self.backgroundColor = layout.doneActionBackgroundColor;
        }
        break;
        case CustomAlertActionStyleCancel:
        {
            self.titleLabel.textColor = layout.cancelActionTitleColor;
            self.titleLabel.font = layout.cancelActionTitleFont;
            self.backgroundColor = layout.cancelActionBackgroundColor;
        }
        break;
        default:
        {
            self.titleLabel.textColor = layout.defaultActionTitleColor;
            self.titleLabel.font = layout.defaultActionTitleFont;
            self.backgroundColor = layout.defaultActionBackgroundColor;
        }
        break;
    }
    
    self.titleLabel.text = action.title;
    self.line.backgroundColor = layout.lineColor;
}
    
- (void)setIsHidenLine:(BOOL)isHidenLine
{
    _isHidenLine = isHidenLine;
    self.line.hidden = isHidenLine;
}
    
#pragma mark - createUI
- (void)createUI
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height - 0.5)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom, self.titleLabel.width, 0.5)];
    self.line.backgroundColor = DEFAULT_LINECOLOR;
    self.line.hidden = self.isHidenLine;
    [self.contentView addSubview:self.line];
}

@end
