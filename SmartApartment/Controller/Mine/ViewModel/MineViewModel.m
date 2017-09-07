//
//  MineViewModel.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MineViewModel.h"

@implementation MineViewModel

- (void)requestGetMyWallet:(void (^)(NSArray *))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:username     forKey:@"username"];
    [dict cwgj_setObject:token        forKey:@"token"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"storeOrder" params:dict class:nil success:^(id response) {
        
        if (complete) {
            complete(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}


- (void)requestGetCouponComplete:(void (^)(NSArray *))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:username     forKey:@"username"];
    [dict cwgj_setObject:token        forKey:@"token"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"storeOrder" params:dict class:nil success:^(id response) {
        
        if (complete) {
            complete(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

@end
