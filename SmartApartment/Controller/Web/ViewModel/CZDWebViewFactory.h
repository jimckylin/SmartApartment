//
//  CZDWebViewFactory.h
//  CWGJCarOwner
//
//  Created by QingGeMac on 2017/6/29.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZDWebViewController.h"

typedef NS_ENUM(NSInteger,CZDWebType) {
    CZDWebTypeRechargePay = 1,//充值
    CZDWebTypeUserHelp = 2,//帮助中心
    CZDWebTypeTicketUseRule = 3,//使用规则
    CZDWebTypeSeverAgreement = 4,//服务协议
    CZDWebTypeRegisterAgreement = 5,//注册协议
    CZDWebTypeFindMore = 6,//发现
    CZDWebTypeFreeGetTicket = 7,//免费领券
    CZDWebTypeBreaksBuyTicket = 8,//优惠买券
    CZDWebTypeHowToGetTicket = 9,//如何领券
};

@interface CZDWebViewFactory : NSObject

//根据后缀获得完整网页地址
+ (NSString *)getAllUrlWithLast:(NSString *)last;

//根据类型生成
+ (CZDWebViewController *)getWebVcWithType:(CZDWebType)webType;

//网页地址全部 标题
+ (CZDWebViewController *)getWebVcWithUrl:(NSString *)url WebTitle:(NSString *)webTitle;

//标题为详情 url:全部
+ (CZDWebViewController *)getDetailWebVcWithUrl:(NSString *)url;

//标题为详情 url:只是后缀
+ (CZDWebViewController *)getDetailWebVcWithLastUrl:(NSString *)url;



@end
