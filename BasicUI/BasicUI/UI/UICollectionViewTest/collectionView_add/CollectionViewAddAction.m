//
//  CollectionViewAddAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/16.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CollectionViewAddAction.h"
#import "ImageCollectionViewCell.h"
#import "BasicUIDemo.h"

static NSString *cellIdentify = @"cell";

@interface CollectionViewAddAction ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;


@end

@implementation CollectionViewAddAction

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"collectionView_add";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self creatCollectionView];
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i <= 33; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"thumb%ld", i]];
        [self.dataArray addObject:image];
    }
}

- (void)creatCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize = CGSizeMake(100, 100);
    self.flowLayout.minimumLineSpacing = 20;
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height) collectionViewLayout:self.flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:cellIdentify];
    
    /** 添加点击手势用来添加新的Item */
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipHandle:)];
    [self.collectionView addGestureRecognizer:oneTap];
}

/** 点击手势回调方法 */
-(void)tipHandle:(UITapGestureRecognizer *)sender
{
    CGPoint location = [sender locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    CGFloat itemSpace = _flowLayout.minimumInteritemSpacing;
    if (!indexPath)
    {
        indexPath = [self getIndexPathWithPoint:location];
        CGRect destinationFrame = [self.collectionView cellForItemAtIndexPath:indexPath].frame;
        if (indexPath.row == self.dataArray.count)
        {
            CGRect lastItemFrame = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataArray.count-1 inSection:0]].frame;
            
            
            destinationFrame = CGRectMake(lastItemFrame.origin.x+self.flowLayout.itemSize.width +  itemSpace, lastItemFrame.origin.y, self.flowLayout.itemSize.width, self.flowLayout.itemSize.height);
            if (destinationFrame.origin.x > SCREEN_WIDTH)
            {
                destinationFrame.origin.x = self.flowLayout.sectionInset.left;
                destinationFrame.origin.y += self.flowLayout.minimumLineSpacing + self.flowLayout.itemSize.height;
            }
        }
        
        UIImageView *showImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, self.collectionView.contentOffset.y+self.collectionView.bounds.size.height/2 - 100, 200, 200)];
        [showImage setImage:[UIImage imageNamed:@"newItem"]];
        showImage.layer.cornerRadius = 5.0f;
        showImage.layer.masksToBounds = YES;
        [self.collectionView addSubview:showImage];
        __weak typeof(self) weekself = self;
        [UIView animateWithDuration:1 animations:^{
            [showImage setFrame:destinationFrame];
        }completion:^(BOOL finished) {
            [showImage removeFromSuperview];
            //插入操作
            [weekself.dataArray insertObject:[UIImage imageNamed:[NSString stringWithFormat:@"newItem"]] atIndex:indexPath.row];
            [self.collectionView performBatchUpdates:^{
                [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
            } completion:nil];
            
        }];
    }
}

/** 获取按压点该插入的位置 */
- (NSIndexPath *)getIndexPathWithPoint:(CGPoint)point
{
    // 点击Item下方空隙
    if(![self.collectionView indexPathForItemAtPoint:CGPointMake(point.x+self.flowLayout.itemSize.width, point.y)] && [self.collectionView indexPathForItemAtPoint:CGPointMake(point.x, point.y+self.flowLayout.itemSize.height)])
    {
        return [self.collectionView indexPathForItemAtPoint:CGPointMake(point.x, point.y+self.flowLayout.itemSize.height)];
    }
    
    // 点击Item右侧空隙
    else if (![self.collectionView indexPathForItemAtPoint:CGPointMake(point.x, point.y+self.flowLayout.itemSize.height)] && [self.collectionView indexPathForItemAtPoint:CGPointMake(point.x+self.flowLayout.itemSize.width, point.y)])
    {
        return [self.collectionView indexPathForItemAtPoint:CGPointMake(point.x+self.flowLayout.itemSize.width, point.y)];
    }
    
    // 插入到最后一个item之后
    else
    {
        return [NSIndexPath indexPathForItem:self.dataArray.count inSection:self.collectionView.numberOfSections - 1];
    }
    return nil;
}

#pragma mark - collectionView datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    cell.targetImageView.image = self.dataArray[indexPath.item];
    return cell;
}

@end
