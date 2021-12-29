//
//  PoperViewControllerTwo.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/25.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PoperViewControllerTwoDelegate <NSObject>

- (void)selectAtIndex:(NSIndexPath *)indexPath data:(NSString *)data;

@end


@interface PoperViewControllerTwo : UIViewController


@property (strong, nonatomic) NSMutableArray *dataList;

@property (weak, nonatomic) id <PoperViewControllerTwoDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)setDataArray:(NSArray *)dataArray;

- (void)reloadData;

@end
