//
//  StoreEvaluateList.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "StoreEvaluateList.h"
#import <YYModel/NSObject+YYModel.h>

@interface StoreEvaluateList ()<YYModel>

@end

@implementation StoreEvaluateList


+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"customerList" : [StoreEvaluate class]
             };
}

@end
