//
//  MineViewModel.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MineViewModel.h"
#import "HotelList.h"
#import "CouponList.h"

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


- (void)requestGetCoupon:(NSString *)roomTypeId
                 storeId:(NSString *)storeId
                complete:(void (^)(NSArray *))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:roomTypeId     forKey:@"roomTypeId"];
    [dict cwgj_setObject:storeId        forKey:@"storeId"];
    [dict cwgj_setObject:username     forKey:@"username"];
    [dict cwgj_setObject:token        forKey:@"token"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"getCoupon" params:dict class:[CouponList class] success:^(id response) {
        
        if (complete) {
            complete(response);
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}


- (void)requestQueryCommonInfo:(void (^)(NSArray *))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:username     forKey:@"username"];
    [dict cwgj_setObject:token        forKey:@"token"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"queryCommonInfo" params:dict class:nil success:^(id response) {
        
        [MBProgressHUD cwgj_hideHUD];
        self.contacList = response[@"contacList"];
        if (complete) {
            complete(response[@"contacList"]);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestSaveCommonInfo:(NSString *)name
                       idType:(NSString *)idType
                         idNo:(NSString *)idNo
                  mobilePhone:(NSString *)mobilePhone
                        email:(NSString *)email
                    checkInNo:(NSString *)checkInNo
                     complete:(void (^)(BOOL isSuccess))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:name     forKey:@"name"];
    [dict cwgj_setObject:username     forKey:@"username"];
    [dict cwgj_setObject:token        forKey:@"token"];
    [dict cwgj_setObject:idType     forKey:@"idType"];
    [dict cwgj_setObject:idNo        forKey:@"idNo"];
    [dict cwgj_setObject:mobilePhone     forKey:@"mobilePhone"];
    [dict cwgj_setObject:email        forKey:@"email"];
    [dict cwgj_setObject:checkInNo     forKey:@"checkInNo"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"saveCommonInfo" params:dict class:nil success:^(id response) {
        
        [MBProgressHUD cwgj_hideHUD];
        if (complete) {
            complete(response);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestCardConsumeDetail:(void (^)(NSArray *))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:username     forKey:@"username"];
    [dict cwgj_setObject:token        forKey:@"token"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"cardConsumeDetail" params:dict class:nil success:^(id response) {
        
        [MBProgressHUD cwgj_hideHUD];
        self.consumeList = response[@"consumeList"];
        if (complete) {
            complete(response[@"consumeList"]);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}


- (void)requestCardRechargeDetail:(void (^)(NSArray *))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:username     forKey:@"username"];
    [dict cwgj_setObject:token        forKey:@"token"];
    
    //[MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"cardRechargeDetail" params:dict class:nil success:^(id response) {
        
        [MBProgressHUD cwgj_hideHUD];
        self.rechargeList = response[@"rechargeList"];
        if (complete) {
            complete(response[@"rechargeList"]);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestRechargePrice:(void (^)(NSArray *))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:username     forKey:@"username"];
    [dict cwgj_setObject:token        forKey:@"token"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"rechargePrice" params:dict class:nil success:^(id response) {
        
        [MBProgressHUD cwgj_hideHUD];
        self.rechargeList = response[@"moneyList"];
        if (complete) {
            complete(response[@"moneyList"]);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestWalletRecharge:(NSString *)payWay
                   rechargeId:(NSString *)rechargerId
                     complete:(void (^)(NSDictionary *))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:payWay        forKey:@"payWay"];
    [dict cwgj_setObject:rechargerId   forKey:@"rechargeId"];
    [dict cwgj_setObject:username      forKey:@"username"];
    [dict cwgj_setObject:token         forKey:@"token"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"walletRecharge" params:dict class:nil success:^(id response) {
        
        [MBProgressHUD cwgj_hideHUD];
        if (complete) {
            complete(response);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestMyReview:(void (^)(HotelList *hotelList))complete {
    
    NSString *username = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:username      forKey:@"username"];
    [dict cwgj_setObject:token         forKey:@"token"];
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"myReview" params:dict class:[HotelList class] success:^(id response) {
        
        [MBProgressHUD cwgj_hideHUD];
        self.hotelList = response;
        if (complete) {
            complete(response);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestSaveUser:(NSString *)headImage
     imageExtensionName:(NSString *)imageExtensionName
                   name:(NSString *)name
              birthDate:(NSString *)birthDate
                 idType:(NSString *)idType
                   idNo:(NSString *)idNo
            mobilePhone:(NSString *)mobilePhone
                  email:(NSString *)email
               complete:(void (^)(User *user))complete {
    
    NSString *cardNo = [UserManager manager].user.cardNo;
    NSString *token = [UserManager manager].user.token;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict cwgj_setObject:cardNo        forKey:@"cardNo"];
    [dict cwgj_setObject:token         forKey:@"token"];
    [dict cwgj_setObject:headImage     forKey:@"headImage"];
    [dict cwgj_setObject:imageExtensionName         forKey:@"imageExtensionName"];
    [dict cwgj_setObject:name          forKey:@"name"];
    [dict cwgj_setObject:birthDate     forKey:@"birthDate"];
    [dict cwgj_setObject:idType        forKey:@"idType"];
    [dict cwgj_setObject:idNo          forKey:@"idNo"];
    [dict cwgj_setObject:mobilePhone      forKey:@"mobilePhone"];
    [dict cwgj_setObject:email         forKey:@"email"];
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"saveUser" params:dict class:[User class] success:^(id response) {
        
        [MBProgressHUD cwgj_hideHUD];
        if (response) {
            [[UserManager manager] saveUser:(User *)response];
            if (complete) {
                complete(response);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccess" object:nil];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];

}


@end
