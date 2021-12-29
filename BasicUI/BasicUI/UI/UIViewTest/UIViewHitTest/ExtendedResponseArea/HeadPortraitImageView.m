//
//  HeadPortraitImageView.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/21.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "HeadPortraitImageView.h"
#import "HitTestTool.h"
@implementation HeadPortraitImageView


- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
{
    return CGRectContainsPoint(HitTestingBounds(self.bounds, self.minimumHitTestWidth, self.minimumHitTestHeight), point);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击了头像");
}
@end
