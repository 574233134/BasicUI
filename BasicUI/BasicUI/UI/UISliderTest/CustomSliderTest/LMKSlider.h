//
//  LMKSlider.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/11.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

// title显示在滑块的上方或下方
typedef enum : NSUInteger{
    TopTitleStyle,
    BottomTitleStyle
}TitleStyle;

@interface LMKSlider : UISlider

//是否显示百分比
@property (nonatomic,assign) BOOL isShowTitle;

@property (nonatomic,assign) TitleStyle titleStyle;

@end
