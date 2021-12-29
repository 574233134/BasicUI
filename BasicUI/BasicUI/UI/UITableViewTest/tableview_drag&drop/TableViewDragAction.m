//
//  TableViewDragAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/8.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TableViewDragAction.h"
#import "PhotoImageCell.h"
@interface TableViewDragAction ()<UITableViewDelegate,UITableViewDataSource,UITableViewDragDelegate,UITableViewDropDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSIndexPath *dragIndexPath;

@end

@implementation TableViewDragAction

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"拖拽";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
    [self loadData];
    
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.dragDelegate = self;
        self.tableView.dropDelegate = self; // 11.0 之后
        self.tableView.dragInteractionEnabled = YES; // 11.0 之后
    } else {
        // Fallback on earlier versions
    } // 11.0 之后
    
    self.tableView.rowHeight = 240;
    [self.view addSubview:self.tableView];
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 1; i <= 6; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%u.jpg", i]];
        [self.dataArray addObject:image];
    }
}

#pragma mark - tableview datasource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    PhotoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[PhotoImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.targetImageView.image = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#ifdef __IPHONE_11_0
- (BOOL)tableView:(UITableView *)tableView shouldSpringLoadRowAtIndexPath:(NSIndexPath *)indexPath withContext:(id<UISpringLoadedInteractionContext>)context
API_AVAILABLE(ios(11.0)){
    return YES;
}

#pragma mark - UITableViewDragDelegate
/**
 * 开始拖拽 在该方法中获取可供拖拽的 item
 * 如果返回 nil，则不会发生任何拖拽事件
 */
- (nonnull NSArray<UIDragItem *> *)tableView:(nonnull UITableView *)tableView itemsForBeginningDragSession:(nonnull id<UIDragSession>)session atIndexPath:(nonnull NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:self.dataArray[indexPath.row]];
    UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    self.dragIndexPath = indexPath;
    return @[item];
}

/**
 * 该方法是上面方法多点触碰时对应的方法
 * 当接收到添加item响应时，会调用该方法向已经存在的drag会话中添加item
 * 如果需要，可以使用提供的点（在集合视图的坐标空间中）进行其他命中测试。
 * 如果该方法未实现，或返回空数组，则不会将任何 item 添加到拖动，手势也会正常的响应
 */
- (NSArray<UIDragItem *> *)tableView:(UITableView *)tableView itemsForAddingToDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point
API_AVAILABLE(ios(11.0)){
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:self.dataArray[indexPath.row]];
    UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    return @[item];
}

// 返回拖拽预览参数
- (nullable UIDragPreviewParameters *)tableView:(UITableView *)tableView dragPreviewParametersForRowAtIndexPath:(NSIndexPath *)indexPath
API_AVAILABLE(ios(11.0)){
    
    UIDragPreviewParameters *parameters = [[UIDragPreviewParameters alloc] init];
    CGRect rect = CGRectMake(0, 0, tableView.bounds.size.width, tableView.rowHeight);
    parameters.visiblePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:15];
    return parameters;
}

#pragma mark - UITableViewDropDelegate
// 当用户开始初始化 drop 手势的时候会调用该方法
- (void)tableView:(UITableView *)tableView performDropWithCoordinator:(id<UITableViewDropCoordinator>)coordinator  API_AVAILABLE(ios(11.0)){
    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath;
    
    // 如果开始拖拽的 indexPath 和 要释放的目标 indexPath 一致，就不做处理
    if (self.dragIndexPath.section == destinationIndexPath.section && self.dragIndexPath.row == destinationIndexPath.row) {
        return;
    }
    
    [tableView performBatchUpdates:^{
        // 目标 cell 换位置
        id obj = self.dataArray[self.dragIndexPath.row];
        [self.dataArray removeObjectAtIndex:self.dragIndexPath.row];
        [self.dataArray insertObject:obj atIndex:destinationIndexPath.row];
        [tableView deleteRowsAtIndexPaths:@[self.dragIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView insertRowsAtIndexPaths:@[destinationIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    } completion:^(BOOL finished) {
        
    }];
}
/**
 * 该方法是提供释放方案的方法，虽然是optional，但是最好实现。 使用时需要注意以下几点
 *
 * 当跟踪 drop 行为在 tableView 空间坐标区域内部时会频繁调用
 
 * 当drop手势在某个section末端的时候，传递的目标索引路径还不存在（此时 indexPath 等于 该 section 的行数），这时候会追加到该section 的末尾
 
 * 在某些情况下，目标索引路径可能为空（比如拖到一个没有cell的空白区域）
 
 * 注：在某些情况下，你的建议可能不被系统所允许，此时系统将执行不同的建议，可以通过 -[session locationInView:] 做你自己的命中测试
 
 */

 /**
 * 1. 枚举值 UITableViewDropIntent
 
 *  UITableViewDropIntentUnspecified, Table视图将接受drop，但是位置还不知道，稍后会确定。不会打开缺口。
 
 *  UITableViewDropIntentInsertAtDestinationIndexPath, drop将被放在插入目标索引路径的行中。在指定的位置打开一个缺口，模拟最终丢弃的布局。
 
 *  UITableViewDropIntentInsertIntoDestinationIndexPath,drop将被放置在目标索引路径的行中(例如，行是其他项的容器)。不会打开缺口。但是该条目标索引对应的cell会高亮显示。
 
 *  UITableViewDropIntentAutomatic, 表格视图将自动在.insertAtDestinationIndexPath和.insertatdestinationindexpath之间进行选择
        .insertintodestinationindexpath 取决于drop的位置  使用该项
        .insertIntoDestinationIndexPath 当要删除的项可以放在目标索引路径的行中，也可以插入到容器行索引路径的新行中使用该项
 */
- (UITableViewDropProposal *)tableView:(UITableView *)tableView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(nullable NSIndexPath *)destinationIndexPath
API_AVAILABLE(ios(11.0)){
    UITableViewDropProposal *dropProposal;
    
    // 如果是拖拽到另外一个app，localDragSession为nil，此时就要执行copy，通过这个属性判断是否是在当前app中释放，只有 iPad 才需要这个适配
    if (session.localDragSession)
    {
        dropProposal = [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationMove intent:UITableViewDropIntentInsertAtDestinationIndexPath];
    }
    else
    {
        dropProposal = [[UITableViewDropProposal alloc] initWithDropOperation:UIDropOperationCopy intent:UITableViewDropIntentInsertAtDestinationIndexPath];
    }
    
    return dropProposal;
}
#endif

@end
