//
//  SAHttpRequest.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 请求成功的block
 
 @param info     返回信息
 @param response 响应体数据
 */
typedef void(^PPRequestSuccess)(id response);
/**
 请求失败的block
 
 @param extInfo 扩展信息
 */
typedef void(^PPRequestFailure)(NSError *error);


@interface SAHttpRequest : NSObject

+ (NSURLSessionTask *)requestWithFuncion:(NSString *)function  params:(id)parameters success:(PPRequestSuccess)success failure:(PPRequestFailure)failure;

@end
