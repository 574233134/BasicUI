//
//  LMKUntils.h
//  BasicUI
//
//  Created by 李梦珂 on 2019/4/24.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _LMKUntils_t{
    
    /*!
     *  判断所传对象是否为NSString的类或子类的实例
     *
     *  @param string 传入需要判断的实例
     *
     *  @return 如果传入实例为NSString类或其子类的实例并且包含至少一个字符则返回YES，否则返回NO
     *
     *  @since 1.0+
     */
    BOOL (*validateString)(NSString *string);
    
    /*!
     *  判断所传对象是否为NSArray的类或子类的实例
     *
     *  @param string 传入需要判断的实例
     *
     *  @return 如果传入实例为NSArray类或其子类的实例并且包含至少一个对象则返回YES，否则返回NO
     *
     *  @since 1.0+
     */
    BOOL (*validateArray)(NSArray *array);
    
    /*!
     *  判断所传对象是否为NSDictionary的类或子类的实例
     *
     *  @param string 传入需要判断的实例
     *
     *  @return 如果传入实例为NSDictionary类或其子类的实例返回YES，否则返回NO
     *
     *  @since 1.0+
     */
    BOOL (*validateDictionary)(NSDictionary *dictionary);
    
    /*!
     *  数组转json串
     *
     *  @param arr 数组
     *
     *  @return 字符串
     *
     *  @since 2.0+
     */
    NSString * (*arrayToJson)(NSArray* arr);
    
    /*!
     *  字典转json串
     *
     *  @param dic 字典
     *
     *  @return 字符串
     *
     *  @since 2.0+
     */
    NSString * (*dictionaryToJson)(NSDictionary *dic);
    
    /*!
     *  data转数组
     *
     *  @param data data
     *
     *  @return 数组
     *
     *  @since 2.0+
     */
    NSArray * (*jsonToArray)(NSData *data);
    
    
    /*!
     *  data转字典
     *
     *  @param data data
     *
     *  @return 字典
     *
     *  @since 2.0+
     */
    NSDictionary * (*jsonToDictionary)(NSData *data);
    
    /*!
     *  获取当前时间的格式化后字串，如：2013-12-19 16:10
     *
     *  @return 返回时间字串
     *  @since 1.0+
     */
    NSString * (*getNowTimeStr)(void);
    
    
    /*!
     *  获取当前时间格式化后字串，如：20131219161452
     *
     *  @return 返回时间字串
     *
     *  @since 1.0+
     */
    NSString * (*getCurrentDateTimer)(void);
    
    /*!
     *  返回时间的字串，如，10:10:10 (时:分:秒)
     *
     *  @param timeSec
     *
     *  @return 返回冒号分隔的时间
     *
     *  @since 1.0+
     */
    NSString * (*timeString)(double timeSec);
    
    /*!
     *  返回时间的字串，如，10:10:10:10 (天:时:分:秒)
     *
     *  @param timeSec
     *
     *  @return 返回冒号分隔的时间
     *
     *  @since 1.0+
     */
    NSString * (*timeStringFromDay)(double timeSec);
    
} LMKUntils_t;

extern LMKUntils_t LMKUntils;

