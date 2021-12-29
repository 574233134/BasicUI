//
//  Person.h
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/9.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (strong, nonatomic)NSString *name;

@property (strong, nonatomic)NSString *sex;

@property (assign, nonatomic)NSInteger age;

@end

NS_ASSUME_NONNULL_END
