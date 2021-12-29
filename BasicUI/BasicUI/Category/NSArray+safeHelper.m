//
//  NSArray+safeHelper.m
//  BasicUI
//
//  Created by 李梦珂 on 2019/5/27.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "NSArray+safeHelper.h"

@implementation NSArray (safeHelper)

- (instancetype)initWithObjects_safe:(id *)objects count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!objects[i]) {
            break;
        }
        newCnt++;
    }
    self = [self initWithObjects:objects count:newCnt];
    return self;
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    return [self objectAtIndex:index];
}

- (NSArray *)safe_arrayByAddingObject:(id)anObject {
    if (!anObject) {
        return self;
    }
    return [self arrayByAddingObject:anObject];
}

@end
