//
//  HotelList.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/1.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelList.h"
#import "Hotel.h"
#import <YYModel/NSObject+YYModel.h>

@interface HotelList ()<YYModel>

@end

@implementation HotelList

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"storeList" : [Hotel class]
             };
}

@end
