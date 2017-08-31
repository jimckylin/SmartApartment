//
//  User.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "User.h"
#import "NSObject+Coding.h"

#define kUserKey @"userModel"

@implementation User


#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self encodeWithNormalCoder:aCoder class:[User class]];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self){
        [self initWithNormalCoder:aDecoder class:[User class]];
    }
    return self;
}


@end
