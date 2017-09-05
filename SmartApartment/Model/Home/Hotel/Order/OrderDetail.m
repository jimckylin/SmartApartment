//
//  OrderDetail.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/5.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "OrderDetail.h"
#import <YYModel/NSObject+YYModel.h>

@interface OrderDetail ()<YYModel>

@end

@implementation OrderDetail

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"consumeList" : [Consume class],
             };
}

@end
