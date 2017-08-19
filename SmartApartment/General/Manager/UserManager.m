//
//  UserManager.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (instancetype)manager {
    
    static UserManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^ { instance = [[UserManager alloc] init]; });
    return instance;
}


- (void)setIsLogin:(BOOL)isLogin {
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df setObject:@(isLogin) forKey:@"isLogin"];
    [df synchronize];
}

- (BOOL)isLogin {
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    BOOL login = [[df objectForKey:@"isLogin"] boolValue];
    return login;
}

@end
