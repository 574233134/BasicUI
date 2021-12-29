//
//  TableViewDeleteAction.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/10/15.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "TableViewDeleteAction.h"

@interface TableViewDeleteAction ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation TableViewDeleteAction

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"tableView删除操作";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataArray];
    [self creatTableView];
    [self creatNavigatioRightButton];
}

- (void)initDataArray
{
    self.dataArray = [NSMutableArray array];
    for(int i=0; i<10; i++)
    {
        NSString *dataStr = [NSString stringWithFormat:@"初始数据: %d",i];
        [self.dataArray addObject:dataStr];
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
    UIBarButtonItem *deleteOneItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteOne:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:deleteOneItem, nil];
}

-(void)deleteOne:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:@"删除"])
    {
        item.title = @"完成";
        [self.tableView setEditing:YES animated:YES];
    }
    else
    {
        item.title = @"删除";
        [self.tableView setEditing:NO animated:YES];
    }
}

#pragma mark - tableview Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableview 删除

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deleteCellAtIndexPath:indexPath];
}

-(void)deleteCellAtIndexPath:(NSIndexPath *)indexPath
{

    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [NSString stringWithFormat:@"系统删除"];
    }
    else
    {
        return [NSString stringWithFormat:@""];
    }
}


/**
 * 8.0之后侧滑菜单的新接口，支持多个侧滑按钮(设置除第一行之外其他行的侧滑栏)
 */
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row)
    {
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [self deleteCellAtIndexPath:indexPath];
        }];
        deleteAction.backgroundColor = [UIColor magentaColor];
        NSArray *array = [NSArray arrayWithObjects:deleteAction, nil];
        return array;
    }
    else
    {
        return nil;
    }

}

#pragma mark - 侧滑操作 下面两个方法取代如果实现的话会取代-editActionsForRowAtIndexPath:

// 未找到触发时机
//- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos)
//{
//
//}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos)
{
    UIContextualAction *topAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"置顶" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"置顶");
        // 执行完回调后侧边栏是否收回
        completionHandler(YES);
    }];
    
    UIContextualAction *deleteAction =  [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self deleteCellAtIndexPath:indexPath];
        completionHandler (true);
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    UISwipeActionsConfiguration *condig = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction,topAction]];
    // 设置为NO,防止完整的滑动动作执行第一个action的回调
    condig.performsFirstActionWithFullSwipe = NO;
    return condig;
}

@end
