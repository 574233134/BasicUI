//
//  Person.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/9.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "Person.h"

@implementation Person

// 反归档
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ([super init]) {
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    
    return self;
}

// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

@end
