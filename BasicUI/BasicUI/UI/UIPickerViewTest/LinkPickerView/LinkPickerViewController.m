//
//  LinkPickerViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/23.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "LinkPickerViewController.h"

@interface LinkPickerViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *displayResult;

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

/** 省 */
@property (strong,nonatomic)NSArray *provinceList;
/** 市 */
@property (strong,nonatomic)NSArray *cityList;
/** 区 */
@property (strong,nonatomic)NSArray *areaList;
/** 第一级选中的下标 */
@property (assign, nonatomic)NSInteger selectProvenceRow;
/** 第二级选中的下标 */
@property (assign, nonatomic)NSInteger selectCityRow;
/** 第三级选中的下标 */
@property (assign, nonatomic)NSInteger selectAreaRow;

@end

@implementation LinkPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.displayResult.delegate = self;
}

-(void)loadData
{
    [self getProvinceListJSON];
    [self getCityData:0];
    [self getAreaData:0];
}

#pragma 获取省市区数据

/**
 *  读取city文件
 */
- (void)getProvinceListJSON
{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"city" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSArray *provinceList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    self.provinceList = provinceList;
    
}

/** 根据选中的省的下标得到该省的市区列表 */
- (void)getCityData:(NSInteger)provenceIndex
{
    /** 判断是否是直辖市  如果是直辖市（type=0）则省市名一样 */
    if ([self.provinceList[provenceIndex][@"type"] intValue] == 0)
    {
        NSArray *cityArr = [[NSArray alloc] initWithObjects:self.provinceList[provenceIndex], nil];
        self.cityList = cityArr;
    }
    else
    {
        NSMutableArray *cityList = [[NSMutableArray alloc] init];
        for (NSArray *cityArr in self.provinceList[provenceIndex][@"sub"])
        {
            [cityList addObject:cityArr];
        }
        self.cityList = cityList;
    }
}

/** 根据选中市的下标得到该省所有区的列表 */
- (void)getAreaData:(NSInteger)cityRow
{
    NSMutableArray *areaList = [[NSMutableArray alloc] init];
    for (NSArray *cityDict in self.cityList[cityRow][@"sub"])
    {
        [areaList addObject:cityDict];
    }
    self.areaList = areaList;
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.provinceList.count;
    }
    else if (component == 1)
    {
        return self.cityList.count;
    }
    else if (component == 2)
    {
        return self.areaList.count;
    }
    return 0;
}

#pragma mark -- UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    static NSInteger provenceRow = 0;
    static NSInteger cityRow = 0;
    static NSInteger areaRow = 0;
    if (component == 0)
    {
        self.selectProvenceRow = row;
        [self getCityData:row];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [self getAreaData:0];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        if ([self.provinceList[self.selectProvenceRow][@"type"] intValue] == 0)
        {
            self.selectCityRow = 0;
        }
        provenceRow = row;
        cityRow = 0;
        areaRow = 0;
    }
    if (component == 1)
    {
        self.selectCityRow = row;
        [self getAreaData:row];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        cityRow = row;
        areaRow = 0;
    }
    if (component == 2)
    {
        self.selectAreaRow = row;
        areaRow = row;
    }
    NSMutableString *regionAddress = [[NSMutableString alloc] init];
    if (provenceRow > 0 &&[self.provinceList[self.selectProvenceRow][@"type"] intValue] != 0 )
    {
        [regionAddress appendFormat:@"%@省",self.provinceList[self.selectProvenceRow][@"name"]];
        
    }
    if (cityRow > 0 || [self.provinceList[self.selectProvenceRow][@"type"] intValue] == 0)
    {
        
        [regionAddress appendFormat:@"%@市",self.cityList[self.selectCityRow][@"name"]];
    }
    if (areaRow > 0 )
    {
        [regionAddress appendFormat:@"%@",self.areaList[self.selectAreaRow][@"name"]];
    }
    self.displayResult.text = regionAddress;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return self.provinceList[row][@"name"];
    }
    if (component == 1)
    {
        if ([self.provinceList[self.selectProvenceRow][@"type"] intValue] == 0)
        {
            return self.cityList[0][@"name"];
        }
        else
        {
            return self.cityList[row][@"name"];
        }
        
    }
    if (component == 2)
    {
        return self.areaList[row][@"name"];
    }
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
