//
//  CustomAlertView.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/26.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomAlertView.h"
#import "CustomAlertAction.h"
#import "CustomAlertController.h"
#import "UIView+frame.h"
#import "CustomAlertCell.h"

#define MAX_HEIGHT SCREEN_HEIGHT - HEIGHTSCALE(18) * 2
#define LABEL_MAGIRN 2 //messageLabel与titleLabel之间的上下间距

@interface CustomAlertView()<UITableViewDelegate,UITableViewDataSource>
//UI
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

//确定和取消按钮
@property (nonatomic, strong) CustomAlertAction *cancelButton;
@property (nonatomic, strong) CustomAlertAction *okButton;

@property (nonatomic, strong) NSMutableArray <CustomAlertAction *> *okButtons; // style!=cancle 的所有按钮

@property (nonatomic, strong) NSMutableArray <CustomAlertAction *> *cancelButtons;// 取消按钮

//action多于2个时，列表显示
@property (nonatomic, strong) UITableView *actionListView;

//数据
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSMutableArray <CustomAlertAction *> *actionArray;
@property (nonatomic, strong, readwrite) NSArray <CustomAlertAction *> *actions;

@end

@implementation CustomAlertView

- (instancetype)init
{
    if (self = [super init])
    {
        [self configureProperties];
        [self createUI];
    }
    return self;
}
    
// UI属性设置
- (void)configureProperties
{
    
    self.layout = [[CustomAlertLayout alloc] initWithStyle:CustomAlertLayoutStyleAlert];
    //设置圆角
    self.layer.cornerRadius = WIDTHSCALE(10);
    self.layer.masksToBounds = YES;
    //actionArray
    self.actionArray = [NSMutableArray array];
    self.okButtons = [NSMutableArray array];
    self.cancelButtons = [NSMutableArray array];
}

// 创建alertView;
+ (instancetype)alertViewWith:(NSString *)title message:(NSString *)message
{
    CustomAlertView *alertView = [[CustomAlertView alloc] init];
    if (message.length > 0 && title.length > 0)
    {
        alertView.title = title;
        alertView.message = message;
    }
    else if(message.length == 0 && title.length > 0)
    {
        alertView.title = title;
    }
    else if(message.length > 0 && title.length == 0)
    {
        alertView.title = message;
    }
    else
    {
        NSLog(@"没有标题和信息");
        return nil;
    }
    return alertView;
}
    
// 修改数据源(根据Action个数)
- (void)addAction:(CustomAlertAction *)action
{
    if (action == nil)
    {
        return;
    }
    if (action.style != CustomAlertActionStyleCancel)
    {
        [self.okButtons addObject:action];
    }
    else
    {
        [self.cancelButtons addObject:action];
        if (self.cancelButtons.count > 1)
        {
            NSLog(@"只允许存在一个取消按钮");
            return;
        }
    }
    [self.actionArray addObject:action];
    self.actions = [self.actionArray copy];
    if (self.actions.count < 3)
    {
        [self setActionUI];
    }
    else
    {
        [self.actionArray removeAllObjects];
        [self.actionArray addObjectsFromArray:self.okButtons];
        [self.actionArray addObjectsFromArray:self.cancelButtons];
        self.actions = [self.actionArray copy];
        [self.okButton removeFromSuperview];
        [self.cancelButton removeFromSuperview];
        [self addSubview:self.actionListView];
        [self.actionListView reloadData];
    }
}
    
    
#pragma mark - UITableViewDataSource / UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.actions.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifer = @"alertViewCell";
    CustomAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
    if (cell == nil)
    {
        cell = [[CustomAlertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifer cellType:YXTableViewCellStyleAlert];
    }
    CustomAlertAction *action = self.actions[indexPath.row];
    [cell loadDataWithAlertAction:action];
    cell.isHidenLine = indexPath.row == self.actions.count - 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustomAlertAction *action = self.actions[indexPath.row];
    action.handler ? action.handler(action) : nil;
    [self.clickActionDelegate didClickAlertAction];
   
}
    
#pragma mark - text&font&colorSet
- (void)setLayout:(CustomAlertLayout *)layout
{
    if (layout == nil)
    {
        return;
    }
    _layout = layout;
    self.backgroundColor = layout.lineColor;
    //设置action的layout
    for (CustomAlertAction *action in self.actions)
    {
        [action setActionLayout:layout];
    }
    [self.actionListView reloadData];
    self.labelView.backgroundColor = layout.topViewBackgroundColor;
    self.titleLabel.font = layout.titleFont;
    self.titleLabel.textColor = layout.titleColor;
    self.messageLabel.font = layout.messageFont;
    self.messageLabel.textColor = layout.messageColor;
    
}
    
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.attributedText = [self setLableLineMarginWithLableFont:self.layout.titleFont andString:title maxWidth:WIDTHSCALE(238) lineSpace:5];
}
    
- (void)setMessage:(NSString *)message{
    _message = message;
    self.messageLabel.attributedText = [self setLableLineMarginWithLableFont:self.layout.messageFont andString:message maxWidth:WIDTHSCALE(238) lineSpace:3];
}
    
#pragma mark - createUI
    
- (void)createUI
{
    
    self.labelView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        view;
    });
    
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = self.layout.titleFont;
        label.textColor = self.layout.titleColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self.labelView addSubview:label];
        label;
    });
    
    self.messageLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = self.layout.messageFont;
        label.textColor = self.layout.messageColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [self.labelView addSubview:label];
        label;
    });
    
}
    
- (UITableView *)actionListView{
    if (_actionListView == nil) {
        _actionListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _actionListView.dataSource = self;
        _actionListView.delegate = self;
        _actionListView.rowHeight = 44.0;
        _actionListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _actionListView;
}
    
- (void)setActionUI
{
    if (self.actions.count == 1)
    {
        CustomAlertAction *action = self.actions.firstObject;
        self.cancelButton = action;
        [self addSubview:action];
    }
    else
    {
        //两个都是default
        if (self.okButtons.count == self.actions.count)
        {
            CustomAlertAction *action = self.actions.lastObject;
            self.okButton = action;
            [self addSubview:action];
        }
        else
        {
            [self.cancelButton removeFromSuperview];
            for (CustomAlertAction *action in self.actions)
            {
                if (action.style == CustomAlertActionStyleCancel)
                {
                    self.cancelButton = action;
                }
                else
                {
                    self.okButton = action;
                }
                [self addSubview:action];
            }
        }
    }
}
    
    
    
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleHeight = [self heightForLableTextAndLineSapceWithFont:self.layout.titleFont string:self.title maxWidth:WIDTHSCALE(238) lineSpace:5];
    CGFloat messageHeight = [self heightForLableTextAndLineSapceWithFont:self.layout.messageFont string:self.message maxWidth:WIDTHSCALE(238) lineSpace:3];
    CGFloat titleY = HEIGHTSCALE(18.5);
    // 文本高度 (title and message)
    CGFloat alertTopHeight = titleY + HEIGHTSCALE(19) + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0) + titleHeight + (self.message.length > 0 ? messageHeight : 0);
    // 按钮高度
    CGFloat alertActionsHeight = self.actions.count > 2 ? self.actions.count * HEIGHTSCALE(44) : HEIGHTSCALE(44);
    
    if ((alertTopHeight + alertActionsHeight) > MAX_HEIGHT)
    {
        alertActionsHeight = MAX_HEIGHT - alertTopHeight;
        self.actionListView.scrollEnabled = YES;
        // 当弹框实际高度大于最大高度时，并且有style == cancel的action，那么把tableView滚动到最底部，显示取消按钮
        if (self.cancelButtons.count > 0)
        {
            [self.actionListView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.actions.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
        //并调整titleLabel的y值
        titleY = HEIGHTSCALE(5);
        //更新文本高度
        alertTopHeight = titleY + HEIGHTSCALE(19) + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0) + titleHeight + (self.message.length > 0 ? messageHeight : 0);
        
    }
    else
    {
        self.actionListView.scrollEnabled = NO;
    }
    // alertView
    self.frame = CGRectMake(0, 0, WIDTHSCALE(ALERT_WIDTH), alertTopHeight + alertActionsHeight);
    
    self.labelView.frame = CGRectMake(0, 0, self.width, alertTopHeight);
    // title
    self.titleLabel.frame = CGRectMake(WIDTHSCALE(label_X), titleY, self.width - WIDTHSCALE(label_X) * 2, titleHeight);
    // message
    self.messageLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0), self.titleLabel.width, messageHeight);
    
    // 0.5 是分割线
    CGFloat actionsY = alertTopHeight + 0.5;
    
    //确定-取消按钮
    if (self.actions.count == 1)
    {
        self.cancelButton.frame = CGRectMake(0, actionsY, self.width, HEIGHTSCALE(44));
    }
    else if (self.actions.count == 2)
    {
        self.cancelButton.frame = CGRectMake(0, actionsY, self.width / 2 - 0.5, HEIGHTSCALE(44));
        self.okButton.frame = CGRectMake(self.width / 2, actionsY, self.width / 2, HEIGHTSCALE(44));
    }
    else if (self.actions.count > 2)
    {
        //按钮列表的frame
        self.actionListView.frame = CGRectMake(0, actionsY, self.width, self.actions.count > 2 ? alertActionsHeight : 0);
    }
}
  
    
//调整行间距
- (NSAttributedString *)setLableLineMarginWithLableFont:(UIFont *)font andString:(NSString *)string maxWidth:(CGFloat)maxWidth lineSpace:(CGFloat)lineSpace
{
    if (!string.length)
    {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    CGFloat offset = -(1.0/3 * lineSpace) - 1.0/3;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    paragraphStyle.alignment = NSTextAlignmentCenter;// 对齐方式
    NSDictionary *attrs = @{
                            NSFontAttributeName : font,
                            NSParagraphStyleAttributeName : paragraphStyle,
                            };
    // 计算一行文本的高度
    CGFloat oneHeight = [@"测试Test" boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
    CGFloat rowHeight = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
    // 如果超出一行，则offset=0;
    offset = rowHeight > oneHeight ? 0 : offset;
    return  [self getAttributedStringWithString:string lineSpace:lineSpace baselineOffset:offset];
}
    
    
- (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace baselineOffset:(CGFloat)baselineOffset
{
    if (string.length == 0)
    {
        return nil;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //对齐方式
    paragraphStyle.alignment = NSTextAlignmentCenter;
    // 调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    // 首行缩进
    paragraphStyle.firstLineHeadIndent = 5.0f;
    // 头部缩进
    paragraphStyle.headIndent = 5.0f;
    // 尾部缩进
    paragraphStyle.tailIndent = -5.0f;
    
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    // 设置文本偏移量
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(baselineOffset) range:range];
    return attributedString;
}
    
//计算修改行距之后的富文本高度
- (CGFloat)heightForLableTextAndLineSapceWithFont:(UIFont *)font string:(NSString *)string maxWidth:(CGFloat)maxWidth lineSpace:(CGFloat)lineSpace
{
    
    if (string.length == 0)
    {
        return 0;
    }
    // 计算文本的高度
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //对齐方式
    paragraphStyle.alignment = NSTextAlignmentCenter;
    // 调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    // 首行缩进
    paragraphStyle.firstLineHeadIndent = 5.0f;
    // 头部缩进
    paragraphStyle.headIndent = 5.0f;
    // 尾部缩进
    paragraphStyle.tailIndent = -5.0f;
    
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    //    NSAttributedString *attributeString = [self setLableLineMarginWithLableFont:font andString:string margin:margin lineSpace:lineSpace];
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options context:nil];
    if ((rect.size.height - font.lineHeight) <= lineSpace)
    {
        if ([self containChinese:string])
        {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height- lineSpace);
        }
    }
    return rect.size.height;
}

// 判断是否包含中文
- (BOOL)containChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

@end
