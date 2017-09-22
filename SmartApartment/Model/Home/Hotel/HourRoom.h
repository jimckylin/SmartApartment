//
//  HourRoom.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/2.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HourRoom : NSObject

@property (nonatomic, strong) NSArray *bedNum;               // 床数
@property (nonatomic, strong) NSArray *hourNum;              // 体验房几个小时
@property (nonatomic, copy)  NSString *liveNum;              // 最大入住人数
@property (nonatomic, copy)  NSString *roomNum;              // 房型剩余房间数量，展示副标题条件是房间低于5间展示出来，显示是 ：“最后4间，预定加速哦！”
@property (nonatomic, copy)  NSString *roomPrice;            // 房型价格，单位元
@property (nonatomic, copy)  NSString *roomDeposit;          // 房间押金，单位元
@property (nonatomic, copy)  NSString *roomTypeName;         // 房型名称
@property (nonatomic, copy)  NSString *roomTypeId;           // 房型ID
@property (nonatomic, strong) NSArray *roomTypeImageList;    // 房间图片
@property (nonatomic, copy)  NSString *roomRisePrice;        // 房间涨的价格，单位元，是周五、周六才会加上去

@property (nonatomic, copy) NSString * customerTotalMoney;   // 消费总价包括：房费+押金

@end
