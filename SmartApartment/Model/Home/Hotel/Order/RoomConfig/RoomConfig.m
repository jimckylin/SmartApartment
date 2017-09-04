//
//  RoomConfig.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "RoomConfig.h"
#import <YYModel/NSObject+YYModel.h>

@interface RoomConfig ()<YYModel>

@end

@implementation RoomConfig

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"aromaList" : [Aroma class],
             @"breakfastList" : [Aroma class],
             @"fivePieceList" : [FivePiece class],
             @"roomLayoutList" : [RoomLayout class],
             @"wineList" : [Wine class]
             };
}

@end
