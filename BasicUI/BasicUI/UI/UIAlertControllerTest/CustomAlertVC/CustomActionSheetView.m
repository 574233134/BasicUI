//
//  CustomActionSheetView.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/26.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomActionSheetView.h"
#import "CustomAlertAction.h"
#import "CustomAlertController.h"
#import "UIView+frame.h"
#import "CustomAlertCell.h"

#define ACTIONSHEET_ROWHEIGHT 57.0
#define LABEL_WIDTH  323
#define LABLE_Y 13.5  //titlelabel的y值
#define LABEL_MAGIRN 10.5 //messageLabel与titleLabel之间的上下间距

@interface CustomActionSheetView()<UITableViewDataSource, UITableViewDelegate>
    
//UI
//标题
@property (nonatomic, strong) UILabel *titleLabel;
//信息
@property (nonatomic, strong) UILabel *messageLabel;
//动作列表
@property (nonatomic, strong) UITableView *actionListView;
//标题，信息和动作列表之间的间隔线
@property (nonatomic, strong) UIView *line;

//data
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSMutableArray <CustomAlertAction *> *actionArray;
@property (nonatomic, strong, readwrite) NSArray <CustomAlertAction *> *actions;

/**
 过滤style == cancel ，剩下所有的按钮
 */
@property (nonatomic, strong) NSMutableArray <CustomAlertAction *> *okButtons;

/**
 style == cancel 的所有按钮 注：一般只会设置一个
 */
@property (nonatomic, strong) NSMutableArray <CustomAlertAction *> *cancelButtons;


@end

@implementation CustomActionSheetView

- (instancetype)init
{
    if (self = [super init])
    {
        [self configureProperties];
        [self createUI];
        [self addSubview:self.actionListView];
    }
    return self;
}
    
    
- (void)configureProperties
{
    
    //默认属性与系统一致
    self.layout = [[CustomAlertLayout alloc] initWithStyle:CustomAlertLayoutStyleActionSheet];
    //设置圆角
   // self.layer.cornerRadius = WIDTHSCALE(10);
    self.layer.masksToBounds = YES;
    
    self.actionArray = [NSMutableArray array];
    self.okButtons = [NSMutableArray array];
    self.cancelButtons = [NSMutableArray array];
}
    
+ (instancetype)actionSheetViewWith:(NSString *)title message:(NSString *)message
{
    CustomActionSheetView *actionSheetView = [[CustomActionSheetView alloc] init];
    if (message.length > 0 && title.length > 0)
    {
        actionSheetView.title = title;
        actionSheetView.message = message;
    }
    else if(message.length == 0 && title.length > 0)
    {
        actionSheetView.title = title;
    }
    else if(message.length > 0 && title.length == 0)
    {
        actionSheetView.title = message;
    }
    else
    {
        NSLog(@"没有标题和信息");
        return nil;
    }
    return actionSheetView;
}
    

// 添加动作
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
            NSLog(@"cancel button 只能有一个");
            return;
        }
    }
    [self.actionArray addObject:action];
    self.actions = [self.actionArray copy];
    if (self.actions.count > 1 && self.cancelButtons.count > 0)
    {
        [self.actionArray removeAllObjects];
        [self.actionArray addObjectsFromArray:self.okButtons];
        [self.actionArray addObjectsFromArray:self.cancelButtons];
        self.actions = [self.actionArray copy];
    }
    
    [self.actionListView reloadData];
}
    
#pragma mark - UITableViewDataSource&UITableViewDelegate
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.actionArray.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    CustomAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[CustomAlertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier cellType:YXTableViewCellStyleActionSheet];
    }
    CustomAlertAction *action = self.actionArray[indexPath.row];
    [cell loadDataWithAlertAction:action];
    cell.isHidenLine = indexPath.row == self.actionArray.count - 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustomAlertAction *action = self.actions[indexPath.row];
    action.handler ? action.handler(action) : nil;
    [self.clickActionSheetDelegate didClickActionSheet];

}
    
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    CGFloat titleHeight = [self heightForLableTextAndLineSapceWithFont:self.layout.titleFont string:self.title maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
    CGFloat messageHeight = [self heightForLableTextAndLineSapceWithFont:self.layout.messageFont string:self.message maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
    CGFloat titleY = HEIGHTSCALE(LABLE_Y);
    //文本高度
    CGFloat headerHeight = titleY + HEIGHTSCALE(19) + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0) + titleHeight + (self.message.length > 0 ? messageHeight : 0);
    return headerHeight;
}
    
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.labelView;
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
    self.line.backgroundColor = layout.lineColor;
    self.titleLabel.font = layout.titleFont;
    self.titleLabel.textColor = layout.titleColor;
    self.messageLabel.font = layout.messageFont;
    self.messageLabel.textColor = layout.messageColor;
}
    
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.attributedText = [self setLableLineMarginWithLableFont:self.layout.titleFont andString:title maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
}
    
- (void)setMessage:(NSString *)message
{
    _message = message;
    self.messageLabel.attributedText = [self setLableLineMarginWithLableFont:self.layout.messageFont andString:message maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
}
    
    
#pragma mark - createUI
    
- (void)createUI
{
    
    self.labelView = [[UIView alloc] initWithFrame:CGRectZero];
    self.labelView.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.labelView addSubview:self.titleLabel];
    
    self.messageLabel = [[UILabel alloc] init];
    [self.labelView addSubview:self.messageLabel];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = self.layout.lineColor;
    [self.labelView addSubview:self.line];
    
    [self setUIContent];
}

- (void)setUIContent
{
    self.titleLabel.font = self.layout.titleFont;
    self.titleLabel.textColor = self.layout.titleColor;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    
    self.messageLabel.font = self.layout.messageFont;
    self.messageLabel.textColor = self.layout.messageColor;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.numberOfLines = 0;
}
    
- (UITableView *)actionListView
{
    if (_actionListView == nil)
    {
        _actionListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _actionListView.dataSource = self;
        _actionListView.delegate = self;
        _actionListView.rowHeight = ACTIONSHEET_ROWHEIGHT;
        _actionListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _actionListView;
}
    
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat titleHeight = [self heightForLableTextAndLineSapceWithFont:self.layout.titleFont string:self.title maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
    CGFloat messageHeight = [self heightForLableTextAndLineSapceWithFont:self.layout.messageFont string:self.message maxWidth:WIDTHSCALE(LABEL_WIDTH) lineSpace:3];
    CGFloat titleY = HEIGHTSCALE(LABLE_Y);
    //文本高度
    CGFloat headerHeight = titleY + HEIGHTSCALE(19) + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0) + titleHeight + (self.message.length > 0 ? messageHeight : 0);
    
    //按钮高度
    CGFloat actionsHeight = self.actions.count * ACTIONSHEET_ROWHEIGHT;
    
    if ((headerHeight + actionsHeight) > SCREEN_HEIGHT - 40) {
        actionsHeight = SCREEN_HEIGHT - 40 - headerHeight;
        self.actionListView.scrollEnabled = YES;
        //当弹框实际高度大于最大高度时，并且有style == cancel的action，那么把tableView滚动到最底部，显示取消按钮
        if (self.cancelButtons.count > 0) {
            [self.actionListView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.okButtons.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
        //并调整titleLabel的y值
        titleY = HEIGHTSCALE(5);
        //更新文本高度
        headerHeight = titleY + HEIGHTSCALE(19) + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0) + titleHeight + (self.message.length > 0 ? messageHeight : 0);
        
    }
    else
    {
        self.actionListView.scrollEnabled = NO;
    }
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH , headerHeight + actionsHeight);
    
    self.actionListView.frame = self.bounds;
    
    self.labelView.frame = CGRectMake(0, 0, self.width, headerHeight);
    //title
    self.titleLabel.frame = CGRectMake(WIDTHSCALE(label_X), titleY, WIDTHSCALE(LABEL_WIDTH), titleHeight);
    //message
    self.messageLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom + (self.message.length > 0 ? HEIGHTSCALE(LABEL_MAGIRN) : 0), self.titleLabel.width, messageHeight);
    //分割线
    self.line.frame = CGRectMake(0, self.labelView.bottom - 0.5, self.labelView.width, 0.5);
}

    - (NSAttributedString *)setLableLineMarginWithLableFont:(UIFont *)font andString:(NSString *)string maxWidth:(CGFloat)maxWidth lineSpace:(CGFloat)lineSpace
    {
        if (!string.length) {
            return [[NSAttributedString alloc] initWithString:@""];
        }
        CGFloat offset = -(1.0/3 * lineSpace) - 1.0/3;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = lineSpace; // 调整行间距
        //    // 对齐方式
        paragraphStyle.alignment = NSTextAlignmentCenter;
        //    // 首行缩进
        //    paragraphStyle.firstLineHeadIndent = 10.0f;
        //    // 头部缩进
        //    paragraphStyle.headIndent = 10.0f;
        //    // 尾部缩进
        //    paragraphStyle.tailIndent = -10.0f;
        
        NSDictionary *attrs = @{
                                NSFontAttributeName : font,
                                NSParagraphStyleAttributeName : paragraphStyle,
                                };
        //计算一行文本的高度
        CGFloat oneHeight = [@"测试Test" boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
        CGFloat rowHeight = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
        //如果超出一行，则offset=0;
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
    
// 计算修改行距之后的富文本高度
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
    
    
    //判断如果包含中文
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
