//
//  CouponListCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/23.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponList.h"

@interface CouponListCell : UITableViewCell

@property (nonatomic, assign) BOOL isUse; // 使用优惠券
@property (nonatomic, strong) CouponList *couponList;

@end
