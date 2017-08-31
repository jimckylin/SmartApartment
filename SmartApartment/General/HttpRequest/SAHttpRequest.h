//
//  SAHttpRequest.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SAHttpRequest : NSObject

+ (NSURLSessionTask *)requestWithFuncion:(NSString *)function params:(id)parameters class:(Class)model success:(SARequestSuccess)success failure:(SARequestFailure)failure;

@end
