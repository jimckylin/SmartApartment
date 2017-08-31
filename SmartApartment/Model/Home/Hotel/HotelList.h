//
//  HotelList.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/1.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAModel.h"

@interface HotelList : SAModel

@property (nonatomic, copy)  NSString *area;                  // 地区
@property (nonatomic, copy)  NSString *storeNum;              // 公寓数量
@property (nonatomic, copy)  NSString *storeId;               // 公寓ID
@property (nonatomic, copy)  NSString *storeName;             // 公寓名称
@property (nonatomic, copy)  NSString *storeScore;            // 公寓评分：等级为不错（0-4.0）、很好（4.0-4.3）、非常好（4.3-4.5）、超级棒（4.6-5.0）

@property (nonatomic, copy)  NSString *storeImage;            // 公寓图片，URL地址
@property (nonatomic, copy)  NSString *storeRoomMinPrice;     // 公寓天房最低价格
@property (nonatomic, strong) NSArray *storeDevice;           // 门店设施：有线上网;电视,多个设施以分号隔开
@property (nonatomic, strong) NSArray *storePayment;          // 门店支付方式：微信;支付宝;信用住，多个支付方式以分号隔开
@property (nonatomic, copy)  NSString *coordinate;            // 经纬度，格式:X,Y

@property (nonatomic, copy)  NSString *address;               // 地址
@property (nonatomic, copy)  NSString *phone;                 // 电话
@property (nonatomic, copy)  NSString *storeRemark;           // 门店介绍

@end
