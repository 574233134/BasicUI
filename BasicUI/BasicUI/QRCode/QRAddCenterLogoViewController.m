//
//  QRAddCenterLogoViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/19.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "QRAddCenterLogoViewController.h"
#import "UIImage+SGExtend.h"
#import "BasicUIDemo.h"
#import "ImageCollectionViewCell.h"
#import "QRcodeManger.h"
#define SECTION_INSET UIEdgeInsetsMake(10, 10, 10, 10)
static NSString *indentify = @"cell";

@interface QRAddCenterLogoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UIImageView *codeImageView;
@property (nonatomic, strong)UIView *footerView;
@property (nonatomic, strong)NSArray *iconList;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic)UIImage *centerIcon;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@end

@implementation QRAddCenterLogoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.codeImageView];
    self.codeImageView.image = self.resultImage;
    self.footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-TARBARHEIGHT, SCREEN_WIDTH, TARBARHEIGHT)];
    self.footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.footerView];
    [self initBtnConfig];
    [self creatUI];
}

- (NSArray *)iconList
{
    if (!_iconList) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:21];
        for (int i=0; i<21; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"qrIcon%d",i]];
            [arr addObject:image];
        }
        _iconList = [arr mutableCopy];
    }
    return _iconList;
}

- (void)cancleChangeColor
{
    self.completeBlock(NO, nil,nil);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commitChangeColor
{
    UIImage *result = self.codeImageView.image;
    self.completeBlock(YES, result,self.centerIcon);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)creatUI
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.flowLayout.sectionInset = SECTION_INSET;
    CGSize collectionViewSize = CGSizeMake(SCREEN_WIDTH, 60);
    self.flowLayout.minimumLineSpacing = 5;
    self.flowLayout.itemSize = CGSizeMake(40, 40);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.footerView.frame.origin.y-60, collectionViewSize.width, collectionViewSize.height) collectionViewLayout:self.flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:indentify];
}

#pragma collectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.iconList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    UIImage *image = self.iconList[indexPath.item];
    cell.targetImageView.image = image;
    return cell;
}

#pragma collectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.item==0) {
        self.centerIcon = nil;
        if (self.frontColor || self.backgroundColor) {
            self.qrImage = [QRcodeManger changeQRColor:self.qrImage qrcolor:self.frontColor bgColor:self.backgroundColor];
        }
        self.codeImageView.image = self.qrImage;
    }
    
    if (indexPath.item>1) {
        self.centerIcon = self.iconList[indexPath.item];
        if (self.frontColor || self.backgroundColor) {
            self.qrImage = [QRcodeManger changeQRColor:self.qrImage qrcolor:self.frontColor bgColor:self.backgroundColor];
        }
        
        UIImage *image = [QRcodeManger addCenterIcon:self.qrImage icon:self.centerIcon size:40];
        self.codeImageView.image = image;
    }
    
}
#pragma mark - UI设置
- (void)initBtnConfig
{
    
    UIButton *cancleItem =[UIButton buttonWithType:UIButtonTypeSystem];
     [cancleItem setImage:[[UIImage imageNamed:@"cancle"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    cancleItem.frame = CGRectMake(30, 5, 40, 40);
    [cancleItem addTarget:self action:@selector(cancleChangeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:cancleItem];
    
    UIButton *commitItem =[UIButton buttonWithType:UIButtonTypeSystem];
    [commitItem setImage:[[UIImage imageNamed:@"commit"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    commitItem.frame = CGRectMake(SCREEN_WIDTH-70, 5, 40, 40);
    [commitItem addTarget:self action:@selector(commitChangeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:commitItem];

    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 5, 100, 40)];
    label.text = @"logo";
    label.textAlignment = NSTextAlignmentCenter;
    [self.footerView addSubview:label];
}

- (UIImageView *)codeImageView
{
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc]init];
        _codeImageView.frame = CGRectMake(80, 80, SCREEN_WIDTH-160, SCREEN_WIDTH-160);
    }
    return _codeImageView;
}


@end
