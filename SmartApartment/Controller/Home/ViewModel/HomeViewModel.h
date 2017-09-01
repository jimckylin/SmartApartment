//
//  HomeViewModel.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/16.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotelList.h"

@interface HomeViewModel : NSObject

@property (nonatomic, strong) HotelList *hotelList;

- (void)requestGetTopAd:(void(^)(NSArray *))getTopBlock;


/* *
 * @param area 地区
 * @param storeName 包括：位置、品牌、公寓名称
 * @param checkInTime 入住时间，精确到天，格式：1900-09-11
 * @param checkOutTime 离店时间，精确到天，格式：1900-09-11
 * @param checkInRoomType 入住房类型（0-天房，1-钟房）
 */
- (void)requestQueryApartment:(NSString *)area
                     storeName:(NSString *)storeName
                   checkInTime:(NSString *)checkInTime
                  checkOutTime:(NSString *)checkOutTime
               checkInRoomType:(NSString *)checkInRoomType
                      complete:(void(^)(NSArray *))complete;

@end
