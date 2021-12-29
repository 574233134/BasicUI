//
//  SingletonPatternDemo.m
//  DesignPatterns
//
//  Created by 李梦珂 on 2019/1/14.
//  Copyright © 2019 李梦珂. All rights reserved.
//

#import "SingletonPatternDemo.h"
#import "OneTimeClass.h"
#import "Single.h"
@interface SingletonPatternDemo ()
@property (strong, nonatomic) IBOutlet UILabel *objectTitle;

@end

@implementation SingletonPatternDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"单例模式";
    // 系统默认就是白色 下面代码可以去掉
    self.view.backgroundColor = [UIColor whiteColor];
}
// 参照Single.m
- (IBAction)creatSiglePatternObjc:(UIButton *)sender
{
    OneTimeClass *vc = [[OneTimeClass alloc]init];
    self.objectTitle.text = [NSString stringWithFormat:@"%@",vc];
    
//    Single *singleVC = [[Single alloc]init];
//    self.objectTitle.text = [NSString stringWithFormat:@"%@",singleVC];

}




@end
