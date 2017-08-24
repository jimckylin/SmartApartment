//
//  SAHttpRequest.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAHttpRequest.h"
#import "PPNetworkHelper.h"
#import "RequestSign.h"

@implementation SAHttpRequest


+ (NSURLSessionTask *)requestWithFuncion:(NSString *)function  params:(id)parameters success:(PPRequestSuccess)success failure:(PPRequestFailure)failure {
    
    return [self requestWithFunction:function parameters:parameters success:success failure:failure];
}


/*
 配置好PPNetworkHelper各项请求参数,封装成一个公共方法,给以上方法调用,
 相比在项目中单个分散的使用PPNetworkHelper/其他网络框架请求,可大大降低耦合度,方便维护
 在项目的后期, 你可以在公共请求方法内任意更换其他的网络请求工具,切换成本小
 */

#pragma mark - 请求的公共方法

+ (NSURLSessionTask *)requestWithFunction:(NSString *)function parameters:(NSDictionary *)parameter success:(PPRequestSuccess)success failure:(PPRequestFailure)failure {
    
    NSMutableDictionary *params = @{@"function": function,
                                    @"data"    : parameter}.mutableCopy;
    NSString *sign = [RequestSign signCreater:params];
    [params setObject:sign forKey:@"sign"];
    
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    // 设置请求头
    [PPNetworkHelper setValue:@"9" forHTTPHeaderField:@"fromType"];
    [PPNetworkHelper setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // 发起请求
    return [PPNetworkHelper POST:kBaseURL parameters:params success:^(id responseObject) {
        
        // 在这里你可以根据项目自定义其他一些重复操作,比如加载页面时候的等待效果, 提醒弹窗....
        success(responseObject);
        
    } failure:^(NSError *error) {
        // 同上
        failure(error);
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

@end
