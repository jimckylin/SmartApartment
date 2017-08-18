//
//  CZDWebViewController.h
//  CWGJCarOwner
//
//  Created by QingGeMac on 2017/6/29.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKWebView;
@interface CZDWebViewController : ParentViewController

/* 网页加载 */
@property (nonatomic, strong) WKWebView *webView;

/* 请求地址 */
@property (nonatomic, strong) NSString *requestUrl;

/* 是否需要分享按钮 */
@property (nonatomic, assign) BOOL isNeedShare;

@end
