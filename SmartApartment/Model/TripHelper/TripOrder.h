//
//  TripOrder.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/5.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAModel.h"

@interface TripOrder : SAModel

@property (nonatomic, copy)  NSString *checkInTime;             // 入住时间，精确到天，格式：1900-09-11
@property (nonatomic, copy)  NSString *checkOutTime;            // 离店时间，精确到天，格式：1900-09-11
@property (nonatomic, copy)  NSString *consumeSumPrice;         // 消费总价格（房费），单位元
@property (nonatomic, copy)  NSString *roomDepositPrice;        // 房间押金
@property (nonatomic, copy)  NSString *lastCheckInTime;         // 最后到店时间，精确到分，格式：1900-09-11 13:23
@property (nonatomic, copy)  NSString *checkInNo;               // 取卡验证码 入住码
@property (nonatomic, copy)  NSString *orderNo;                 // 订单流水号，由服务端生成使用时间戳+100000随机数
@property (nonatomic, copy)  NSString *orderStatus;             // 订单状态（0-待支付，1-待入住，2-已入住，3-退房申请(退房申请已提交，请等待查房)，4-已查房(物件有损坏请联系前台人员)，5-确认退房(请自助机办理退房)，6-退款成功，7-取消订单,9-已离店)
@property (nonatomic, copy)  NSString *evaluateStatus;          // 评价状态（0-待评论，1-已评论)

@property (nonatomic, copy)  NSString *roomType;                // 房型名称

@property (nonatomic, copy)  NSString *address;                 // 地址
@property (nonatomic, copy)  NSString *storeName;               // 公寓名称
@property (nonatomic, copy)  NSString *storePhone;              // 公寓电话
@property (nonatomic, copy)  NSString *storeImage;              // 公寓图片

@end
