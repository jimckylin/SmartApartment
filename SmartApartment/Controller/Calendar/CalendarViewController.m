//
//  CalendarViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/9.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "CalendarViewController.h"
#import "ZYCalendarView.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    
    _naviLabel.text = @"选择日期";
    
    UIView *weekTitlesView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.size.width, 64)];
    [self.view addSubview:weekTitlesView];
    CGFloat weekW = self.view.size.width/7;
    NSArray *titles = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] initWithFrame:CGRectMake(i*weekW, 20, weekW, 44)];
        week.textAlignment = NSTextAlignmentCenter;
        [weekTitlesView addSubview:week];
        week.text = titles[i];
    }
    
    ZYCalendarView *view = [[ZYCalendarView alloc] initWithFrame:CGRectMake(0, 128, self.view.frame.size.width, self.view.frame.size.height-128)];
    // 不可以点击已经过去的日期
    view.manager.canSelectPastDays = false;
    // 可以选择时间段
    view.manager.selectionType = ZYCalendarSelectionTypeRange;
    // 设置被选中颜色
    // view.manager.selectedBackgroundColor = [UIColor orangeColor];
    // 设置当前日期 请在所有参数设置完之后设置日期
    view.date = [NSDate date];
    
    __WeakObj(self)
    view.dayViewBlock = ^(ZYCalendarManager *manager, NSDate *dayDate) {
        
        if (selfWeak.calendarDateBlock) {
            selfWeak.calendarDateBlock(manager, dayDate);
        }
        if ([manager.selectedDateArray count] > 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NavManager shareInstance] returnToFrontView:YES];
            });
        }
    };
    [self.view addSubview:view];
}


@end
