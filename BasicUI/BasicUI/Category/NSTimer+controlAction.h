//
//  NSTimer+controlAction.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/19.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (controlAction)

- (void)pause;

- (void)resume;

- (void)resumeWithTimeInterval:(NSTimeInterval)time;


@end

NS_ASSUME_NONNULL_END
