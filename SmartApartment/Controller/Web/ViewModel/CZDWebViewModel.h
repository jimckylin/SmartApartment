//
//  CZDWebViewModel.h
//  CWGJCarOwner
//
//  Created by QingGeMac on 2017/6/29.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WKWebViewJavascriptBridge,CZDWebViewController;
@interface CZDWebViewModel : NSObject

- (BOOL)parsingLowercaseString:(NSString *)str;

- (void)registerNativeFunctions:(WKWebViewJavascriptBridge *)webViewscriptBridge
                     controller:(CZDWebViewController *)webVC;

- (void)callGetShareParam;

- (void)deleteWebCache;
@end
