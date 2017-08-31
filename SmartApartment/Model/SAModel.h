//
//  SAModel.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 请求成功的block
 
 @param response 响应体数据
 */
typedef void(^SARequestSuccess)(id response);
/**
 请求失败的block
 
 @param error 错误
 */
typedef void(^SARequestFailure)(NSError *error);


@interface SAModel : NSObject

+ (NSString *)node;

+ (NSURLSessionTask *)requestWithFunction:(NSString *)function parameters:(NSDictionary *)parameter class:(__unsafe_unretained Class)model success:(SARequestSuccess)success failure:(SARequestFailure)failure;

@end
