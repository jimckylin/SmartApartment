//
//  CZDWebViewModel.m
//  CWGJCarOwner
//
//  Created by QingGeMac on 2017/6/29.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "CZDWebViewModel.h"
#import "WKWebViewJavascriptBridge.h"
#import "CZDWebViewController.h"
#import "LocationManager.h"

@interface CZDWebViewModel ()

@property (nonatomic, weak) WKWebViewJavascriptBridge *bridge;
@property (nonatomic, weak) CZDWebViewController *webVC;


@end

@implementation CZDWebViewModel

- (BOOL)parsingLowercaseString:(NSString *)str {
    if ([str hasPrefix:@"tel:"]||
        [str hasPrefix:@"sms:"]||
        [str containsString:@"itunes.apple.com"]) {
        UIApplication *app = [UIApplication sharedApplication];
        if ([app canOpenURL:[NSURL URLWithString:str]]) {
            [app openURL:[NSURL URLWithString:str]];
        }
        return YES;
    }
    return NO;
}

- (void)deleteWebCache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
    
}

- (void)registerNativeFunctions:(WKWebViewJavascriptBridge *)webViewscriptBridge
                     controller:(CZDWebViewController *)webVC{
    self.bridge = webViewscriptBridge;
    self.webVC = webVC;
    //注册获取用户信息方法
    [self registerGetUserInfo];
    //注册导航栏是否需要分享方法
//    [self registerCanShareMethod];
    //注册跳转页面方法
    [self registerNavToVC];
    //注册调用支付方法
    [self registerPay];
}

- (void)registerPay {
    WS(weakSelf)
    //调用客户端支付
    [self.bridge registerHandler:@"rechargePay"
                                 handler:^(id data, WVJBResponseCallback responseCallback) {
                                     
                                     responseCallback([self getAllParameWithContent:nil]);
                                 }];
    
    [self.bridge registerHandler:@"mallTicketPay"
                                 handler:^(id data, WVJBResponseCallback responseCallback) {
                                     
                                 }];
}

- (void)registerNavToVC {
    WS(weakSelf)
    //跳转原生界面到地图
    [self.bridge registerHandler:@"rechargeToMap"
                                 handler:^(id data, WVJBResponseCallback responseCallback) {
                                     
                                 }];
    //跳转原生界面免费领券网页
    [self.bridge registerHandler:@"rechargeToMall"
                                 handler:^(id data, WVJBResponseCallback responseCallback) {
                                     
                                 }];
    
    //跳转原生界面停车券页面
    [self.bridge registerHandler:@"useTicketByPakId"
                                 handler:^(id data, WVJBResponseCallback responseCallback) {
                                     
                                 }];

}

- (void)registerCanShareMethod {
//    WS(weakSelf)
//    [self.bridge registerHandler:@"canShareMethod"
//                                 handler:^(id data, WVJBResponseCallback responseCallback) {
//                                     [weakSelf.webVC setShareNavBtnShow:[data[@"isShare"] boolValue]];
//                                 }];
}

- (void)registerGetUserInfo {
    [self.bridge registerHandler:@"getUserInfo"
                                 handler:^(id data, WVJBResponseCallback responseCallback) {
                                     
                                 }];
}

- (void)callGetShareParam {
    WS(weakSelf)
    //获取分享内容
    [self.webVC.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        //取标题
        if (error) {
            title = @"";
        }
        [weakSelf.webVC.webView evaluateJavaScript:@"document.images[0].src" completionHandler:^(id _Nullable image, NSError * _Nullable error) {
            //取图片
            if (error) {
                image = @"";
            }
            [weakSelf.webVC.webView evaluateJavaScript:@"document.location.href" completionHandler:^(id _Nullable href, NSError * _Nullable error) {
                //取链接
                if (error) {
                    href = @"";
                }
                WS(weakSelf)
                
            }];
        }];
    }];
}

- (void)callShareCallback {
    //是否点击了分享
    [self.bridge callHandler:@"shareCallback"
                                data:@""
                    responseCallback:^(id responseData) {
                        NSLog(@"去分享了");
                    }];
}

- (NSString *)getAllParameWithContent:(NSDictionary *)content
{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    
    NSInteger r_code = 0;
    [mdic setObject:[NSNumber numberWithInteger:r_code] forKey:@"r_code"];
    
    NSString *r_msg = @"success";
    [mdic setObject:r_msg forKey:@"r_msg"];
    
    if (content) {
        [mdic setObject:content forKey:@"r_content"];
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mdic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error) {
        NSLog(@"error json");
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}


@end
