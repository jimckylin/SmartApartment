//
//  UserManager.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) User *user;

+ (instancetype)manager;

- (void)saveUser:(User *)user;
- (void)removeUser;

@end
