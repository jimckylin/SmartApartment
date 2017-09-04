//
//  Wine.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "Wine.h"
#import <YYModel/NSObject+YYModel.h>

@interface Wine ()<YYModel>

@end

@implementation Wine

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"wineId":@"id"};
}

@end
