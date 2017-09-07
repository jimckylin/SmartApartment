//
//  HomeViewModel.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/16.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HomeViewModel.h"
#import "LocationManager.h"
#import "Activity.h"


@implementation HomeViewModel

- (void)requestGetTopAd:(void (^)(NSArray *))getTopBlock {
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"getActivity" params:nil class:[Activity class] success:^(id response) {
        if (getTopBlock) { 
            getTopBlock(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestQueryApartment:(NSString *)area
                     storeName:(NSString *)storeName
                   checkInTime:(NSString *)checkInTime
                  checkOutTime:(NSString *)checkOutTime
               checkInRoomType:(NSString *)checkInRoomType
                     complete:(void (^)(NSArray *))complete {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:area            forKey:@"area"];
    if (storeName) {
        [param setObject:storeName   forKey:@"storeName"];
    }
    [param setObject:checkInTime     forKey:@"checkInTime"];
    [param setObject:checkOutTime    forKey:@"checkOutTime"];
    [param setObject:checkInRoomType forKey:@"checkInRoomType"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"queryStore" params:param class:[HotelList class] success:^(id response) {
        
        self.hotelList = response;
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
