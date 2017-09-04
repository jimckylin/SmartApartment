//
//  Breakfast.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "Breakfast.h"
#import <YYModel/NSObject+YYModel.h>

@interface Breakfast ()<YYModel>

@end

@implementation Breakfast

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"breakfastId":@"id"};
}

@end
