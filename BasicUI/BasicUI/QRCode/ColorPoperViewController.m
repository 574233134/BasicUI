//
//  ColorPoperViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/20.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "ColorPoperViewController.h"
#define clumCount 4
#define SECTION_INSET UIEdgeInsetsMake(10, 10, 10, 10)
static NSString *indentify = @"cell";
@interface ColorPoperViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) NSIndexPath *firstIndexPath;

@end

@implementation ColorPoperViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataList = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
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
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.flowLayout.sectionInset = SECTION_INSET;
    CGSize collectionViewSize = self.preferredContentSize;
    self.flowLayout.minimumLineSpacing = 5;
    self.flowLayout.itemSize = CGSizeMake(30, 30);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, collectionViewSize.width, collectionViewSize.height) collectionViewLayout:self.flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor darkGrayColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:indentify];
}

#pragma collectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    UIColor *color = self.dataList[indexPath.item];
    cell.contentView.backgroundColor = color;
    cell.contentView.clipsToBounds = YES;
    cell.contentView.layer.cornerRadius = 15;
    return cell;
}

#pragma collectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *color = self.dataList[indexPath.item];
    [self.delegate selectAtIndex:indexPath data:color fromTag:self.fromTag];
}

@end
