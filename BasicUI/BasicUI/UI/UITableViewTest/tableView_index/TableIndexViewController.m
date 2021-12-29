//
//  TableIndexViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/26.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TableIndexViewController.h"

#define sectionCount 3

@interface TableIndexViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *tableView;

@property(strong,nonatomic)NSArray *sectionZeroDataArray;

@property(strong,nonatomic)NSArray *sectionOneDataArray;

@property(strong,nonatomic)NSArray *sectionTwoDataArray;

// xib
@property (strong, nonatomic) IBOutlet UILabel *displaySelectIndex;

@property (strong, nonatomic) IBOutlet UISwitch *isRowIndentation;

@property (strong, nonatomic) IBOutlet UISwitch *isBackgroundIndention;


@end

@implementation TableIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

-(NSArray *)sectionZeroDataArray
{
    if (_sectionZeroDataArray == nil)
    {
        _sectionZeroDataArray = @[@"section 0 : 第一行",@"section 0 : 第二行",@"section 0 : 第三行",@"section 0 : 第四行",@"section 0 : 第五行"];
    }
    return _sectionZeroDataArray;
}

-(NSArray *)sectionOneDataArray
{
    if (_sectionOneDataArray == nil)
    {
        _sectionOneDataArray = @[@"section 1 : 第一行",@"section 1 : 第二行",@"section 1 : 第三行",@"section 1 : 第四行",@"section 1 : 第五行"];
    }
    return _sectionOneDataArray;
}

-(NSArray *)sectionTwoDataArray
{
    if (_sectionTwoDataArray == nil)
    {
        _sectionTwoDataArray = @[@"section 2 : 第一行",@"section 2 : 第二行",@"section 2 : 第三行",@"section 2 : 第四行",@"section 2 : 第五行"];
    }
    return _sectionTwoDataArray;
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionCount;
}

#pragma mark - tableview dataSource

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return self.sectionZeroDataArray.count;
            break;
        case 1:
            return self.sectionOneDataArray.count;
            break;
        case 2:
            return self.sectionTwoDataArray.count;
            break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    switch (indexPath.section)
    {
        case 0:
            cell.textLabel.text =  _sectionZeroDataArray[indexPath.row];
            break;
        case 1:
            cell.textLabel.text =  _sectionOneDataArray[indexPath.row];
            break;
        case 2:
            cell.textLabel.text =  _sectionTwoDataArray[indexPath.row];
            break;
        default:
            break;
    }
    cell.contentView.backgroundColor = [UIColor orangeColor];
    cell.backgroundColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableview 索引设置

/**
 * 设置右侧的索引  可以快速定位到某个section
 */
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *array =[[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D", nil];
    return array;
}

/**
 * 点击右侧索引时调用该方法
 */
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    _displaySelectIndex.text = title;
    return index;
}

#pragma mark - 设置sectionTitle

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [NSString stringWithFormat:@"section:%lu",section+1];
    return title;
}

#pragma mark - tableview缩进

/**
 * 设置让UITableView行缩进
 */
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isRowIndentation.on)
    {
        NSInteger row = [indexPath row];
        return row;
    }
    else
        return 0;
    
}
/**
 * cell的contentView背景是否缩进,如果没有实现，默认值是YES(此方法仅适用于分组样式表视图) 并且当tableview进入编辑模式且编辑样式为none时才能看到contentview缩进和不缩进的区别
 */
- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _isBackgroundIndention.on;
}

/**
 * 编辑样式
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

#pragma mark - xib action

- (IBAction)setEdit:(UISwitch *)sender
{
    [self.tableView setEditing:sender.on animated:YES];
}

- (IBAction)indentationAllow:(UISwitch *)sender
{
    [self.tableView reloadData];
}

- (IBAction)backgroundIndentationAllow:(UISwitch *)sender
{
    [self.tableView reloadData];
}

@end
