//
//  UIFontDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/29.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "UIFontDemo.h"

@interface UIFontDemo ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray *fontNameList;

@property (strong,nonatomic) UITableView *tableView;

@end

@implementation UIFontDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FontTest";
    [self loadData];
    [self creatTableView];
}

- (void)loadData
{
    // 获得所有字体的family名称
    self.fontNameList = [UIFont familyNames];
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
    return self.fontNameList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSString *font = [self.fontNameList objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.text = [[NSString alloc]initWithFormat:@"%@\n%@", @"FONT test 123", font];
    
    // font.name 获得字体名称
    UIFont *secondFont = [UIFont fontWithName: font size: 20.0];
    cell.textLabel.font = secondFont;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
