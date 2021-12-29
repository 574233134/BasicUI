//
//  PoperViewControllerTest.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/24.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PoperViewControllerTestDelegate <NSObject>

- (void)actionViewClickedButtonAtIndex:(NSInteger)buttonIndex title:(NSString *)title;

@end

@interface PoperViewControllerTest : UIViewController

@property (nonatomic, weak) id <PoperViewControllerTestDelegate> delegate;

- (void)loadCustomViewWithData:(NSArray *)dataArray;

@end
