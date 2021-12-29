//
//  WaterFlowLayoutDisplay.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/16.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "WaterFlowLayoutDisplay.h"
#import "WaterFlowLayout.h"
static NSString *cellIdentify = @"cell";
@interface WaterFlowLayoutDisplay ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation WaterFlowLayoutDisplay

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"瀑布流布局";
    [self loadData];
    [self creatCollectionView];
}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    for (int i =0; i<100; i++)
    {
        NSNumber *randomNumber = @(arc4random()%50+80);
        [self.dataArray addObject:randomNumber];
    }
}

- (void)creatCollectionView
{
    WaterFlowLayout *waterLayout = [[WaterFlowLayout alloc]init];
    waterLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:waterLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentify];
}

#pragma mark - collectionView datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    cell.backgroundColor = [self randomColor];
    return cell;
}

#pragma mark - WaterFlow Deleagate
-(CGFloat)waterFallLayout:(WaterFlowLayout *)waterFlowLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width
{
    return [self.dataArray[index] floatValue];
}

#pragma mark - praviate
-   (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


@end
