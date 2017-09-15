//
//  StoreEvaluateList.h
//  SmartApartment
//
//  Created by jimcky on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAModel.h"
#import "StoreEvaluate.h"

@interface StoreEvaluateList : SAModel

@property (nonatomic, copy)  NSString *storeScore;               // 公寓评分，等级分为不错（0-4.0）、很好（4.0-4.3）、非常好（4.3-4.5）、超级棒（4.6-5.0）
@property (nonatomic, copy)  NSString *storeRoomHealthScore;     // 公寓房间卫生评分
@property (nonatomic, copy)  NSString *storeEnvironmentScore;    // 公寓周围环境评分
@property (nonatomic, copy)  NSString *storeHotelScore;          // 公寓公寓服务评分
@property (nonatomic, copy)  NSString *storeDeviceScore;         // 公寓设施服务评分
@property (nonatomic, copy)  NSString *storePercent;             // 公寓评分百分比

@property (nonatomic, strong)  NSArray <StoreEvaluate *>*customerList; // 用户评价


@end
