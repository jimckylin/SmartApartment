//
//  HotelViewModel.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/2.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotelDetail.h"
#import "RoomConfig.h"

@class StoreEvaluateList;

@interface HotelViewModel : NSObject

@property (nonatomic, strong) HotelDetail *hotelDetail;
@property (nonatomic, strong) RoomConfig  *roomConfig;
@property (nonatomic, strong) NSMutableArray *storeEvaluateArr;

/* 选择公寓
 * @param area 地区
 * @param storeName 包括：位置、品牌、公寓名称
 * @param checkInTime 入住时间，精确到天，格式：1900-09-11
 * @param checkOutTime 离店时间，精确到天，格式：1900-09-11
 * @param checkInRoomType 入住房类型（0-天房，1-钟房）
 */
- (void)requestSelectApartment:(NSString *)storeId
                     storeName:(NSString *)storeName
                   checkInTime:(NSString *)checkInTime
                  checkOutTime:(NSString *)checkOutTime
                      complete:(void(^)(HotelDetail *hotelDetail))complete;


/* 公寓评价列表
 * @param storeId 门店id
 */
- (void)requestStoreEvaluate:(NSString *)storeId
                      complete:(void(^)(NSArray *evaluateArr))complete;

/* 标准房间、豪华房间配置
 * @param roomTypeId 房型ID
 */
- (void)requestRoomConfigure:(NSString *)roomTypeId
                    complete:(void(^)(RoomConfig *roomConfig))complete;

/* 提交订单
 * @param token
 * @param storeId 门店id
 * @param roomTypeId 房型ID
 * @param cardNo 卡号
 * @param checkInRoomType 入住房类型（0-天房，1-钟房）
 * @param name 入住人
 * @param mobilePhone 手机号码
 * @param checkInTime 入住时间，精确到天，格式：1900-09-11
 * @param checkOutTime 离店时间，精确到天，格式：1900-09-11
 * @param arriveTime 到达时间，精确到分，格式：1900-09-11 13:23
 * @param remark 备注
 * @param breakfastId 早餐ID
 * @param breakfastNum 早餐份数
 * @param fivePieceId 五件套ID
 * @param aromaId 香气ID
 * @param roomLayoutId 房间布置ID
 * @param wineId 酒水Id
 */
- (void)requestSubmitOrder:(NSString *)storeId
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
                    complete:(void(^)(NSDictionary *resp))complete;

@end
