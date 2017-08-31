//
//  NSObject+Coding.h
//  CarFriend
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Coding)

//重写code协议的时候，调用改方法，自动完成所有自动的归档
- (void)initWithNormalCoder:(nullable NSCoder *)aDecoder class:(nullable Class)cl;

- (void)encodeWithNormalCoder:(nullable NSCoder *)aCoder class:(nullable Class)cl;

@end
