//
//  CouponList.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/9.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAModel.h"

@interface CouponList : SAModel

@property(nonatomic, copy) NSString *couponId;          // 优惠券ID
@property(nonatomic, copy) NSString *couponMoney;       // 优惠金额
@property(nonatomic, copy) NSString *couponName;        // 优惠券名称
@property(nonatomic, copy) NSString *useStatus;         // 使用状态（0-已使用 ，1-未使用，2-已过期）
@property(nonatomic, copy) NSString *validDate;         // 有效时间，精确到天，格式：1900-09-11

@end
