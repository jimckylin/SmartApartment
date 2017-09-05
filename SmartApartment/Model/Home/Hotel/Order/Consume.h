//
//  Consume.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/5.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Consume : NSObject

@property (nonatomic, copy)  NSString *consumeName;            // 消费名称
@property (nonatomic, copy)  NSString *consumeNum;             // 消费数量，只有早餐才展示出来，可以判断大于1数量才展示
@property (nonatomic, copy)  NSString *consumePrice;           // 消费总价格（房费），单位元

@end
