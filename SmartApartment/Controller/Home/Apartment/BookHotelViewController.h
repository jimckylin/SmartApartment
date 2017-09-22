//
//  BookHotelViewController.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ParentViewController.h"
@class Hotel, HotelDetail;

@interface BookHotelViewController : ParentViewController

@property (nonatomic, strong) Hotel *hotel;

@property (nonatomic, copy) NSString *checkInTime;
@property (nonatomic, copy) NSString *checkOutTime;


@property (nonatomic, copy) NSString *roomPrice;       // 房间价格
@property (nonatomic, copy) NSString *roomDeposit;     // 房间押金
@property (nonatomic, copy) NSString *roomRisePrice;   // 房间涨的价格，单位元，是周五、周六才会加上去

@property (nonatomic, copy) NSString *roomTypeId;      // 房型Id
@property (nonatomic, copy) NSString *roomTypeName;    // 房型名字
@property (nonatomic, copy) NSString *checkInRoomType; // 入住房类型（0-天房，1-钟房）

@end
