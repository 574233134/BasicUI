//
//  CollectionViewMoveAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/16.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CollectionViewMoveAction.h"
#import "BasicUIDemo.h"
#import "ImageCollectionViewCell.h"
static NSString *cellIdentify = @"cell";
@interface CollectionViewMoveAction ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation CollectionViewMoveAction

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"collectionView_move";
    [self loadData];
    [self creatCollectionView];
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i <= 33; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"thumb%u", i]];
        [self.dataArray addObject:image];
    }
}

- (void)creatCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:cellIdentify];
    
    // CollectionView 添加长按手势
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longHandle:)];
    [self.collectionView addGestureRecognizer:longTap];
}

- (void)longHandle:(UILongPressGestureRecognizer *)gesture
{
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
            if (indexPath == nil)
            {
                break;
            }
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            
            [self.collectionView endInteractiveMovement];
            
            break;
        }
            
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

#pragma mark - collectionView Datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    cell.targetImageView.image = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - collectionView delegate
// 设置item可移动
-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 移动完成后的方法  －－ 交换数据
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.dataArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}


@end
