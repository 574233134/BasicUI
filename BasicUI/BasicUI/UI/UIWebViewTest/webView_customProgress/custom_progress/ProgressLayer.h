//
//  ProgressLayer.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/19.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressLayer : CAShapeLayer

- (void)finishedLoad;

- (void)startLoad;

- (void)closeTimer;

@end

NS_ASSUME_NONNULL_END
