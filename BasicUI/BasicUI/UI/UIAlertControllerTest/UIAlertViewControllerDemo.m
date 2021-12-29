//
//  UIAlertViewControllerDemo.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/9/25.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "UIAlertViewControllerDemo.h"
#import "CustomAlertVC/CustomAlertController.h"
@interface UIAlertViewControllerDemo () <UITableViewDelegate, UITableViewDataSource>
    
@property (strong,nonatomic) UITableView *tableView;
    
@property (strong, nonatomic) NSArray *dataArray;
    
@end

@implementation UIAlertViewControllerDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"警告框";
    [self.navigationController setToolbarHidden:YES];
    self.view.backgroundColor =[UIColor whiteColor];
    [self initDataArray];
    [self creatTableView];
}
    
- (void)initDataArray
{
    self.dataArray = [NSArray arrayWithObjects:@"简单警告框（底部）", @"警告框（中心）",@"带输入框的警告框",@"KVC更改AlertVC",@"自定义警告框（中心）",@"自定义警告框（底部）",nil];
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
    switch (indexPath.row)
    {
        case 0:
        {
            [self systemAlertVC:UIAlertControllerStyleActionSheet];
        }
        break;
        case 1:
        {
            [self systemAlertVC:UIAlertControllerStyleAlert];
        }
        break;
        case 2:
        {
            [self withTextFieldAlertVC];
        }
        break;
        case 3:
        {
            [self useKVCChangeSystemAlertVC];
        }
        break;
        case 4:
        {
            [self customAlert];
        }
        break;
        case 5:
        {
            [self customActionSheet];
        }
        break;
        default:
        break;
    }
}
  
- (void)systemAlertVC:(UIAlertControllerStyle)style
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"警告框" message:@"message" preferredStyle:style];
    
    // 没有标题时不显示标题框
    alertVC.title.accessibilityElementsHidden = YES;
    
    UIAlertAction *defaultAction =[UIAlertAction actionWithTitle:@"默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了默认按钮");
    }];
    [alertVC addAction:defaultAction];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"残忍拒绝" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了残忍拒绝");
    }];
    [alertVC addAction:destructiveAction];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
    [alertVC addAction:cancleAction];
     
    [ self presentViewController:alertVC animated:YES completion:nil] ;
}
    
    
- (void)withTextFieldAlertVC
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"带输入框的警告框" message:@"message" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"输入用户名";
    }];
    
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入密码";
    }];
    
    UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定按钮");
    }];
    [alertVC addAction:okAction];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消按钮");
    }];
    [alertVC addAction:cancleAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)useKVCChangeSystemAlertVC
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];
    
    // 使用富文本来改变alert的title字体大小和颜色
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"这里是标题"];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, title.length)];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, title.length)];
    [alert setValue:title forKey:@"attributedTitle"];
    
    // 使用富文本来改变alert的message字体大小和颜色
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"这里是正文信息"];
    [message addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, message.length)];
    [message addAttribute:NSForegroundColorAttributeName value:[UIColor brownColor] range:NSMakeRange(0, message.length)];
    [alert setValue:message forKey:@"attributedMessage"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    // 设置按钮背景图片
    UIImage *accessoryImage = [[UIImage imageNamed:@"umbrellaIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [cancelAction setValue:accessoryImage forKey:@"image"];
    
    // 设置按钮的title颜色
    [cancelAction setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
    
    // 设置按钮的title的对齐方式
    [cancelAction setValue:[NSNumber numberWithInteger:NSTextAlignmentLeft] forKey:@"titleTextAlignment"];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)customAlert
{
    
    CustomAlertController *alertController = [CustomAlertController alertControllerWithTitle:@"标题" message:@"信息" style:CustomAlertControllerStyleAlert];
    CustomAlertAction *cancel = [CustomAlertAction actionWithTitle:@"取消" style:CustomAlertActionStyleCancel handler:^(CustomAlertAction * _Nonnull action) {
        NSLog(@"custom:点击了取消");
    }];
    
    
    CustomAlertAction *done = [CustomAlertAction actionWithTitle:@"确认" style:CustomAlertActionStyleDone handler:^(CustomAlertAction * _Nonnull action) {
        NSLog(@"custom:点击了确定");
    }];
    
//   CustomAlertAction *done1 = [CustomAlertAction actionWithTitle:@"确认" style:CustomAlertActionStyleDone handler:^(CustomAlertAction * _Nonnull action) {
//        NSLog(@"custom:点击了确定");
//    }];
    
    
    //自定义颜色设置
    alertController.layout.doneActionTitleColor = [UIColor redColor];
    alertController.layout.cancelActionBackgroundColor = [UIColor whiteColor];
    alertController.layout.doneActionBackgroundColor = [UIColor yellowColor];
    alertController.layout.lineColor = [UIColor redColor];
    alertController.layout.topViewBackgroundColor = [UIColor orangeColor];
    alertController.layout.titleColor = [UIColor whiteColor];
    [alertController layoutSettings];
    
    [alertController addAction:cancel];
    [alertController addAction:done];
//    [alertController addAction:done1];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
    
- (void)customActionSheet
{

    CustomAlertController *alertController = [CustomAlertController alertControllerWithTitle:@"标题" message:@"message" style:CustomAlertControllerStyleActionSheet];
    CustomAlertAction *cancel = [CustomAlertAction actionWithTitle:@"考虑一下" style:1 handler:^(CustomAlertAction * _Nonnull action) {
        NSLog(@"custom:点击了取消");
    }];
    
    
    CustomAlertAction *done = [CustomAlertAction actionWithTitle:@"赞一个" style:2 handler:^(CustomAlertAction * _Nonnull action) {
        NSLog(@"custom:点击了确定");
    }];
    
    //自定义颜色设置
    alertController.layout.doneActionTitleColor = [UIColor redColor];
    alertController.layout.cancelActionBackgroundColor = [UIColor whiteColor];
    alertController.layout.doneActionBackgroundColor = [UIColor cyanColor];
    alertController.layout.lineColor = [UIColor redColor];
    alertController.layout.topViewBackgroundColor = [UIColor whiteColor];
    alertController.layout.titleColor = [UIColor redColor];
    [alertController layoutSettings];
    
    [alertController addAction:cancel];
    [alertController addAction:done];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
