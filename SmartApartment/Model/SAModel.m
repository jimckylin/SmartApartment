//
//  SAModel.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAModel.h"
#import "RequestSign.h"
#import "YRJSONAdapter.h"
#import "AESCipher.h"
#import <YYModel/YYModel.h>

@implementation SAModel

+ (NSString *)node {
    
    return nil;
}


/*
 配置好PPNetworkHelper各项请求参数,封装成一个公共方法,给以上方法调用,
 相比在项目中单个分散的使用PPNetworkHelper/其他网络框架请求,可大大降低耦合度,方便维护
 在项目的后期, 你可以在公共请求方法内任意更换其他的网络请求工具,切换成本小
 */

#pragma mark - 请求的公共方法

+ (NSURLSessionTask *)requestWithFunction:(NSString *)function parameters:(NSDictionary *)parameter class:(__unsafe_unretained Class)model success:(SARequestSuccess)success failure:(SARequestFailure)failure {
    
    NSMutableDictionary *tempParam = [NSMutableDictionary dictionaryWithDictionary:parameter];
    if ([UserManager manager].user.token) {
        [tempParam setObject:[UserManager manager].user.token forKey:@"token"];
    }
    NSMutableDictionary *params = @{@"function": function,
                                    @"data"    : tempParam}.mutableCopy;
    // 生成sign
    NSString *sign = [RequestSign signCreater:params];
    [params setObject:sign forKey:@"sign"];
    // aes加密
    NSString *jsonString = [params JSONString];
    NSString *encrypt = aesEncryptString(jsonString, accessKey);
    
    NSData *bodyData = [[NSString stringWithFormat:@"data=%@",encrypt] dataUsingEncoding:NSUTF8StringEncoding];//把bodyString转换为NSData数据
    NSURL *serverUrl = [NSURL URLWithString:kBaseURL];//获取到服务器的url地址
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serverUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];//请求这个地址， timeoutInterval:10 设置为10s超时：请求时间超过10s会被认为连接不上，连接超时
    [request setHTTPMethod:@"POST"];//POST请求
    [request setHTTPBody:bodyData];//body 数据
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSString *decryptString = aesDecryptString(dataString, accessKey);
                
                id res = [decryptString objectFromJSONString];
                [self handleResultCode:res complete:^(NSInteger resultCode, NSError *error) {
                    if (resultCode == 0) {
                        [self handleSucces:res class:model success:success];
                    }else {
                        failure(error);
                    }
                }];
                
            }else {
                failure(error);
            }
        });
    }];
    [dataTask resume];
    return dataTask;
    
    
    // 发起请求
    //    return [PPNetworkHelper POST:kBaseURL parameters:@{@"data": encrypt} success:^(id responseObject) {
    //
    //        // 在这里你可以根据项目自定义其他一些重复操作,比如加载页面时候的等待效果, 提醒弹窗....
    //        success(responseObject);
    //
    //    } failure:^(NSError *error) {
    //        // 同上
    //        failure(error);
    //        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    //    }];
}


+ (void)handleSucces:(id)res class:(__unsafe_unretained Class)model success:(SARequestSuccess)success {
    if ([model isSubclassOfClass:[SAModel class]]) {
        
        NSString *node = [[self class] node];
        id object = nil;
        if (![Utils isBlankString:node]) {
            object = res[@"data"][node];
        }else {
            object = res[@"data"];
        }
        
        if ([object isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (id subObject in object) {
                id classModel = [model yy_modelWithDictionary:subObject];
                [tempArray addObject:classModel];
            }
            success(tempArray);
        }else if ([object isKindOfClass:[NSDictionary class]]) {
            id classModel = [model yy_modelWithDictionary:object];
            success(classModel);
        }
    }else {
        success(res[@"data"]);
    }
}


// 返回结果编码：0000-成功，0001-失败，0002-方法未授权，0003-解密错误，0004-报文无效，9999-未知错误
+ (void)handleResultCode:(id)res complete:(void(^)(NSInteger resultCode, NSError *error))complete {
    
    if ([res isKindOfClass:[NSDictionary class]]) {
        NSInteger resultCode = [res[@"resultCode"] integerValue];
        if (resultCode == 0) {
            complete(0, nil);
        }else {
            NSString *msg = res[@"msg"];
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: msg};
            NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:resultCode userInfo:userInfo];
            complete(resultCode, error);
        }
    }
}

@end
