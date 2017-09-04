//
//  RoomLayout.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "RoomLayout.h"
#import <YYModel/NSObject+YYModel.h>

@interface RoomLayout ()<YYModel>

@end

@implementation RoomLayout

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"roomLayoutId":@"id"};
}

@end
