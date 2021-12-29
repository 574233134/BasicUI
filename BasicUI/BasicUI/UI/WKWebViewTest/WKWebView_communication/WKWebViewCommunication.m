//
//  WKWebViewCommunication.m
//  BasicUI
//
//  Created by 李梦珂 on 2018/11/19.
//  Copyright © 2018 李梦珂. All rights reserved.
//

#import "WKWebViewCommunication.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
@interface WKWebViewCommunication () <WKUIDelegate,WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *wkWebView;

@end

@implementation WKWebViewCommunication

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"js与native交互";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatWKWebView];
    [self creatNavigationItem];
}

#pragma mark - 创建子控件
- (void)creatWKWebView
{
    /** WKWebView设置 */
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    
    WKProcessPool *pool = [[WKProcessPool alloc]init];
    config.processPool = pool;
    
    WKPreferences *preference = [[WKPreferences alloc]init];
    preference.minimumFontSize = 40;
    config.preferences = preference;
    
    /** WKWebView内容完全载入内存后才开始渲染 */
    config.suppressesIncrementalRendering = NO;
    
    /** 是否使用H5内置播放器播放 */
    config.allowsInlineMediaPlayback = YES;
    
    
    /** JSHandler */
    WKUserContentController *usercontentController = [[WKUserContentController alloc]init];
    
    // 注：此处的name 一定要与JS调用原生时所写的方法相同
    [usercontentController addScriptMessageHandler:self  name:@"Location"];

    config.userContentController = usercontentController;
    self.wkWebView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:config];
    
    
    /** 标识是否⽀支持左、右swipe⼿手势是否可以前进、后退 */
    self.wkWebView.allowsBackForwardNavigationGestures = YES;
    self.wkWebView.UIDelegate = self;
    self.wkWebView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.wkWebView];
    
    [self loadLocalHTML];
    
}

- (void)creatNavigationItem
{
    UIBarButtonItem *setAge = [[UIBarButtonItem alloc]initWithTitle:@"setAge" style:UIBarButtonItemStyleDone target:self action:@selector(setAge)];
    
    UIBarButtonItem *commitTest = [[UIBarButtonItem alloc] initWithTitle:@"commitTest" style:UIBarButtonItemStyleDone target:self action:@selector(commitTest)];
    
    self.navigationItem.rightBarButtonItems = @[setAge,commitTest];
}


- (void)loadLocalHTML
{
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"a.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
    [self.wkWebView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
}

#pragma mark - WKScriptMessageHandler
/** js调用oc的方法在该方法内进行处理 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    /** body为js中传入的参数 */
    NSLog(@"body:%@",message.body);
    
    // 使用原生方法作为JS按钮的回调
    if ([message.name isEqualToString:@"Location"])
    {
        [self getLocation];
    }
    
}

#pragma mark - 移除handle 防止循环引用

-(void)dealloc
{
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"Location"];

}

#pragma mark - WKWebView UIDelegate

/** 显示一个JS的Alert（与JS交互）*/
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alertVc addAction:action];
    [self presentViewController:alertVc animated:YES completion:nil];
}

/** 弹出一个输入框（与JS交互 :调用JS的prompt()方法 ）*/
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:prompt message:defaultText preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertVc.textFields[0].text);
    }];
    /** 定义第一个输入框 */
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
     {
         textField.placeholder = defaultText;
     }];
    [alertVc addAction:action];
    [self presentViewController:alertVc animated:YES completion:nil];
}

/** 显示一个确认框 :调用JS的confirm()方法 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"确认框" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(1);
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(0);
    }];
    [alertVc addAction:okAction];
    [alertVc addAction:cancelAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - 原生调用js方法 
- (void)getLocation
{
    /** 将结果返回给js (OC调用JS) */
    NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')",@"北辰世纪中心"];
    [self.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"getLocation：%@----%@",result, error);
    }];
    
}

- (void)setAge
{
    [self.wkWebView evaluateJavaScript:@"inputBox()" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
}

- (void)commitTest
{
    [self.wkWebView evaluateJavaScript:@"popconfirm()" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
}
@end
