//
//  HotelViewModel.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/2.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotelDetail.h"

@interface HotelViewModel : NSObject

@property (nonatomic, strong) HotelDetail *hotelDetail;

/* *
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


@end
