//
//  PreViewController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/26.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "PreViewController.h"
#ifdef __IPHONE_9_0
@interface PreViewController ()<UIPreviewActionItem>
#else
@interface PreViewController()
#endif

@end

@implementation PreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];

}


#pragma mark - UIPreviewActionItem

#ifdef __IPHONE_9_0
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction * act1 = [UIPreviewAction actionWithTitle:@"操作1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        //添加点击处理操作
        
    }];
    
    UIPreviewAction * act2 = [UIPreviewAction actionWithTitle:@"操作2" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    UIPreviewAction * act3 = [UIPreviewAction actionWithTitle:@"操作3" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        
    }];
    
    return [NSArray arrayWithObjects:act1,act2,act3, nil];
}
#endif


@end
