//
//  CollectionViewDeleteAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/15.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CollectionViewDeleteAction.h"
#import "BasicUIDemo.h"
#import "DeleteCollectionViewCell.h"

static NSString *cellIdentify = @"cell";

@interface CollectionViewDeleteAction ()<DeleteCollectionViewCellDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (assign, nonatomic) BOOL isDeleteShake;

@end

@implementation CollectionViewDeleteAction

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"collectionView_delete";
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

- (void) creatCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing=10;
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [layout setScrollDirection: UICollectionViewScrollDirectionVertical];
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DeleteCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentify];
}

/** 长按collectionView 的手势回调 */
-(void)deleteAction:(UILongPressGestureRecognizer *)pressGuster
{
    if (pressGuster.state == UIGestureRecognizerStateEnded )
    {
        _isDeleteShake = !_isDeleteShake;
        [self.collectionView reloadData];
    }
    
}

# pragma mark - CustomCollectionViewCellDelegate
- (void)deleteCellAction:(CGPoint)point
{
    NSIndexPath *index = [self.collectionView indexPathForItemAtPoint:point];
    [self.dataArray removeObjectAtIndex:index.row];
    [self.collectionView deleteItemsAtIndexPaths:@[index]];
    [self.collectionView reloadData];
}

#pragma mark - collectionView dataSource

-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DeleteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    cell.deleteDelegate = self;
    cell.imageDisplay.image = self.dataArray[indexPath.row];
    cell.deleteButton.hidden = YES;
    
    UILongPressGestureRecognizer *pressAction = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteAction:)];
    pressAction.minimumPressDuration = 1;
    [cell.contentView addGestureRecognizer:pressAction];
    return cell;
}

#pragma mark - collectionView delegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    DeleteCollectionViewCell *customCell = (DeleteCollectionViewCell *)cell;
    if (_isDeleteShake)
    {
        customCell.deleteButton.hidden = NO;
        CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
        keyAnimaion.keyPath = @"transform.rotation";
        // value 提供动画函数值的一组对象
        keyAnimaion.values = @[@(-3 / 180.0 * M_PI),@(3 /180.0 * M_PI),@(-3/ 180.0 * M_PI)];//度数转弧度
        keyAnimaion.removedOnCompletion = NO;
        keyAnimaion.fillMode = kCAFillModeForwards;
        keyAnimaion.duration = 0.3;
        keyAnimaion.repeatCount = MAXFLOAT;
        [customCell.layer addAnimation:keyAnimaion forKey:@"cellShake"];
    }
    else if (!_isDeleteShake)
    {
        [customCell.layer removeAllAnimations];
        customCell.deleteButton.hidden = YES;
    }
}

@end
