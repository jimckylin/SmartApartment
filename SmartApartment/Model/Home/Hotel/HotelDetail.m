//
//  HotelDetail.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/2.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetail.h"
#import <YYModel/NSObject+YYModel.h>

@interface HotelDetail ()<YYModel>

@end

@implementation HotelDetail


+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"dayRoomList" : [DayRoom class],
             @"hourRoomList" : [HourRoom class],
             @"customerList" : [StoreEvaluate class]
             };
}

@end
