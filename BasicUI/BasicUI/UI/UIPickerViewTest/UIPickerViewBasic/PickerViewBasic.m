//
//  PickerViewBasic.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/20.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "PickerViewBasic.h"

@interface PickerViewBasic ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(strong,nonatomic)NSMutableArray *dataArray;

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) IBOutlet UILabel *pickerViewColumn;

@property (strong, nonatomic) IBOutlet UITextField *scrollerColumn;

@property (strong, nonatomic) IBOutlet UITextField *scrollerRow;

@property (strong, nonatomic) IBOutlet UITextField *propertyColumn;

@property (strong, nonatomic) IBOutlet UILabel *rowLabel;

@property (strong, nonatomic) IBOutlet UILabel *sizeWidth;

@property (strong, nonatomic) IBOutlet UILabel *sizeHeight;

@end

@implementation PickerViewBasic

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}


-(void)loadData
{
    self.dataArray = [NSMutableArray array];
    for (int i=0 ; i<10; i++)
    {
        [self.dataArray addObject:[NSString stringWithFormat:@"数据%d",i]];
    }
}

#pragma pickerView dataSource

/** 列数 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

/** 行数 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}

#pragma pickerView delegate
/** 返回每个列的宽度 */
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED
{
    return 100;
}

/** 返回每个列的行高 */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED
{
    return 40;
}

/** 指定每行展示的数据 */
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED
{
    return self.dataArray[row];
}

/** 指定每行的数据，以及样式 */
- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    attributes[NSBackgroundColorAttributeName] = [UIColor redColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    attributes[NSUnderlineStyleAttributeName] = @YES;
    NSAttributedString * string= [[NSAttributedString alloc]initWithString:_dataArray[row] attributes:attributes];
    return string;
    
}

/** 自定义pickerView中的行 */
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED
{
    if (component == 1)
    {
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = [UIColor cyanColor];
        UILabel *label = [[UILabel alloc]init];
        label.center = view1.center;
        label.frame = CGRectMake(0, 0, 60, 30);
        label.text = self.dataArray[row];
        [view1 addSubview:label];
        return view1;
    }
    else
    {
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = [UIColor greenColor];
        UILabel *label = [[UILabel alloc]init];
        label.center = view1.center;
        label.frame = CGRectMake(0, 0, 60, 30);
        label.text = self.dataArray[row];
        [view1 addSubview:label];
        return view1;
    }
}

/** 滚动或拖拽结束后当前显示的行 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED
{
    NSLog(@"选中了第%lu列，第%lu行",component,row);
}


#pragma xib button 回调
- (IBAction)getPickerColumn:(UIButton *)sender
{
    self.pickerViewColumn.text = [NSString stringWithFormat:@"%lu",[self.pickerView numberOfComponents]];
}


- (IBAction)scrollerToRow:(UIButton *)sender
{
    NSUInteger row = [self.scrollerRow.text integerValue];
    NSInteger column = [self.scrollerColumn.text integerValue];
    [self.pickerView selectRow:row inComponent:column animated:YES];
}

- (IBAction)getRowProperty:(UIButton *)sender
{
    self.rowLabel.text =  [NSString stringWithFormat:@"%lu",[self.pickerView numberOfRowsInComponent:[self.propertyColumn.text integerValue]]];
    CGSize size = [self.pickerView rowSizeForComponent:[self.propertyColumn.text integerValue]];
    self.sizeWidth.text = [NSString stringWithFormat:@"%.0f",size.width];
    self.sizeHeight.text = [NSString stringWithFormat:@"%.0f",size.height];
}

@end
