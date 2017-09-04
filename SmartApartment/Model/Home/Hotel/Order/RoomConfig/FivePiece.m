//
//  FivePiece.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "FivePiece.h"
#import <YYModel/NSObject+YYModel.h>

@interface FivePiece ()<YYModel>

@end

@implementation FivePiece

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    
    return @{@"fivePieceId":@"id"};
}

@end
