//
//  HotelDetail.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/2.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAModel.h"
#import "StoreEvaluate.h"
#import "DayRoom.h"
#import "HourRoom.h"

@interface HotelDetail : SAModel

@property (nonatomic, copy)  NSString *bespeakTime;             // 预定时间段，格式：06:00-21:00
@property (nonatomic, copy)  NSString *storeScore;              // 公寓评分，等级分为不错（0-4.0）、很好（4.0-4.3）、非常好（4.3-4.5）、超级棒（4.6-5.0）
@property (nonatomic, copy)  NSString *storeRoomHealthScore;    // 公寓房间卫生评分
@property (nonatomic, copy)  NSString *storeEnvironmentScore;   // 公寓周围环境评分
@property (nonatomic, copy)  NSString *storeHotelScore;         // 公寓酒店服务评分
@property (nonatomic, copy)  NSString *storePercent;            // 公寓评分百分比

@property (nonatomic, strong)  NSArray <DayRoom *>*dayRoomList;   // 全天房列表
@property (nonatomic, strong)  NSArray <HourRoom *>*hourRoomList; // 钟点房列表

@property (nonatomic, strong) NSArray <StoreEvaluate *>*customerList;            // 评论列表
@property (nonatomic, copy)  NSString *evaluateTotal;           // 评价总数


@end
