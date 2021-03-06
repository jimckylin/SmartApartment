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
                evaluateType:(NSInteger)evaluateType
                     pageNum:(NSInteger)pageNum
                    pageSize:(NSInteger)pageSize
                    complete:(void (^)(StoreEvaluateList *storeEvaluateList))complete {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:storeId          forKey:@"storeId"];
    [param setObject:@(evaluateType)  forKey:@"evaluateType"];
    [param setObject:@(pageNum)       forKey:@"pageNum"];
    [param setObject:@(pageSize)      forKey:@"pageSize"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"storeEvaluate" params:param class:[StoreEvaluateList class] success:^(id response) {
        
        self.storeEvaluateList = response;
        if (complete) {
            complete(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}


- (void)requestRoomConfigure:(NSString *)roomTypeId
             checkInRoomType:(NSString *)checkInRoomType
                    complete:(void (^)(RoomConfig *))complete {
    
    NSDictionary *param = @{@"roomTypeId": roomTypeId , @"checkInRoomType": checkInRoomType};
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"getSelfConfig" params:param class:[RoomConfig class] success:^(id response) {
        
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
                   wineId:(NSString *)wineId
                  wineNum:(NSString *)wineNum
                 complete:(void (^)(NSDictionary *))complete {
    
    
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
    [dict cwgj_setObject:wineId          forKey:@"wineId"];
    [dict cwgj_setObject:wineNum         forKey:@"wineNum"];
    [dict cwgj_setObject:token           forKey:@"token"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"submitOrder" params:dict class:nil success:^(id response) {
        
        [MBProgressHUD cwgj_hideHUD];
        if (complete) {
            complete(response);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}


- (void)requestConfirmPay:(NSString *)payWay
                 couponId:(NSString *)couponId
                  orderNo:(NSString *)orderNo
                 complete:(void (^)(NSDictionary *orderDict))complete {
    
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:payWay       forKey:@"payWay"];
    [dict cwgj_setObject:couponId     forKey:@"couponId"];
    [dict cwgj_setObject:orderNo      forKey:@"orderNo"];
    [dict cwgj_setObject:token        forKey:@"token"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"confirmPay" params:dict class:nil success:^(id response) {
        
        [MBProgressHUD cwgj_hideHUD];
        if (complete) {
            complete(response);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestGetTimeSolt:(NSString *)checkInRoomType complete:(void (^)(NSArray *dateArray))complete {
    
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:checkInRoomType    forKey:@"checkInRoomType"];
    [dict cwgj_setObject:token              forKey:@"token"];
    
    [SAHttpRequest requestWithFuncion:@"getTimeSolt" params:dict class:nil success:^(id response) {
        
        if (complete) {
            complete(response[@"dateArray"]);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

@end
