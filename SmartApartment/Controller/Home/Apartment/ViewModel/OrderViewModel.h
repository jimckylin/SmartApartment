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
- (void)requestGetHistoryTripPageNum:(NSInteger)pageNum
                            pageSize:(NSInteger)pageSize
                            complete:(void(^)(NSArray *tripOrderList))complete;

/* 取消订单
 * @param orderNo 订单流水号
 * @param refundReason 取消原因
 */
- (void)requestCancelOrder:(NSString *)orderNo
              refundReason:(NSString *)refundReason
                  complete:(void(^)(BOOL isCancel))complete;

/* 自助退房
 * @param orderNo 订单流水号
 */
- (void)requestCheckoutRoom:(NSString *)orderNo
                   complete:(void(^)(BOOL isCheckout))complete;

/* 历史行程删除
 * @param orderNo 订单流水号
 */
- (void)requestDelHistoryTrip:(NSString *)orderNo
                  complete:(void(^)(BOOL isDelete))complete;




/* 公寓订单
 * @param orderType 订单类型：0-全部订单，1-待评价
 */
- (void)requestStoreOrderPageNum:(NSInteger)pageNum
                        pageSize:(NSInteger)pageSize
                       orderType:(NSInteger)orderType
                        complete:(void(^)(NSArray *tripOrderList))complete;

/* 行程点评
 * @param orderNo 订单流水号
 * @param roomHealthScore 房间卫生评分
 * @param environmentScore 周围环境评分
 * @param hotelScore 公寓服务评分
 * @param deviceScore 设施服务评分
 * @param customerEvaluate 客户评价
 * @param customerImage 客户上传图片，最多5张，图片都是base64形式上传
 * @param imageExtensionName 图片扩展名，比如：png、jgp
 */
- (void)requestTripReview:(NSString *)orderNo
          roomHealthScore:(CGFloat)roomHealthScore
         environmentScore:(CGFloat)environmentScore
               hotelScore:(CGFloat)hotelScore
              deviceScore:(CGFloat)deviceScore
         customerEvaluate:(NSString *)customerEvaluate
            customerImage:(NSArray *)customerImage
       imageExtensionName:(NSString *)imageExtensionName
                 complete:(void(^)(BOOL isSuccess))complete;

@end
