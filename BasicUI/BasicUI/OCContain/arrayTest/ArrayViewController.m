//
//  ArrayViewController.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/15.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "ArrayViewController.h"
#import "LogArray.h"
#import "NSArray+log.h"
@interface ArrayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)NSArray *dataArray;

@property (strong, nonatomic)UITableView *tableView;

@end

@implementation ArrayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"数组操作";
    [self loadData];
    [self creatTableView];
    
}

- (void)loadData
{
    self.dataArray = [NSArray arrayWithObjects:
                      @"查找数组某个元素的下标",
                      @"数组排序",
                      @"二分查找",
                      @"数组遍历",
                      @"数组与字符串转换",
                      @"数组比较",
                      @"可变数组相关操作",
                      @"其他",
                      nil];
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 80;
    self.tableView.sectionHeaderHeight = 0.0000001;
    self.tableView.sectionFooterHeight = 0.0000001;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.0000001)];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.0000001)];
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView数据源及代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self searchValueIndex];
        }
            break;
        case 1:
        {
            [self sortedArray];
        }
            break;
        case 2:
        {
            [self binarySearchValue];
        }
            break;
        case 3:
        {
            [self traverseArray];
        }
            break;
        case 4:
        {
            [self stringAndArrayChange];
        }
            break;
        case 5:
        {
            [self compareArray];
        }
            break;
        case 6:
        {
            [self mutableArrayAction];
        }
            break;
        case 7:
        {
            [self otherArrayAction];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 数组操作

// 查找数组元素下标
- (void)searchValueIndex
{
    NSArray *array = @[@"111",@"222",@"333",@"aaa",@"111",@"bbb"];
    NSLog(@"数组为：%@",array);
    NSInteger index = [array indexOfObject:@"111"];
    NSLog(@"111 在数组中的索引为：%u",index);
    
    // 返回相同值得最低索引
    NSInteger index2 = [array indexOfObjectIdenticalTo:@"111"];
    NSLog(@"111 在数组中的最低索引为：%u",index2);
    
    // 循环判断是否满足指定条件，满足返回 元素下标 结束遍历，不满足一直遍历完数组
    NSInteger index3 = [array indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"111"])
        {
            return YES;
        }
        return NO;
    }];
    NSLog(@"满足等于111 的索引：%u",index3);
    
}

// 数组排序
- (void)sortedArray
{
    NSArray *array1 = @[[NSNumber numberWithInt:10], [NSNumber numberWithInt:3], [NSNumber numberWithInt:5], [NSNumber numberWithInt:7], [NSNumber numberWithInt:8], [NSNumber numberWithInt:9], [NSNumber numberWithInt:19]];
    NSLog(@"1. NSComparator");
    NSArray *sortedArray = [array1 sortedArrayUsingComparator:^(NSNumber *number1, NSNumber *number2) {
        
        int value1 = [number1 intValue];
        int value2 = [number2 intValue];
        
        // 降序，即从大到小
        //        if (value1 > value2)
        //        {
        //            return NSOrderedAscending;
        //        }
        //        else
        //        {
        //            return NSOrderedDescending;
        //        }
        
        // 升序，即从小到大
        if (value1 > value2)
        {
            return NSOrderedDescending;
        }
        else
        {
            return NSOrderedAscending;
        }
    }];
    NSLog(@"%@生序排序后为%@", array1,sortedArray);
    
    NSComparator comparator = ^(id obj1, id obj2){
        
        int value1 = [obj1 intValue];
        int value2 = [obj2 intValue];
        
        // 升序，即从小到大
        //        if (value1 > value2)
        //        {
        //            return (NSComparisonResult)NSOrderedDescending;
        //        }
        //        else if (value1 < value2)
        //        {
        //            return (NSComparisonResult)NSOrderedAscending;
        //        }
        //        else
        //        {
        //            return (NSComparisonResult)NSOrderedSame;
        //        }
        
        // 降序，即从大小到
        if (value1 > value2)
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else if (value1 < value2)
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else
        {
            return (NSComparisonResult)NSOrderedSame;
        }
    };
    NSLog(@"2. NSComparator");
    sortedArray = [array1 sortedArrayUsingComparator:comparator];
    NSLog(@"%@ 降序排序为 %@", array1,sortedArray);
    
    
    // ascending=YES为升序，即从小到大，ascending=NO为降序，即从大小到
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:NO];
    NSArray *sortArray = [NSArray arrayWithObjects:descriptor, nil];
    sortedArray = [array1 sortedArrayUsingDescriptors:sortArray];
    NSLog(@"3. NSSortDescriptor");
    NSLog(@"%@ 降序排序为 %@", array1,sortedArray);
    
}

// 二分查找(需要保证数组是有序的)
- (void)binarySearchValue
{
    NSArray *array = @[@"1",@"5",@"11",@"18",@"39"];
    NSLog(@"array:%@",array);
    NSString *searchObject = @"11";
    NSRange searchRange = NSMakeRange(0, [array count]);
    NSUInteger findIndex = [array indexOfObject:searchObject
                                        inSortedRange:searchRange
                                              options:NSBinarySearchingFirstEqual
                                      usingComparator:^(id obj1, id obj2)
                            {
                                if ([obj1 integerValue] > [obj2 integerValue]) {
                                    return NSOrderedDescending;
                                }else if ([obj1 integerValue] < [obj2 integerValue]) {
                                    return NSOrderedAscending;
                                }
                                return NSOrderedSame;
                                
                            }];
    NSLog(@"查找的元素为:%@,下标为：%u",searchObject,findIndex);
}

// 遍历数组
- (void)traverseArray
{
    
    NSArray *array = @[@"111",@"222",@"333",@"aaa",@"111",@"bbb"];
    NSInteger countItem = array.count;
    NSLog(@"1. 简单for 循环遍历");
    for (int i = 0; i < countItem; i++)
    {
        NSObject *object = [array objectAtIndex:i];
        NSLog(@"%@", object);
    }
    
    NSLog(@"2. 快速遍历（最快的遍历方式）");
    for (id object in array)
    {
        NSLog(@"%@", object);
    }
    
    
    NSLog(@"3. 正序遍历");
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"顺序遍历array：%zi-->%@", idx, obj);
    }];
    
    NSLog(@"4. 倒序遍历");
    [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"倒序遍历array：%zi-->%@",idx,obj);
    }];
    
    
    NSLog(@"5. 枚举遍历正序");
    NSEnumerator *enumerator = [array objectEnumerator];
    id obj;
    while( obj=[enumerator nextObject])
    {
        NSLog(@"%@",obj);
    }
    
    NSLog(@"6. 枚举遍历反序");
    enumerator = [array reverseObjectEnumerator];
    array = enumerator.allObjects;
    NSLog(@"数组反序：%@",array);
    
}

- (void)stringAndArrayChange
{
    NSArray *array1 = [NSArray arrayWithObjects:@"Anny", @"hard", @"worker", @"women", nil];
    NSLog(@"初始数组 %@", array1);
    
    NSString *stringArray = [array1 componentsJoinedByString:@"_"];
    NSLog(@"合并后的字符串 %@", stringArray);
    
    // 字符串分离成数组时，必须以字符串中包含的相同的字符作为分割符号
    NSArray *array2 = [stringArray componentsSeparatedByString:@"_"];
    NSLog(@"分隔后的数组 %@", array2);
    
}

// 两个数组比较：比较两个数组是否相等，即数组的元素个数相等，数组的元素个个都相等
- (void)compareArray
{
    NSArray *array1 = [[NSArray alloc] initWithObjects:@"woman", @"man", @"man", nil];
    NSArray *array2 = @[@"111",@"222",@"333",@"aaa",@"111",@"bbb"];
    BOOL isEqual = [array2 isEqualToArray:array1];
    if (isEqual)
    {
        NSLog(@"%@ 等于 %@", array2, array1);
    }
    else
    {
        NSLog(@"%@ 不等于 %@", array2, array1);
    }
    
    NSArray *array3 = [NSArray arrayWithObjects:@"111",@"222",@"333",@"aaa",@"111",@"bbb", nil];
    isEqual = [array2 isEqualToArray:array3];
    if (isEqual)
    {
        NSLog(@"%@ 等于 %@", array2, array3);
    }
    else
    {
        NSLog(@"%@ 不等于 %@", array2, array3);
    }
    
}

- (void)mutableArrayAction
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"1",@"6",@"c",@"a", nil];
    NSLog(@"原始数组：%@",array);
    
    [array addObject:@"add"];
    NSLog(@"添加元素后的数组：%@",array);
    
    [array insertObject:@"5" atIndex:1];
    NSLog(@"在index=1的地方插入5 ，结果为：%@",array);
    
    [array removeLastObject];
    NSLog(@"删除最后一个元素，结果为：%@",array);
    
    [array removeObject:@"1"];
    NSLog(@"删除元素1 后的数组：%@",array);
    
    [array replaceObjectAtIndex:0 withObject:@"first"];
    NSLog(@"首元素替换为first，结果为：%@",array);
    
    [array exchangeObjectAtIndex:0 withObjectAtIndex:array.count-1];
    NSLog(@"交换数组首尾元素，结果为：%@",array);
    
}

- (void)otherArrayAction
{
    NSArray *array = [NSArray arrayWithObjects:@"张",@"wang",@"李",@"赵", nil];

    NSLog(@"元素当前编码格式的字符串:%@",array.description);

    NSLocale *locale = [NSLocale currentLocale];
    NSString *localeDescriptionStr = [array descriptionWithLocale:locale];
    NSLog(@"本地化字符串:%@",localeDescriptionStr);

    NSString *localeAndLevDescriptionStr = [array descriptionWithLocale:locale indent:3];
    NSLog(@"本地化字符串后加缩进:%@",localeAndLevDescriptionStr);

    
    id obj1 = [NSArray alloc];
    id obj2 = [NSMutableArray alloc];
    id obj3 = [obj1 init];
    id obj4 = [obj2 init];
    id obj5 = [LogArray alloc];
    id obj6 = [obj5 init];
    NSLog(@"obj1 class == %@",[obj1 class]);
    NSLog(@"obj2 class == %@",[obj2 class]);
    NSLog(@"obj3 class == %@",[obj3 class]);
    NSLog(@"obj4 class == %@",[obj4 class]);
    NSLog(@"obj5 class == %@",[obj5 class]);
    NSLog(@"obj6 class == %@",[obj6 class]);
}
@end
