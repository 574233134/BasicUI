//
//  LMKUntils.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/4/24.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "LMKUntils.h"

#pragma mark - 合法校验
static BOOL validateString(NSString *string)
{
    BOOL result = NO;
    if (string && [string isKindOfClass:[NSString class]] && [string length]) {
        result = YES;
    }
    return result;
}

static BOOL validateArray(NSArray *array)
{
    BOOL result = NO;
    if (array && [array isKindOfClass:[NSArray class]] && [array count]) {
        result = YES;
    }
    return result;
}

static BOOL validateDictionary(NSDictionary *dictionary)
{
    BOOL result = NO;
    if (dictionary && [dictionary isKindOfClass:[NSDictionary class]] && [dictionary count]) {
        result = YES;
    }
    return result;
}

#pragma mark - Json 相关转换
static NSString * arrayToJson(NSArray *arr) {
    if (!validateArray(arr)) return @"[]";
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];
    }else{
        return @"[]";
    }
}


static NSString * dictionaryToJson(NSDictionary *dic) {
    if (!validateDictionary(dic)) return @"{}";
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];
    }else{
        return @"{}";
    }
}

static NSArray * jsonToArray(NSData *data) {
    
    if(!data)
        return nil;
    if (![data isKindOfClass:[NSData class]]) {
        return nil;
    }
    
    NSString *dataAsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (![dataAsStr hasPrefix:@"["]) return nil;
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    return (NSArray *)jsonObject;
}

static NSDictionary * jsonToDictionary(NSData *data) {
    
    if(!data)
        return nil;
    if (![data isKindOfClass:[NSData class]]) {
        return nil;
    }
    NSString *dataAsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (![dataAsStr hasPrefix:@"{"]) return nil;
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    return (NSDictionary *)jsonObject;
}

#pragma mark - 当前时间
static NSString * getNowTimeStr() {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps;
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    
    NSInteger yeah = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    
    return [NSString stringWithFormat:@"%04lu-%02lu-%02lu %02lu:%02lu", yeah, month, day, hour, min];
}

// 创建日期字符串(全)
static NSString * getCurrentDateTimer()
{
    NSString *string = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YMMddHHmmss"];
    string = [dateFormatter stringFromDate:[NSDate date]];
    
    return string;
}

static NSString* timeString(double timeSec){
    
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:0] toDate:[NSDate dateWithTimeIntervalSinceReferenceDate:timeSec] options:0];
    
    NSInteger hours = [dateComponents hour];
    NSInteger minutes = [dateComponents minute];
    NSInteger seconds = [dateComponents second];
    
    NSString *time = [NSString stringWithFormat:@"%li:%li:%li", hours, minutes, seconds];
    
    return time;
}


static NSString* timeStringFromDay(double timeSec){
    
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:0] toDate:[NSDate dateWithTimeIntervalSinceReferenceDate:timeSec] options:0];
    
    NSInteger days = [dateComponents day];
    NSInteger hours = [dateComponents hour];
    NSInteger minutes = [dateComponents minute];
    NSInteger seconds = [dateComponents second];
    
    NSString *time = [NSString stringWithFormat:@"%li:%li:%li:%li", days,hours, minutes, seconds];
    
    return time;
}

LMKUntils_t LMKUntils = {
    validateString,
    validateArray,
    validateDictionary,
    arrayToJson,
    dictionaryToJson,
    jsonToArray,
    jsonToDictionary,
    getNowTimeStr,
    getCurrentDateTimer,
    timeString,
    timeStringFromDay
    
};
