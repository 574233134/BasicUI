//
//  WebViewBasicController.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/19.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "WebViewBasicController.h"

@interface WebViewBasicController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation WebViewBasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"webView基础";
    self.webView.delegate = self;
}
#pragma mark - webview delegate
/** 网页中的每一个请求都会被触发这个方法，返回NO代表不执行这个请求(常用于JS与iOS之间通讯) */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

/** 网页开始加载的时候调用 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"begin");
}

/** 网页结束加载的时候调用 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"end");
}

/** 网页加载失败的时候调用 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"fail");

}

#pragma mark - xib action
- (IBAction)loadRequest:(UIButton *)sender
{
    NSURL *string = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:string];
    [self.webView loadRequest:request];
}

- (IBAction)loadHTML:(UIButton *)sender
{
    NSString *str1 = @"<h1>Hello</h1><ul><li>李梦珂</li><li>321</li><li>12345678</li></ul>";
    [self.webView loadHTMLString:str1 baseURL:nil];
}

/** 加载本地文件的第一种方式 */
- (IBAction)loadLocalResource:(UIButton *)sender
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"UIWebview.pdf" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.webView loadData:data MIMEType:@"application/pdf" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:path]];
}

/** 加载本地文件的第二种方式 */
- (void)loadLocalResource2
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"UIWebview.pdf" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

/** 加载本地文件的第三种方式 */
- (void)loadLocalResource3
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UIWebview.pdf" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end
