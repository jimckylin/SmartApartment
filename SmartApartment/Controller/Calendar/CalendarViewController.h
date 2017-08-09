//
//  CalendarViewController.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/9.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ParentViewController.h"

@class ZYCalendarManager;

@interface CalendarViewController : ParentViewController

@property (nonatomic, copy) void(^calendarDateBlock)(ZYCalendarManager *manager, NSDate *dayDate);

@end
