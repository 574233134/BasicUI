//
//  PoperViewControllerTwo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/25.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "PoperViewControllerTwo.h"
#import "PoperCollectionViewCell.h"

#define clumCount 4
#define SECTION_INSET UIEdgeInsetsMake(0, 10, 0, 10)

static NSString *indentify = @"cell";

@interface PoperViewControllerTwo ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) NSIndexPath *firstIndexPath;

@end

@implementation PoperViewControllerTwo

+ (instancetype)sharedInstance
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static PoperViewControllerTwo *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
        // 弹出视图大小
        _instance.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, 120);
        // 弹出视图风格
        _instance.modalPresentationStyle = UIModalPresentationPopover;
        // 气泡视图箭头所指方向
        _instance.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        
    });
    return _instance;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.collectionView scrollToItemAtIndexPath:self.firstIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)loadView
{
    [super loadView];
    self.dataList = [NSMutableArray array];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
}

- (void)reloadData
{
    [self.collectionView reloadData];
}

- (void)setDataArray:(NSArray *)dataArray
{
    [self.dataList removeAllObjects];
    self.dataList = [NSMutableArray arrayWithArray:dataArray];
    [self.collectionView reloadData];
}

- (void)creatUI
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.flowLayout.sectionInset = SECTION_INSET;
    CGSize collectionViewSize = self.preferredContentSize;
    CGFloat width = collectionViewSize.width - self.flowLayout.sectionInset.left - self.flowLayout.sectionInset.right;
    CGFloat hight = collectionViewSize.height - self.flowLayout.sectionInset.top - self.flowLayout.sectionInset.bottom;
    self.flowLayout.minimumLineSpacing = 20;
    self.flowLayout.itemSize = CGSizeMake((width - (clumCount - 1) * self.flowLayout.minimumLineSpacing) / clumCount, hight);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, collectionViewSize.width, collectionViewSize.height) collectionViewLayout:self.flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PoperCollectionViewCell class] forCellWithReuseIdentifier:indentify];
}

#pragma collectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataList.count % clumCount == 0) {
        return clumCount;
    } else {
        if (section == self.dataList.count / clumCount) {
            return self.dataList.count % clumCount;
        } else {
            return clumCount;
        }
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PoperCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    cell.textLabel.text = @"";
    if (indexPath.section == 0 && indexPath.row == 0) {
        self.firstIndexPath = indexPath;
    }
    if (indexPath.section * clumCount + indexPath.row < self.dataList.count)
    {
        NSString *data = [self.dataList objectAtIndex:indexPath.section * clumCount + indexPath.row];
        cell.textLabel.text = data;
    }
    return cell;
}

#pragma collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.dataList.count % clumCount == 0) {
        return self.dataList.count / clumCount;
    } else {
        return self.dataList.count / clumCount + 1;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *data = self.dataList[indexPath.section * clumCount + indexPath.row];
    [self performSelector:@selector(takeToFirst) withObject:nil afterDelay:0.8];
    [self.delegate selectAtIndex:indexPath data:data];
}

- (void)takeToFirst
{
    [self.collectionView reloadData];
}

@end
