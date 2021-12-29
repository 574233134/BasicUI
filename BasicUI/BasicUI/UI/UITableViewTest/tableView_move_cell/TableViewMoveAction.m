//
//  TableViewMoveAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/15.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TableViewMoveAction.h"

@interface TableViewMoveAction ()<UITableViewDelegate, UITableViewDataSource>

@property(strong,nonatomic)NSMutableArray *sectionZeroArray;

@property(strong,nonatomic)NSMutableArray *sectionOneArray;

@property(strong,nonatomic)UITableView *tableView;

@end

@implementation TableViewMoveAction

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"tableView移动操作";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataArray];
    [self creatTableView];
    [self creatNavigatioRightButton];
}

- (void)initDataArray
{
    self.sectionZeroArray = [NSMutableArray array];
    self.sectionOneArray = [NSMutableArray array];
    for (int i=0; i<15; i++)
    {
        [self.sectionZeroArray addObject:[NSString stringWithFormat:@"section0: %u",i+1]];
        [self.sectionOneArray addObject:[NSString stringWithFormat:@"section1: %u",i+1]];
    }
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
}

- (void)creatNavigatioRightButton
{
    UIBarButtonItem *moveItem = [[UIBarButtonItem alloc]initWithTitle:@"移动" style:UIBarButtonItemStylePlain target:self action:@selector(moveCell:)];
    self.navigationItem.rightBarButtonItem= moveItem;
}

-(void)moveCell:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:@"移动"])
    {
        item.title = @"完成";
        [self.tableView setEditing:YES animated:YES];
    }
    else
    {
        item.title = @"移动";
        [self.tableView setEditing:NO animated:YES];
    }
}

#pragma mark - tableview Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return self.sectionZeroArray.count;
    else if(section == 1)
        return self.sectionOneArray.count;
    else
        return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
            cell.textLabel.text = _sectionZeroArray[indexPath.row];
            break;
        case 1:
            cell.textLabel.text = _sectionOneArray[indexPath.row];
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

#pragma mark - tableview 移动相关代理

-(UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


/**
 * 只有在编辑状态下并且实现该方法，cell才可以移动（在该方法中交换数据）
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (sourceIndexPath.section == 0)
    {
        NSString *temp = _sectionZeroArray[sourceIndexPath.row];
        _sectionZeroArray[sourceIndexPath.row] = _sectionZeroArray[destinationIndexPath.row];
        _sectionZeroArray[destinationIndexPath.row] = temp;
        
    }
    else
    {
        NSString *temp = _sectionOneArray[sourceIndexPath.row];
        _sectionOneArray[sourceIndexPath.row] = _sectionOneArray[destinationIndexPath.row];
        _sectionOneArray[destinationIndexPath.row] = temp;
        
    }
}

/**
 * 该方法可给移动加限制（例如，只能在同一个section内才可以移动） proposedDestinationIndexPath为即将移动到的位置
 */
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if(sourceIndexPath.section == proposedDestinationIndexPath.section)
    {
        return proposedDestinationIndexPath;
    }
    else
    {
        return sourceIndexPath;
    }
}


@end
