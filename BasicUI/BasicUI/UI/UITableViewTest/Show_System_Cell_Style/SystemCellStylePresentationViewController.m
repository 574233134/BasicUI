//
//  SystemCellStylePresentationViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/9.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "SystemCellStylePresentationViewController.h"

@interface SystemCellStylePresentationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIImage *pothoImage;

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation SystemCellStylePresentationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title  =@"系统cell样式展示";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPhotoImage];
    [self initDataArray];
    [self creatTableView];
    
}

- (void)initPhotoImage
{
    self.pothoImage = [UIImage imageNamed:@"photo"];
}

- (void)initDataArray
{
    self.dataArray = [[NSArray alloc]initWithObjects:@"default样式",@"subTitle样式",@"value1样式",@"value2样式" ,nil];
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        switch (indexPath.row)
        {
            case 0:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                break;
            case 1:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
                break;
            case 2:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
                break;
            case 3:
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identify];
                break;
            default:
                break;
        }
    }
    cell.imageView.image = self.pothoImage;
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.detailTextLabel.text = @"副标题";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
