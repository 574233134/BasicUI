//
//  DeleteCollectionViewCell.h
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/15.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DeleteCollectionViewCellDelegate

- (void)deleteCellAction:(CGPoint)point;

@end

@interface DeleteCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageDisplay;

@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) id <DeleteCollectionViewCellDelegate> deleteDelegate;
@end

NS_ASSUME_NONNULL_END
