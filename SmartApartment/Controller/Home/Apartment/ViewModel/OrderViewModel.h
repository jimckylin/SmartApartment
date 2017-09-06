//
//  OrderViewModel.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/5.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDetail.h"
#import "TripOrder.h"

@interface OrderViewModel : NSObject

@property (nonatomic, strong) OrderDetail *orderDetail;
@property (nonatomic, strong) NSArray <TripOrder *>*tripOrderList;

/* 订单详情
 * @param orderNo 订单流水号，由服务端生成使用时间戳+100000随机数
 */
- (void)requestOrderInfo:(NSString *)orderNo
                complete:(void(^)(OrderDetail *orderDetail))complete;

/* 获取当前行程信息
 * @param username 手机号码/卡号，使用卡号
 */
- (void)requestGetCurrTripComplete:(void(^)(NSMutableArray *tripOrderList))complete;

/* 获取历史行程
 * @param username 手机号码/卡号，使用卡号
 */
- (void)requestGetHistoryTripPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize complete:(void(^)(NSArray *tripOrderList))complete;

/* 公寓订单
 * @param username 手机号码/卡号，使用卡号
 */
- (void)requestStoreOrderPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize complete:(void(^)(NSArray *tripOrderList))complete;

@end
