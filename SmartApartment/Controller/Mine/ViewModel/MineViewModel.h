//
//  MineViewModel.h
//  SmartApartment
//
//  Created by jimcky on 2017/9/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineViewModel : NSObject


/* 我的钱包
 */
- (void)requestGetMyWallet:(void(^)(NSArray *))complete;

/* 获取优惠券
 */
- (void)requestGetCouponComplete:(void(^)(NSArray *))complete;

@end
