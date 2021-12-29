//
//  HitTestProtocol.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/21.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HitTestProtocol <NSObject>

@required

@property (nonatomic) IBInspectable CGFloat minimumHitTestWidth;
@property (nonatomic) IBInspectable CGFloat minimumHitTestHeight;

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event;


@end
