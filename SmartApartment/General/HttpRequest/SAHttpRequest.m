//
//  SAHttpRequest.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAHttpRequest.h"
#import "PPNetworkHelper.h"
#import "SAModel.h"


@implementation SAHttpRequest


+ (NSURLSessionTask *)requestWithFuncion:(NSString *)function  params:(id)parameters class:(__unsafe_unretained Class)model success:(SARequestSuccess)success failure:(SARequestFailure)failure {
    
    
    if (model != nil) {
        return [[model class] requestWithFunction:function parameters:parameters class:model success:success failure:failure];
    }else {
        return [SAModel requestWithFunction:function parameters:parameters class:model success:success failure:failure];
    }
    
}




@end
