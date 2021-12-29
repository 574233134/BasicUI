//
//  ViewControllerRestoration.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/12/27.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "ViewControllerRestoration.h"

@interface ViewControllerRestoration ()<UIViewControllerRestoration>

@property (assign, nonatomic) NSInteger integer;

@end

@implementation ViewControllerRestoration

- (void)viewDidLoad {
    [super viewDidLoad];
    self.integer = 999;
    self.title = @"VC 状态快速恢复";
    self.view.backgroundColor = [UIColor purpleColor];
   
}

- (instancetype)init
{
    if (self)
    {
        self.restorationIdentifier = NSStringFromClass([self class]);
        self.restorationClass = [self class];
    }
    return self;
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:self.integer forKey:@"integer"];
    [super encodeRestorableStateWithCoder:coder];
    
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.integer =  [[coder decodeObjectForKey:@"integer"] integerValue];
    NSLog(@"%u",self.integer);
    [super decodeRestorableStateWithCoder:coder];
   
}

- (void)applicationFinishedRestoringState
{
    NSLog(@"状态恢复完成");
}

#pragma mark - UIViewControllerRestoration
+ (nullable UIViewController *) viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    UIViewController *vc = [self new];
    return vc;
}
@end
