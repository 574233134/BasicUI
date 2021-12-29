//
//  ColorPoperViewController.h
//  BasicUI
//
//  Created by 李梦珂 on 2019/11/20.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ColorPoperViewControllerDelegate <NSObject>

- (void)selectAtIndex:(NSIndexPath *)indexPath data:(UIColor *)color fromTag:(NSInteger)fromTag;

@end

@interface ColorPoperViewController : UIViewController

@property (assign, nonatomic)NSInteger fromTag;

@property (strong, nonatomic) NSMutableArray *dataList;

@property (weak, nonatomic) id <ColorPoperViewControllerDelegate> delegate;


- (void)setDataArray:(NSArray *)dataArray;

- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
