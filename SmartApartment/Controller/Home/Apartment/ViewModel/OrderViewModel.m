//
//  OrderViewModel.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/5.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "OrderViewModel.h"


@implementation OrderViewModel

- (void)requestOrderInfo:(NSString *)orderNo complete:(void (^)(OrderDetail *))complete {
    
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:orderNo      forKey:@"orderNo"];
    [dict cwgj_setObject:token        forKey:@"token"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"orderInfo" params:dict class:[OrderDetail class] success:^(id response) {
        
        if (complete) {
            complete(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestGetCurrTripComplete:(void (^)(NSMutableArray *))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:username     forKey:@"username"];
    [dict cwgj_setObject:token        forKey:@"token"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"getCurrTrip" params:dict class:[TripOrder class] success:^(id response) {
        
        [MBProgressHUD cwgj_hideHUD];
        self.tripOrderList = response;
        if (complete) {
            complete(response);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestGetHistoryTripPageNum:(NSInteger)pageNum
                            pageSize:(NSInteger)pageSize
                            complete:(void (^)(NSArray *))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:username     forKey:@"username"];
    [dict cwgj_setObject:token        forKey:@"token"];
    [dict cwgj_setObject:[NSString stringWithFormat:@"%zd", pageNum]    forKey:@"pageNum"];
    [dict cwgj_setObject:[NSString stringWithFormat:@"%zd", pageSize]   forKey:@"pageSize"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"historyTrip" params:dict class:[TripOrder class] success:^(id response) {
        
        self.tripOrderList = response;
        if (complete) {
            complete(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestCheckoutRoom:(NSString *)orderNo complete:(void (^)(BOOL))complete {
    
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:token          forKey:@"token"];
    [dict cwgj_setObject:orderNo        forKey:@"orderNo"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"checkOutRoom" params:dict class:nil success:^(id response) {
        
        if (complete) {
            complete(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestCancelOrder:(NSString *)orderNo
              refundReason:(NSString *)refundReason
                  complete:(void (^)(BOOL))complete {
    
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:token          forKey:@"token"];
    [dict cwgj_setObject:orderNo        forKey:@"orderNo"];
    [dict cwgj_setObject:refundReason   forKey:@"refundReason"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"historyTrip" params:dict class:nil success:^(id response) {
        
        if (complete) {
            complete(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestDelHistoryTrip:(NSString *)orderNo complete:(void (^)(BOOL))complete {
    
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:token          forKey:@"token"];
    [dict cwgj_setObject:orderNo        forKey:@"orderNo"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"delHistoryTrip" params:dict class:nil success:^(id response) {
        
        if (complete) {
            complete(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}


- (void)requestStoreOrderPageNum:(NSInteger)pageNum
                        pageSize:(NSInteger)pageSize
                        complete:(void (^)(NSArray *))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:username     forKey:@"username"];
    [dict cwgj_setObject:token        forKey:@"token"];
    [dict cwgj_setObject:[NSString stringWithFormat:@"%zd", pageNum]    forKey:@"pageNum"];
    [dict cwgj_setObject:[NSString stringWithFormat:@"%zd", pageSize]   forKey:@"pageSize"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"storeOrder" params:dict class:[TripOrder class] success:^(id response) {
        
        self.tripOrderList = response;
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
