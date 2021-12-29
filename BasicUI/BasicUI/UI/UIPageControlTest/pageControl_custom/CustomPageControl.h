//
//  CustomPageControl.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/27.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPageControl : UIPageControl

@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong) UIImage *inactiveImage;

@property (nonatomic, assign) CGSize currentImageSize;
@property (nonatomic, assign) CGSize inactiveImageSize;

@property (nonatomic, assign) CGFloat magrin; // 间距

@end
