//
//  WaterFlowLayout.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/16.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "WaterFlowLayout.h"

/** 默认参数 */
static const CGFloat columnCount = 4;
static const CGFloat defaultRowMargin = 10;
static const CGFloat defaultColumnMargin = 10;
static const UIEdgeInsets defaultEdgeInsets = {10, 10, 10, 10};

@interface WaterFlowLayout()
{
    /** 记录代理是否响应以下值 */
    struct
    {
        BOOL didRespondColumnCount : 1;
        BOOL didRespondColumnMargin : 1;
        BOOL didRespondRowMargin : 1;
        BOOL didRespondEdgeInsets : 1;
    } _delegateFlags;
    
}

/** cell的布局属性数组 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

/** 每列的高度数组 */
@property (nonatomic, strong) NSMutableArray *columnHeights;

/** 最大Y值 */
@property (nonatomic, assign) CGFloat maxY;

@end

@implementation WaterFlowLayout

/** 准备布局 */
- (void)prepareLayout
{
    [super prepareLayout];
    [self setupColumnHeightsArray];
    [self setupAttrsArray];
    [self setupDelegateFlags];
    self.maxY = [self maxYWithColumnHeightsArray:self.columnHeights];
    
}

/** 返回rect范围内的item的布局数组(这个方法会频繁调用)*/
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}


/** 返回indexPath位置的item布局属性 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    /** 先获取初始属性 */
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /** 开始计算item的x, y, width, height */
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    CGFloat width = (collectionViewWidth - [self edgeInsets].left - [self edgeInsets].right - ([self columnCount] - 1) * [self columnMargin]) / [self columnCount];
    
    /** 计算当前item应该摆放在第几列(计算哪一列高度最短) */
    __block NSUInteger minColumn = 0;
    __block CGFloat minHeight = MAXFLOAT;
    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber  *_Nonnull heightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        /** 遍历找出最小高度的列 */
        CGFloat height = [heightNumber doubleValue];
        
        if (minHeight > height) {
            minHeight = height;
            minColumn = idx;
        }
    }];
    
    /** x 值为左边缘距+最短列下标*（列间距+宽度） */
    CGFloat x = [self edgeInsets].left + minColumn * ([self columnMargin] + width);
    
    /** y 值为最短列的高度+行间距 */
    CGFloat y = minHeight + [self rowMargin];
    
    /** 由代理返回cell的高度 */
    CGFloat height = [self.delegate waterFallLayout:self heightForItemAtIndex:indexPath.item width:width];
    
    
    attrs.frame = CGRectMake(x, y, width, height);
    
    /** 更新数组中的最短列的高度 */
    self.columnHeights[minColumn] = @(y + height);
    
    return attrs;
}


/** 返回collectionView的contentSize */
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.maxY + [self edgeInsets].bottom);
}

#pragma mark - 数据相关
- (NSMutableArray *)columnHeights
{
    if (_columnHeights == nil)
    {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (_attrsArray == nil)
    {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

#pragma mark - 私有方法

/** 返回代理方法调用的频率非常频繁, 所以prepareLayout的时候设置一次标志, 调用代理方法的时候就直接判断即可, 可提升效率 */
- (void)setupDelegateFlags
{
    _delegateFlags.didRespondColumnCount = [self.delegate respondsToSelector:@selector(columnCountOfWaterFallLayout:)];
    
    _delegateFlags.didRespondColumnMargin = [self.delegate respondsToSelector:@selector(columnMarginOfWaterFallLayout:)];
    
    _delegateFlags.didRespondRowMargin = [self.delegate respondsToSelector:@selector(rowMarginOfWaterFallLayout:)];
    
    _delegateFlags.didRespondEdgeInsets = [self.delegate respondsToSelector:@selector(edgeInsetsOfWaterFallLayout:)];
}


/** 列高度数组中最大列的高度（返回contentsize时使用） */
- (CGFloat)maxYWithColumnHeightsArray:(NSArray *)array
{
    __block CGFloat maxY = 0;
    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber  *_Nonnull heightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([heightNumber doubleValue] > maxY) {
            maxY = [heightNumber doubleValue];
        }
    }];
    return maxY;
}

/** 初始化列高度数组 */
- (void)setupColumnHeightsArray
{
    [self.columnHeights removeAllObjects];
    
    /** 初始化列高度（为距离屏幕顶端的距离，为边缘距的top值加上header的高度，此处无header） */
    for (int i = 0; i < [self columnCount]; i++)
    {
        [self.columnHeights addObject:@([self edgeInsets].top)];
    }
    
    
}

/** 初始化属性数组 */
- (void)setupAttrsArray
{
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++)
    {
        @autoreleasepool
        {
            /** 如果item数目过大容易造成内存峰值提高 */
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            
            [self.attrsArray addObject:attrs];
        }
    }
}


#pragma mark -  根据情况返回参数  用户设置以下值则使用用户设置的  否则使用默认值

- (NSUInteger)columnCount
{
    return _delegateFlags.didRespondColumnCount ? [self.delegate columnCountOfWaterFallLayout:self] : columnCount;
}

- (CGFloat)columnMargin
{
    return _delegateFlags.didRespondColumnMargin ? [self.delegate columnMarginOfWaterFallLayout:self] : defaultColumnMargin;
}

- (CGFloat)rowMargin
{
    return _delegateFlags.didRespondRowMargin ? [self.delegate rowMarginOfWaterFallLayout:self] : defaultRowMargin;
}

- (UIEdgeInsets)edgeInsets
{
    return _delegateFlags.didRespondEdgeInsets ? [self.delegate edgeInsetsOfWaterFallLayout:self] : defaultEdgeInsets;
}

@end
