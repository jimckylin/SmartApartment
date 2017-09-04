//
//  HotelViewModel.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/2.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelViewModel.h"
#import "StoreEvaluateList.h"

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


- (void)requestStoreEvaluate:(NSString *)storeId
                    complete:(void (^)(NSArray *))complete {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:storeId         forKey:@"storeId"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"storeEvaluate" params:param class:[StoreEvaluateList class] success:^(id response) {
        
        [self.storeEvaluateArr addObjectsFromArray:response];
        if (complete) {
            complete(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}


- (void)requestRoomConfigure:(NSString *)roomTypeId complete:(void (^)(RoomConfig *))complete {
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"selectRoom" params:@{@"roomTypeId": roomTypeId} class:[RoomConfig class] success:^(id response) {
        
        self.roomConfig = response;
        if (complete) {
            complete(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}


-(void)requestSubmitOrder:(NSString *)storeId
               roomTypeId:(NSString *)roomTypeId
          checkInRoomType:(NSString *)checkInRoomType
                     name:(NSString *)name
              mobilePhone:(NSString *)mobilePhone
              checkInTime:(NSString *)checkInTime
             checkOutTime:(NSString *)checkOutTime
               arriveTime:(NSString *)arriveTime
                   remark:(NSString *)remark
              breakfastId:(NSString *)breakfastId
             breakfastNum:(NSString *)breakfastNum
              fivePieceId:(NSString *)fivePieceId
                  aromaId:(NSString *)aromaId
             roomLayoutId:(NSString *)roomLayoutId
                   wineId:(NSString *)wineId complete:(void (^)(NSDictionary *))complete {
    
    
    NSString *token = [UserManager manager].user.token;
    NSString *cardNo = [UserManager manager].user.cardNo;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:storeId         forKey:@"storeId"];
    [dict cwgj_setObject:roomTypeId      forKey:@"roomTypeId"];
    [dict cwgj_setObject:cardNo          forKey:@"cardNo"];
    [dict cwgj_setObject:checkInRoomType forKey:@"checkInRoomType"];
    [dict cwgj_setObject:name            forKey:@"name"];
    [dict cwgj_setObject:mobilePhone     forKey:@"mobilePhone"];
    [dict cwgj_setObject:checkInTime     forKey:@"checkInTime"];
    [dict cwgj_setObject:checkOutTime    forKey:@"checkOutTime"];
    [dict cwgj_setObject:arriveTime      forKey:@"arriveTime"];
    [dict cwgj_setObject:remark          forKey:@"remark"];
    [dict cwgj_setObject:breakfastId     forKey:@"breakfastId"];
    [dict cwgj_setObject:breakfastNum    forKey:@"breakfastNum"];
    [dict cwgj_setObject:fivePieceId     forKey:@"fivePieceId"];
    [dict cwgj_setObject:aromaId         forKey:@"aromaId"];
    [dict cwgj_setObject:roomLayoutId    forKey:@"roomLayoutId"];
    [dict cwgj_setObject:token           forKey:@"token"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"submitOrder" params:dict class:nil success:^(id response) {
        
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
