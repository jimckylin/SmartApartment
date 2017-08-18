//
//  CZDWebViewController.m
//  CWGJCarOwner
//
//  Created by QingGeMac on 2017/6/29.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "CZDWebViewController.h"
#import <WebKit/WebKit.h>

#import "WKWebViewJavascriptBridge.h"
#import "CZDWebViewModel.h"

@interface CZDWebViewController ()<WKNavigationDelegate,WKUIDelegate>



@property (nonatomic,strong) WKWebViewJavascriptBridge *webViewscriptBridge;//js交互

@property (strong, nonatomic) CALayer *progresslayer;//进度条

/* <#name#> */
@property (nonatomic,strong)CZDWebViewModel *webVM;

@end

@implementation CZDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    [self initData];
}

#pragma mark - nav
- (void)leftBtnClick {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.webView stopLoading];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightBtnClick {
    [self.webVM callGetShareParam];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
        decisionHandler(WKNavigationActionPolicyAllow);
    } else {
        NSString *lowercaseStr = [navigationAction.request.URL.absoluteString lowercaseString];
        if ([lowercaseStr length] && lowercaseStr) {
            BOOL isParsingSucess = [self.webVM parsingLowercaseString:lowercaseStr];
            if (isParsingSucess) {
                decisionHandler(WKNavigationActionPolicyCancel);
            } else {
                decisionHandler(WKNavigationActionPolicyAllow);
            }
        } else {
            decisionHandler(WKNavigationActionPolicyAllow);
        }
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    if ([message isEqualToString:@"页面异常，请刷新页面"]) {
        
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

#pragma mark - KVO
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            if ([self.webView.title length]) {
                _naviLabel.text = self.webView.title;
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)initData {
    WS(weakSelf)
    
    self.webVM = [[CZDWebViewModel alloc] init];
    self.webViewscriptBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.webViewscriptBridge setWebViewDelegate:self];
    [self.webVM registerNativeFunctions:self.webViewscriptBridge controller:self];
}

- (void)initView {
    _naviLabel.text = self.title;
    self.webView = [[WKWebView alloc]initWithFrame:CGRectZero];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    if ([self.requestUrl length]) {
        [self.webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]]];
    }
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.webView];
    
    [self.webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    //进度条
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

@end
