//
//  NSObject+Coding.m
//  CarFriend
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSObject+Coding.h"

@implementation NSObject (Coding)

- (void)initWithNormalCoder:(nullable NSCoder *)aDecoder class:(Class)cl
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(cl, &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        //兼容旧版本，必须把第一个下划线去掉
        key = [self keyHandle:key];
        
        id value = [aDecoder decodeObjectForKey:key];
        
        // 设置到成员变量身上
        if (value) {
            [self setValue:value forKey:key];
        }
    }
    
    free(ivars);
}

- (void)encodeWithNormalCoder:(nullable NSCoder *)aCoder class:(Class)cl
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(cl, &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        //兼容旧版本，必须把第一个下划线去掉
        key = [self keyHandle:key];
        
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    
    free(ivars);
}

- (NSString *)keyHandle:(NSString *)key
{
    NSString *first = [key substringToIndex:1];
    if ([first isEqualToString:@"_"]) {
        key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    }
    return key;
}

@end
