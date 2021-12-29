//
//  LMKViewGstures.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/20.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "LMKViewGstures.h"

@interface LMKViewGstures ()

@property (strong, nonatomic) IBOutlet UIView *oneTapView;

@property (strong, nonatomic) IBOutlet UIView *doubleTapView;

@property (strong, nonatomic) IBOutlet UIView *longPressView;

@property (strong, nonatomic) IBOutlet UIView *swipeView;

@property (strong, nonatomic) IBOutlet UIView *rotationView;

@property (strong, nonatomic) IBOutlet UIView *pinchView;

@property (strong, nonatomic) IBOutlet UIView *panView;


@end

@implementation LMKViewGstures

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"UIView手势";
    [self addSubViewGusture];
}

- (void)addSubViewGusture
{
    [self addGustureForOneTapView];
    [self addGustureForDoubleTapView];
    [self addGustureForLongPressView];
    [self addGustureForSwipeView];
    [self addGustureForRotationView];
    [self addGustureForPinchView];
    [self addGustureForPanView];
}

#pragma mark - 手势
/** 单击手势 */
- (void)addGustureForOneTapView
{
    UITapGestureRecognizer *oneTapGusture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    self.oneTapView.userInteractionEnabled = YES;
    [self.oneTapView addGestureRecognizer:oneTapGusture];
}

/** 双击手势 */
- (void)addGustureForDoubleTapView
{
    UITapGestureRecognizer *doubleTapGusture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGusture.numberOfTapsRequired = 2;
    self.doubleTapView.userInteractionEnabled = YES;
    [self.doubleTapView addGestureRecognizer:doubleTapGusture];
}

/** 长按手势 */
- (void)addGustureForLongPressView
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPress.minimumPressDuration = 2;
    [self.longPressView addGestureRecognizer:longPress];
}

/** 轻扫手势 */
- (void)addGustureForSwipeView
{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.swipeView addGestureRecognizer:swipeGesture];
}

/** 旋转手势 */
- (void)addGustureForRotationView
{
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
    [self.rotationView addGestureRecognizer:rotation];
}

/** 捏合手势 */
- (void)addGustureForPinchView
{
    UIPinchGestureRecognizer  *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [self.pinchView addGestureRecognizer:pinch];
}

/** 滑动手势 */
- (void)addGustureForPanView
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.panView addGestureRecognizer:panGesture];
}



# pragma mark - 手势回调
- (void)tap:(UITapGestureRecognizer *)tapGetrue
{
     if (tapGetrue.state == UIGestureRecognizerStateEnded)
     {
         [self alertWithTitle:@"单击" message:nil];
     }
    
}

- (void)doubleTap:(UITapGestureRecognizer *)tapGetrue
{
    if (tapGetrue.state == UIGestureRecognizerStateEnded)
    {
        [self alertWithTitle:@"双击" message:nil];
    }
}

- (void)swipeAction:(UISwipeGestureRecognizer *)swipeGesture
{
    switch (swipeGesture.state) {
        case UIGestureRecognizerStateEnded:
            [self alertWithTitle:@"轻扫" message:nil];
            break;
        default:
            break;
    }
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateEnded)
    {
        [self alertWithTitle:@"长按" message:nil];
    }

}

- (void)panAction:(UIPanGestureRecognizer *)panGesture {
    CGPoint p = [panGesture locationInView:self.view];
    NSLog(@"滑动手势：%@",NSStringFromCGPoint(p));
}

- (void)rotationAction:(UIRotationGestureRecognizer *)rotation
{
    
    //角度
    float degree = rotation.rotation*(180/M_PI);
    
    NSLog(@"旋转手势的旋转角度： %f",degree);
    
}

- (void)pinchAction:(UIPinchGestureRecognizer *)pinch {
    if (pinch.scale > 0) {
        NSLog(@"放大");
    } else {
        NSLog(@"缩小");
    }
    NSLog(@"缩放手势： %f",pinch.scale);
}

#pragma mark - 封装警告框
-(void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}


@end
