//
//  HitTestTool.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/21.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface HitTestTool : NSObject

CGRect HitTestingBounds(CGRect bounds, CGFloat minimumHitTestWidth, CGFloat minimumHitTestHeight);

@end
