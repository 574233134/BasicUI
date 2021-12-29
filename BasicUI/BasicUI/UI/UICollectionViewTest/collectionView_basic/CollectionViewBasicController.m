//
//  CollectionViewBasicController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/12.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CollectionViewBasicController.h"
#import "CustomCollectionViewBasicCell.h"

static NSString * indentify = @"cell";
static NSString *header = @"header";
static NSString *footer = @"footer";

@interface CollectionViewBasicController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong,nonatomic)UICollectionView *collectionView;

@property(strong,nonatomic)NSMutableArray *dataArray;

@property(strong,nonatomic) UICollectionViewFlowLayout *flowLayout;

/** xib controls */
@property (strong, nonatomic) IBOutlet UISwitch *allowPaged;

@property (strong, nonatomic) IBOutlet UISwitch *allowSelect;

@property (strong, nonatomic) IBOutlet UITextField *widthTextfield;

@property (strong, nonatomic) IBOutlet UITextField *heightTextField;

@property (strong, nonatomic) IBOutlet UITextField *VSpacing;

@property (strong, nonatomic) IBOutlet UITextField *HSpacing;

@property (strong, nonatomic) IBOutlet UITextField *edgLeft;

@property (strong, nonatomic) IBOutlet UITextField *edgRight;

@property (strong, nonatomic) IBOutlet UITextField *edgTop;

@property (strong, nonatomic) IBOutlet UITextField *edgBottom;

@property (strong, nonatomic) IBOutlet UISegmentedControl *layoutDirection;

@end

@implementation CollectionViewBasicController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"collectionView基础";
    [self creatFlowLayout];
    [self creatCollectionView];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
        _dataArray = [NSMutableArray array];
        for (int i=0; i<20; i++)
        {
            [_dataArray addObject:[NSString stringWithFormat:@"数据%d",i]];
        }
    }
    return _dataArray;
}

- (void)creatFlowLayout
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    /** 设置item尺寸*/
    self.flowLayout.itemSize = CGSizeMake(100, 100);
    
    /** 垂直间距 */
    self.flowLayout.minimumLineSpacing = 20;
    
    /** 水平间距 */
    self.flowLayout.minimumInteritemSpacing = 10;
    
    /** 设置滚动方向 */
    [self.flowLayout setScrollDirection: UICollectionViewScrollDirectionVertical];
    
    /** 设置header大小 */
    self.flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 35);
    
    /** 设置footer大小 */
    self.flowLayout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 10);
    
    /** 设置header悬浮(NS_AVAILABLE_IOS(9_0)) */
    self.flowLayout.sectionHeadersPinToVisibleBounds = YES;
    
    /** 设置footer悬浮(NS_AVAILABLE_IOS(9_0)) */
    self.flowLayout.sectionFootersPinToVisibleBounds = YES;
}

- (void)creatCollectionView
{
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/2-64) collectionViewLayout:_flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled =YES;
    
    /** 设置背景颜色（默认是黑色）*/
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    /** 设置collectionview 允许多选 */
    self.collectionView.allowsMultipleSelection = YES;
    
    /** 注册cell，header，footer */
    [self.collectionView registerClass:[CustomCollectionViewBasicCell class] forCellWithReuseIdentifier:indentify];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer];
}
#pragma mark - collectionView dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewBasicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    
    if (indexPath.row%2==0)
        cell.backgroundColor = [UIColor redColor];
    else
        cell.backgroundColor = [UIColor cyanColor];
    cell.textLabel.text = self.dataArray[indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
     UICollectionReusableView *reusableView = nil;
    //组的头部
    if (kind == UICollectionElementKindSectionHeader)
    {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor purpleColor];
    }
    
    //组的尾部
    if (kind == UICollectionElementKindSectionFooter)
    {
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor yellowColor];
    }
    return reusableView;
}

#pragma mark - colletionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.row%2==0)
        cell.backgroundColor = [UIColor redColor];
    else
        cell.backgroundColor = [UIColor cyanColor];
}

#pragma mark - xib action
- (IBAction)setItemSize:(UIButton *)sender
{
    self.flowLayout.itemSize = CGSizeMake([_widthTextfield.text floatValue], [_heightTextField.text floatValue]);
    
}

- (IBAction)setSpacing:(UIButton *)sender
{
    self.flowLayout.minimumLineSpacing = [_VSpacing.text floatValue];
    self.flowLayout.minimumInteritemSpacing = [_HSpacing.text floatValue];
    
}

- (IBAction)setPageEnable:(UISwitch *)sender
{
    self.collectionView.pagingEnabled = sender.on;
    
}

- (IBAction)allowSelect:(UISwitch *)sender
{
    self.collectionView.allowsSelection = sender.on;
    self.collectionView.allowsMultipleSelection = sender.on;
    
}

- (IBAction)setEdgSpacing:(UIButton *)sender
{
    CGFloat top = [_edgTop.text floatValue];
    CGFloat left = [_edgLeft.text floatValue];
    CGFloat right = [_edgRight.text floatValue];
    CGFloat bottom = [_edgBottom.text floatValue];
    self.flowLayout.sectionInset = UIEdgeInsetsMake(top, left, bottom, right);
    
}

- (IBAction)setScrollerDirection:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            break;
        case 1:
            self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            break;
        default:
            break;
    }
}

@end
