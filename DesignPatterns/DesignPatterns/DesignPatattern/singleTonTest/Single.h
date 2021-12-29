//
//  Single.h
//  DesignPatterns
//
//  Created by Lin on 2019/3/11.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Single : NSObject
+ (Single *)sharedSingleClassName;
@end

NS_ASSUME_NONNULL_END
