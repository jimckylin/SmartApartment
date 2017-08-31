//
//  UserManager.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "UserManager.h"


NSString *const kUserModelKey = @"kUserModelKey";


@interface UserManager ()

@property (nonatomic, strong) NSUserDefaults *ud;
@end

@implementation UserManager

+ (instancetype)manager {
    static UserManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^ { instance = [[UserManager alloc] init]; });
    return instance;
}

-(id)init {
    self = [super init];
    if (self) {
        self.ud = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (BOOL)isLogin {
    if (self.user.cardNo) {
        return YES;
    }
    return NO;
}

- (User *)user {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[_ud objectForKey:kUserModelKey]];
}

- (void)saveUser:(User *)user {
    
    if (user){
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:user];
        [_ud setObject:data forKey:kUserModelKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)removeUser {
    [_ud removeObjectForKey:kUserModelKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
