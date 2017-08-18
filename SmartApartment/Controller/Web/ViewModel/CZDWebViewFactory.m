//
//  CZDWebViewFactory.m
//  CWGJCarOwner
//
//  Created by QingGeMac on 2017/6/29.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "CZDWebViewFactory.h"

@implementation CZDWebViewFactory

#pragma mark - private

+ (NSString *)getPreUrl {
    return @"http://www.baidu.com";
}

+ (NSString *)getAllUrlWithLast:(NSString *)last {
    return [[self getPreUrl] stringByAppendingString:last];
}

#pragma mark - public

+ (CZDWebViewController *)getWebVcWithType:(CZDWebType)webType {
    CZDWebViewController *vc = [[CZDWebViewController alloc] init];
    switch (webType) {
        case CZDWebTypeRechargePay: {
            vc.title = @"充值";
             vc.requestUrl = [self getAllUrlWithLast:[NSString stringWithFormat:@"html/app/recharge.html?_timestamp=%f",[NSDate date].timeIntervalSince1970]];
        }
            break;
            
        case CZDWebTypeFindMore: {
            vc.title = @"发现";
            vc.isNeedShare = YES;
            vc.requestUrl = [self getAllUrlWithLast:[NSString stringWithFormat:@"html/app/findPage.html?_timestamp=%f",[NSDate date].timeIntervalSince1970]];
        }
            break;
        
        case CZDWebTypeUserHelp: {
            vc.title = @"使用帮助";
            vc.requestUrl = [self getAllUrlWithLast:@"html/app/howtouse.html"];
        }
            break;
        
        case CZDWebTypeSeverAgreement: {
            vc.title = @"服务协议";
            vc.requestUrl = [self getAllUrlWithLast:@"service_terms.html"];
        }
            break;
        
        case CZDWebTypeRegisterAgreement: {
            vc.title = @"软件许可及服务协议";
            vc.requestUrl = [self getAllUrlWithLast:@"register_protocol.html"];
        }
            break;
            
        case CZDWebTypeFreeGetTicket: {
            vc.title = @"领券中心";
            vc.requestUrl = [self getAllUrlWithLast:[NSString stringWithFormat:@"html/app/couponsManager.html?_timestamp=%f",[NSDate date].timeIntervalSince1970]];
        }
            break;
        case CZDWebTypeBreaksBuyTicket: {
            vc.title = @"商城";
            NSString *url = [self getAllUrlWithLast:[NSString stringWithFormat:@"html/app/couponsManager.html#/mall?_timestamp=%f",[NSDate date].timeIntervalSince1970]];
            vc.requestUrl = url;
        }
            break;
        case CZDWebTypeHowToGetTicket: {
            vc.title = @"详情";
            vc.requestUrl = [self getAllUrlWithLast:@"html/app/howtoreceive.html"];
        }
            break;
        case CZDWebTypeTicketUseRule: {
            vc.title = @"使用规则";
            vc.requestUrl = [self getAllUrlWithLast:@"html/new_wx/use_rule.html"];
        }
            break;
        default:
            break;
    }
    return vc;
}

+ (CZDWebViewController *)getWebVcWithUrl:(NSString *)url WebTitle:(NSString *)webTitle {
    CZDWebViewController *vc = [[CZDWebViewController alloc] init];
    vc.title = webTitle;
    vc.requestUrl = url;
    vc.isNeedShare = YES;
    return vc;
}

+ (CZDWebViewController *)getDetailWebVcWithUrl:(NSString *)url {
    CZDWebViewController *vc = [[CZDWebViewController alloc] init];
    vc.title = @"详情";
    vc.requestUrl = url;
    vc.isNeedShare = YES;
    return vc;
}

+ (CZDWebViewController *)getDetailWebVcWithLastUrl:(NSString *)url {
    CZDWebViewController *vc = [[CZDWebViewController alloc] init];
    vc.title = @"详情";
    vc.requestUrl = [self getAllUrlWithLast:url];
    vc.isNeedShare = YES;
    return vc;
}

@end
