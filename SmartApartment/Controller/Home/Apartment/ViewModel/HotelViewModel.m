//
//  HotelViewModel.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/2.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelViewModel.h"

@implementation HotelViewModel

- (void)requestSelectApartment:(NSString *)storeId
                     storeName:(NSString *)storeName
                   checkInTime:(NSString *)checkInTime
                  checkOutTime:(NSString *)checkOutTime
                      complete:(void (^)(HotelDetail *))complete {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:storeId         forKey:@"storeId"];
    [param setObject:storeName       forKey:@"storeName"];
    [param setObject:checkInTime     forKey:@"checkInTime"];
    [param setObject:checkOutTime    forKey:@"checkOutTime"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"selecStore" params:param class:[HotelDetail class] success:^(id response) {
        
        self.hotelDetail = response;
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
