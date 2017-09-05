//
//  NSDictionary+CWGJ.m
//  CWGJCarOwner
//
//  Created by QingGeMac on 2017/5/11.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "NSMutableDictionary+CWGJ.h"

@implementation NSMutableDictionary (CWGJ)

- (void)cwgj_setObject:(id)object forKey:(NSString *)key
{
    if (object && ![Utils isBlankString:object]) {
        [self setValue:object forKey:key];
    }
}


@end
