//
//  CAPayManager.m
//  CheWeiGuanJia
//
//  Created by 廖维海 on 15/9/10.
//  Copyright (c) 2015年 www.cheweiguanjia.com. All rights reserved.
//

#import "PayManager.h"
#import "NSMutableDictionary+CWGJ.h"

#define kWXKEY @"5701deb6c98fe19182bcc1ea7c38fd00"

@interface PayManager()

@end

@implementation PayManager

+ (PayManager *)getInstance {
    static PayManager* payManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^(){
        payManager = [[PayManager alloc] init];
    });
    return payManager;
}

#pragma mark 微信支付成功调用
- (void)PayWXSucc {
    //成功
    [self successHandle];
}

#pragma mark - 生成各种参数 微信支付
- (void)requestWX:(WXPayRContent *)rcontent {
    
    if (![WXApi isWXAppInstalled]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD cwgj_showHUDWithText:@"您还未安装微信客户端"];
        });
        return;
    }
    
    //  调起微信支付
    PayReq *request     = [[PayReq alloc] init];
    
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams cwgj_setObject: rcontent.appid        forKey:@"appid"];
    [signParams cwgj_setObject: rcontent.noncestr    forKey:@"noncestr"];
    [signParams cwgj_setObject: rcontent.packagevalue      forKey:@"package"];
    [signParams cwgj_setObject: rcontent.partnerid        forKey:@"partnerid"];
    [signParams cwgj_setObject: rcontent.timestamp   forKey:@"timestamp"];
    [signParams cwgj_setObject: rcontent.prepayid     forKey:@"prepayid"];
    //生成签名
    //NSString *sign  = [self createMd5Sign:signParams];
    NSString *sign = rcontent.sign;
    
    request.openID      = rcontent.appid;
    request.partnerId   = rcontent.partnerid;
    request.prepayId    = rcontent.prepayid;
    request.nonceStr    = rcontent.noncestr;
    request.timeStamp   = [rcontent.timestamp intValue];
    request.package     = rcontent.packagevalue;
    request.sign        = sign;
    
    [WXApi sendReq:request];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
    }
}
//创建package签名
- (NSString*) createMd5Sign:(NSMutableDictionary*)dict {
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ([[dict objectForKey:categoryId] isKindOfClass:[NSString class]] && ![[dict objectForKey:categoryId] isEqualToString:@""])
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            ) {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
    }
    //添加key字段
    [contentString appendFormat:@"key=%@", kWXKEY];
    //得到MD5 sign签名
    NSString *md5Sign =[WXUtil md5:contentString];
    //输出Debug Info
    return md5Sign;
}
#pragma mark -  支付宝
- (void)requestZFBV2:(NSString *)orderStr {
    
    if (orderStr && [orderStr isKindOfClass:[NSString class]]) {
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"SmartApartment";
        NSString *order = orderStr;
        [[AlipaySDK defaultService] payOrder:order fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] integerValue] == 9000) {
                //成功
                [self successHandle];
            }
        }];;
    }
}

#pragma mark - private
//微信、支付宝支付成功后触发
- (void)successHandle {
    self.payCompleteSureClickBlock = nil;
    if (self.didPayCompleteBlock) {
        self.didPayCompleteBlock();
    }
}


//钱包，商城支付成功后触发
- (void)showPaySuccView {
    
    
}




@end
