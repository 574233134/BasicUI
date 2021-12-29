//
//  CollectionViewDragAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/13.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CollectionViewDragAction.h"
#import "ImageCollectionViewCell.h"

static NSString *cellIdentify = @"ImageCellIdentifier";
static NSString *TypeIdentifier = @"TypeIdentifier";

@interface CollectionViewDragAction ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDragDelegate,UICollectionViewDropDelegate>

@property (strong,nonatomic) UICollectionView *collectionView;

@property (strong,nonatomic) NSMutableArray *dataArray;

@property (strong,nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) NSIndexPath *dragIndexPath;

@end

@implementation CollectionViewDragAction

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"collectionView drag&drop";
    [self creatLayout];
    [self loadData];
    [self creatCollectionView];
}

- (void)creatLayout
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemLength = [UIScreen mainScreen].bounds.size.width / 5;
    self.flowLayout.itemSize = CGSizeMake(itemLength, itemLength);
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 10;
    [self.flowLayout setSectionInset:UIEdgeInsetsMake(15, 12, 15, 12)];
}

- (void)creatCollectionView
{
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    if (@available(iOS 11.0, *)) {
        self.collectionView.dragDelegate = self;
        self.collectionView.dropDelegate = self;
        self.collectionView.dragInteractionEnabled = YES;
    } else {
        // Fallback on earlier versions
    }
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:cellIdentify];
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i <= 33; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"thumb%d", i]];
        [self.dataArray addObject:image];
    }
}

#pragma mark - collectionView datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    cell.targetImageView.image = self.dataArray[indexPath.item];
    return cell;
}

#pragma mark - collectionView dragDelegate API_AVAILABLE(ios(11.0))

- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath
API_AVAILABLE(ios(11.0)){
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:self.dataArray[indexPath.item]];
    [itemProvider registerItemForTypeIdentifier:TypeIdentifier loadHandler:^(NSItemProviderCompletionHandler  _Null_unspecified completionHandler, Class  _Null_unspecified __unsafe_unretained expectedValueClass, NSDictionary * _Null_unspecified options) {
        
    }];
    
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
- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForAddingToDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point
API_AVAILABLE(ios(11.0)){
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:self.dataArray[indexPath.item]];
    UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    return @[item];
}

/**
 * 允许对从取消或返回到 CollectionView 的 item 使用自定义预览
 * UIDragPreviewParameters 有两个属性：visiblePath 和 backgroundColor
 * 如果该方法没有实现或者返回nil，那么整个 cell 将用于预览
 * 可以在该方法内对单元格的一个具体区域进行裁剪
 */
- (nullable UIDragPreviewParameters *)collectionView:(UICollectionView *)collectionView dragPreviewParametersForItemAtIndexPath:(NSIndexPath *)indexPath
API_AVAILABLE(ios(11.0)){
    UIDragPreviewParameters *parameters = [[UIDragPreviewParameters alloc] init];
    CGFloat previewLength = self.flowLayout.itemSize.width;
    CGRect rect = CGRectMake(0, 0, previewLength, previewLength);
    parameters.visiblePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5];
    parameters.backgroundColor = [UIColor clearColor];
    return parameters;
}

/**
 * 当 lift animation 完成之后开始拖拽之前会调用该方法 可以在这些方法里面设置自定义的dragPreview
 * 该方法肯定会对应着 -collectionView:dragSessionDidEnd: 的调用
 */
- (void)collectionView:(UICollectionView *)collectionView dragSessionWillBegin:(id<UIDragSession>)session
API_AVAILABLE(ios(11.0)){
    NSLog(@"dragSessionWillBegin --> drag 会话将要开始");
}

/** 拖拽结束的时候会调用该方法 */
- (void)collectionView:(UICollectionView *)collectionView dragSessionDidEnd:(id<UIDragSession>)session
API_AVAILABLE(ios(11.0)){
    NSLog(@"dragSessionDidEnd --> drag 会话已经结束");
}


#pragma mark - collectionView dropDelegate API_AVAILABLE(ios(11.0))
/* 当用户开始进行 drop 操作的时候会调用这个方法
 * 使用 dropCoordinator 去置顶如果处理当前 drop 会话的item 到指定的最终位置，同时也会根据drop item返回的数据更新数据源
 * 如果该方法不做任何事，将会执行默认的动画
 * 注意：只有在这个方法中才可以请求到数据
 */
- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator
API_AVAILABLE(ios(11.0)){
    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath;
    UIDragItem *dragItem = coordinator.items.firstObject.dragItem;
    UIImage *image = self.dataArray[self.dragIndexPath.item];
    
    // 如果开始拖拽的 indexPath 和 要释放的目标 indexPath 一致，就不做处理
    if (self.dragIndexPath.section == destinationIndexPath.section && self.dragIndexPath.row == destinationIndexPath.row)
    {
        return;
    }
    
    // 更新 CollectionView
    [collectionView performBatchUpdates:^{
        // 目标 cell 换位置
        [self.dataArray removeObjectAtIndex:self.dragIndexPath.item];
        [self.dataArray insertObject:image atIndex:destinationIndexPath.item];
        
        [collectionView moveItemAtIndexPath:self.dragIndexPath toIndexPath:destinationIndexPath];
    } completion:^(BOOL finished) {
        
    }];
    
    [coordinator dropItem:dragItem toItemAtIndexPath:destinationIndexPath];

}


/* 该方法是提供释放方案的方法，虽然是optional，但是最好实现
 * 当 跟踪 drop 行为在 tableView 空间坐标区域内部时会频繁调用
 * 当drop手势在某个section末端的时候，传递的目标索引路径还不存在（此时 indexPath 等于 该 section 的行数），这时候会追加到该section 的末尾
 * 在某些情况下，目标索引路径可能为空（比如拖到一个没有cell的空白区域）
 * 请注意，在某些情况下，你的建议可能不被系统所允许，此时系统将执行不同的建议
 * 你可以通过 -[session locationInView:] 做你自己的命中测试
 */
- (UICollectionViewDropProposal *)collectionView:(UICollectionView *)collectionView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(nullable NSIndexPath *)destinationIndexPath  API_AVAILABLE(ios(11.0)){
    
    UICollectionViewDropProposal *dropProposal;
    // 如果是另外一个app，localDragSession为nil，此时就要执行copy，通过这个属性判断是否是在当前app中释放，当然只有 iPad 才需要这个适配
    if (session.localDragSession)
    {
        dropProposal = [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationCopy intent:UICollectionViewDropIntentInsertAtDestinationIndexPath];
    }
    else
    {
        dropProposal = [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationCopy intent:UICollectionViewDropIntentInsertAtDestinationIndexPath];
    }
    
    return dropProposal;
}

/* 通过该方法判断对应的item 能否被 执行drop会话
 * 如果返回 NO，将不会调用接下来的代理方法
 * 如果没有实现该方法，那么默认返回 YES
 */
- (BOOL)collectionView:(UICollectionView *)collectionView canHandleDropSession:(id<UIDropSession>)session
API_AVAILABLE(ios(11.0)){
    // 假设在该 drop 只能在当前本 app中可执行，在别的 app 中不可以
    if (session.localDragSession == nil)
    {
        return NO;
    }
    return YES;
}

/* 当drop会话进入到 collectionView 的坐标区域内就会调用，
 * 早于- [collectionView dragSessionWillBegin] 调用
 */
- (void)collectionView:(UICollectionView *)collectionView dropSessionDidEnter:(id<UIDropSession>)session
API_AVAILABLE(ios(11.0)){
    NSLog(@"dropSessionDidEnter --> dropSession进入目标区域");
}

/* 当 dropSession 不在collectionView 目标区域的时候会被调用
 */
- (void)collectionView:(UICollectionView *)collectionView dropSessionDidExit:(id<UIDropSession>)session
API_AVAILABLE(ios(11.0)){
    NSLog(@"dropSessionDidExit --> dropSession 离开目标区域");
}

/* 当dropSession 完成时会被调用，不管结果如何
 * 适合在这个方法里做一些清理的操作
 */
- (void)collectionView:(UICollectionView *)collectionView dropSessionDidEnd:(id<UIDropSession>)session
API_AVAILABLE(ios(11.0)){
    NSLog(@"dropSessionDidEnd --> dropSession 已完成");
}

/* 当 item 执行drop 操作的时候，可以自定义预览图
 * 如果没有实现该方法或者返回nil，整个cell将会被用于预览图
 * 该方法会经由  -[UICollectionViewDropCoordinator dropItem:toItemAtIndexPath:] 调用
 * 如果要去自定义占位drop，可以查看 UICollectionViewDropPlaceholder.previewParametersProvider
 */
- (nullable UIDragPreviewParameters *)collectionView:(UICollectionView *)collectionView dropPreviewParametersForItemAtIndexPath:(NSIndexPath *)indexPath
API_AVAILABLE(ios(11.0)){
    return nil;
}

@end
