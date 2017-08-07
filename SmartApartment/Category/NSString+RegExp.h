//
//  NSString+RegExp.h
//  Fashion
//
//  Created by wuqiang on 14/12/5.
//  Copyright (c) 2014年 com.newbie.circle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegExp)

- (BOOL)isPhoneNumber;
- (BOOL)isNumber;

- (BOOL)isUpcasecharacter;
- (BOOL)isSpecialCharacter;

@end
