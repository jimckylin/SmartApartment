//
//  ActivityViewModel.h
//  SmartApartment
//
//  Created by jimcky on 2017/9/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activity.h"

@interface ActivityViewModel : NSObject

@property (nonatomic, strong) NSArray *activityArr;

/* 获取活动列表
 */
- (void)requestGetActivityComplete:(void(^)(NSArray *activityArr))complete;

@end
