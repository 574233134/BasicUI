//
//  CustomProgressController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/19.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "CustomProgressController.h"
#import "ProgressLayer.h"
@interface CustomProgressController () <UIWebViewDelegate>

@property(strong,nonatomic)UIWebView *webView;

@property(strong,nonatomic)ProgressLayer *progressLayer;

@end

@implementation CustomProgressController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义进度条";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubView];
    [self setupWebView];
}

- (void)creatSubView
{
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    self.progressLayer = [ProgressLayer new];
    self.progressLayer.frame = CGRectMake(0, 64,self.view.frame.size.width, 4);
    [self.view.layer addSublayer:self.progressLayer];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(back)];
    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadWebView:)];
    self.navigationItem.leftBarButtonItems = @[backItem,reloadItem];
    
    UIBarButtonItem *goBack = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(webViewGoBack)];
    UIBarButtonItem *goForward = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(webViewForward)];
     self.navigationItem.rightBarButtonItems = @[goForward,goBack];
}

- (void)setupWebView
{
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https:www.baidu.com"]];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

/** 开始加载网页 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.progressLayer startLoad];
}

/** 网页加载完成 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete)
    {
        [_progressLayer finishedLoad];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

#pragma mark - pravite
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)reloadWebView:(UIBarButtonItem *)item
{
    /** 正在刷新界面时，停止刷新后重新刷新界面 */
    if (self.webView.loading)
    {
        [self.webView stopLoading];
    }
    [self.webView reload];
}

-(void)webViewForward
{
    if ([_webView canGoForward])
    {
        [_webView goForward];
    }
}

-(void)webViewGoBack
{
    if ([_webView canGoBack])
    {
        [_webView goBack];
    }
}


- (void)dealloc
{
    
    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
    
}

@end
