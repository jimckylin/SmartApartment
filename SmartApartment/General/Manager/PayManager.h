//
//  CAPayManager.h
//  CheWeiGuanJia
//
//  Created by 廖维海 on 15/9/10.
//  Copyright (c) 2015年 www.cheweiguanjia.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXUtil.h"
#import "WXApi.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "WXPayRContent.h"
#import "ZFBPayRContent.h"

@interface PayManager : NSObject

+ (PayManager*)getInstance;

//微信请求
- (void)requestWX:(WXPayRContent *)rcontent;

//支付宝请求
- (void)requestZFBV2:(NSDictionary *)orderDic;

- (void)showPaySuccView;


- (void)PayWXSucc;

//支付成功回调
@property (nonatomic, copy) void(^didPayCompleteBlock)();

// 支付成功确定按钮回调
@property (nonatomic, copy) void(^payCompleteSureClickBlock)();

@end
