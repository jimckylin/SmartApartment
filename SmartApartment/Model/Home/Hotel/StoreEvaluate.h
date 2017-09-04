//
//  StoreEvaluate.h
//  SmartApartment
//
//  Created by jimcky on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAModel.h"

@interface StoreEvaluate : NSObject

@property (nonatomic, copy)  NSString *username;                 // 匿名用户
@property (nonatomic, copy)  NSString *customerEvaluate;         // 客户评价
@property (nonatomic, copy)  NSString *storeEvaluate;            // 门店评价
@property (nonatomic, copy)  NSString *customerScore;            // 客户评分,等级分为（0-2）差评，（2-4）中评，好评（4-5）好评
@property (nonatomic, copy)  NSString *evaluateDate;             // 客户评价时间，精确到天，格式：1900-09-11

@end
