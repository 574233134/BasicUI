//
//  WaterFlowLayout.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/16.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate <NSObject>

@required

/** 返回index位置下的item的高度 */
- (CGFloat)waterFallLayout:(WaterFlowLayout*)waterFlowLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width;

@optional

/** 返回瀑布流显示的列数 */
- (NSUInteger)columnCountOfWaterFallLayout:(WaterFlowLayout *)waterFlowLayout;

/** 返回行间距 */
- (CGFloat)rowMarginOfWaterFallLayout:(WaterFlowLayout *)waterFlowLayout;

/** 返回列间距 */
- (CGFloat)columnMarginOfWaterFallLayout:(WaterFlowLayout *)waterFlowLayout;

/** 返回边缘间距 */
- (UIEdgeInsets)edgeInsetsOfWaterFallLayout:(WaterFlowLayout *)waterFlowLayout;


@end

@interface WaterFlowLayout : UICollectionViewLayout

@property(weak,nonatomic)id <WaterFlowLayoutDelegate> delegate;

@end
