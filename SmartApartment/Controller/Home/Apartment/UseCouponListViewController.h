//
//  UseCouponListViewController.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ParentViewController.h"
#import "CouponList.h"

@interface UseCouponListViewController : ParentViewController

@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSString *roomTypeId;

@property (nonatomic, copy) void(^didSelectedCoupon)(CouponList *couponList);

@end
