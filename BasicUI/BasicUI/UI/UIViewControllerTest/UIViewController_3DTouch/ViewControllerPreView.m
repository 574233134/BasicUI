//
//  ViewControllerPreView.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/26.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ViewControllerPreView.h"
#import "PreViewController.h"
#ifdef __IPHONE_9_0
@interface ViewControllerPreView ()<UIViewControllerPreviewingDelegate>
#else
@interface ViewControllerPreView()
#endif

@property (strong, nonatomic) IBOutlet UILabel *preViewLabel;


@end

@implementation ViewControllerPreView

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preViewLabel.userInteractionEnabled = YES;
    [self registerForPreviewingWithDelegate:self sourceView:self.preViewLabel];
}

#pragma mark -UIViewControllerPreviewing Delegate

#ifdef __IPHONE_9_0

//Peek代理方法
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    PreViewController *preVC =[[PreViewController alloc] init];
    return preVC;
}

//pop代理方法
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}



#pragma mark - 3D touch Check

/**
 *  检测是否支持3D Touch
 *
 *  @return YES | NO
 */
- (BOOL)Check3DTouch
{
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        return YES;
    }
    
    return NO;
}

#endif


@end
