//
//  WKWebViewBasic.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/19.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "WKWebViewBasic.h"
#import <WebKit/WebKit.h>
#import "BasicUIDemo.h"
@interface WKWebViewBasic ()<WKNavigationDelegate,WKUIDelegate>

@property (strong, nonatomic) WKWebView *wkWebView;

@property (strong,nonatomic)UIProgressView *progressView;

@end

@implementation WKWebViewBasic

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"WKWebView 基础";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubView];
}

- (void)creatSubView
{
    self.wkWebView =[[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-200)];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.opaque = NO;
    self.wkWebView.backgroundColor = [UIColor purpleColor];
    
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.wkWebView];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 0)];
    /** 设置未加载时进度条颜色 */
    self.progressView.trackTintColor = [UIColor grayColor];
    /** 设置加载时进度条颜色 */
    self.progressView.tintColor = [UIColor greenColor];
    /** 设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的2.5倍. */
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 2.5f);
    self.progressView.hidden = YES;
    [self.view addSubview:self.progressView];
    
    [self creatNavigationItem];
}

- (void)creatNavigationItem
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(back)];
    
    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadWKWebView)];
    
    self.navigationItem.leftBarButtonItems = @[backItem,reloadItem];
    
    UIBarButtonItem *goBack = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(wkWebViewGoBack)];
    
    UIBarButtonItem *goForward = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(wkWebViewForward)];
    
    self.navigationItem.rightBarButtonItems = @[goForward,goBack];
}

#pragma mark - WKWebview navigationDelegate

/** 开始加载 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    self.progressView.hidden = NO;
}

/** 加载完成 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.progressView.hidden = YES;
}

/** 加载失败 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    self.progressView.hidden = YES;
}

#pragma mark - navigationItem 回调

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)reloadWKWebView
{
    /** 正在刷新界面时，停止刷新后重新刷新界面 */
    if (self.wkWebView.loading)
    {
        [self.wkWebView stopLoading];
    }
    [self.wkWebView reload];
}

-(void)wkWebViewForward
{
    if ([_wkWebView canGoForward])
    {
        [_wkWebView goForward];
    }
}

-(void)wkWebViewGoBack
{
    if ([_wkWebView canGoBack])
    {
        [_wkWebView goBack];
    }
}

#pragma mark - XIB action
- (IBAction)loadNetworkResource:(UIButton *)sender
{
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.wkWebView loadRequest:request];
}

- (IBAction)loadHTML:(UIButton *)sender
{
    NSString *str1 = @"<h1>Hello</h1><ul><li>李梦珂</li><li>321</li><li>12345678</li></ul>";
    [self.wkWebView loadHTMLString:str1 baseURL:nil];
}

- (IBAction)loadLocalTXTResource:(UIButton *)sender
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"test.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.wkWebView loadData:data MIMEType:@"text/html" characterEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
}

- (IBAction)loadLocalPDFResource:(UIButton *)sender
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"WKWebviewnote.pdf" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1)
        {
            _progressView.hidden = YES;
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)dealloc
{
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end
