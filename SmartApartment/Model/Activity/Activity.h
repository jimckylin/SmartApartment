//
//  Activity.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAModel.h"

@interface Activity : SAModel

@property(nonatomic, copy) NSString *activityTitle;        // 活动标题
@property(nonatomic, copy) NSString *activitySubTitle;     // 活动副标题

@property(nonatomic, copy) NSString *beginDate;            // 开始时间，以天为单位
@property(nonatomic, copy) NSString *endDate;              // 结束时间，以天为单位
@property(nonatomic, copy) NSString *activityImage;        // 活动图片
@property(nonatomic, copy) NSString *activityUrl;          // 活动URL地址


@end
