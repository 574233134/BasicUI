//
//  WKWebViewDelegateMethod.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/20.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "WKWebViewDelegateMethod.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface WKWebViewDelegateMethod ()<WKUIDelegate,WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *wkWebView;

@end

@implementation WKWebViewDelegateMethod

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"WKWebView 代理方法";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatWKWebView];
}

- (void)creatWKWebView
{
    /** JS 配置 */
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    /** JS 注入，注入一个alert方法，页面加载完毕弹出一个对话框 forMainFrameOnly:NO(全局窗口)，yes（只限主窗口)*/
    NSString *javaScriptSource = @"alert(\"WKUserScript注入js\");";
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:javaScriptSource injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [userContentController addUserScript:userScript];
    
    WKPreferences *preference = [[WKPreferences alloc]init];
    preference.minimumFontSize = 40;
    
    /** WKWebView的配置 */
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    configuration.preferences = preference;
    self.wkWebView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:configuration];
    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate = self;
    [self.view addSubview:self.wkWebView];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.wkWebView loadRequest:request];
    
}

#pragma mark - WKWebView UIDelegate

/** 显示一个JS的Alert（与JS交互: 调用JS的alert()方法）*/
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alertVc addAction:action];
    [self presentViewController:alertVc animated:YES completion:nil];
}

/** 创建新的webview ，可以指定配置对象、导航动作对象、window特性 */
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    NSLog(@"创建一个新的webView");
    if (!navigationAction.targetFrame.isMainFrame)
    {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

/** webview关闭时调用 */
- (void)webViewDidClose:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0))
{
    NSLog(@"关闭webView");
}

/** 是否允许预览元素 */
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo API_AVAILABLE(ios(10.0))
{
    return YES;
}

- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions API_AVAILABLE(ios(10.0))
{
    return nil;
}

/**
 * 允许应用程序弹出到创建的视图控制器。
 * @param webView 调用委托方法的web视图。
 * @param previewingViewController 是正在被弹出的视图控制器。
 */
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController
{
    
}

/** 如果不实现此方法，web view将表现为用户选择取消按钮 */
- (void)webView:(WKWebView *)webView runOpenPanelWithParameters:(WKOpenPanelParameters *)parameters initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSArray<NSURL *> * _Nullable URLs))completionHandler API_AVAILABLE(macosx(10.12))
{
    
}

#pragma mark - WKNavigationDelegate

/** 根据action决定导航策略 ,通常用于处理跨域的链接能否导航。WebKit对跨域进行了安全检查限制，不允许跨域，因此我们要对不能跨域的链接单独处理 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

/** 根据Response决定响应策略 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSString *responseUrl = navigationResponse.response.URL.scheme;
    NSLog(@"responseURL:%@",responseUrl);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/** 当main frame的导航开始请求时，会调用此方法 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"main frame的导航开始请求");
}

/** 当main frame接收到服务重定向时，会回调此方法 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"重定向");
}

/** 当main frame开始加载数据失败时，会回调 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"开始下载失败");
}

/** 当main frame的web内容开始到达时，会回调 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"内容开始到达");
}

/** 当main frame导航完成时，会回调，会回调 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"导航完成");
}

/** 当main frame最后下载数据失败时 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
     NSLog(@"最后下载失败");
}

/** 授权认证 NSURLAuthenticationChallenge: 封装了服务器需要验证客户端的证书 */
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    
    completionHandler(NSURLSessionAuthChallengeUseCredential,nil);
}

/** 当web content处理完成时，会回调 */
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0))
{
    NSLog(@"处理结束");
}
@end
