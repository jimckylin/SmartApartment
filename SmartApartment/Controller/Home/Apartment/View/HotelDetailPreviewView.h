//
//  HotelDetailPreviewView.h
//  SmartApartment
//
//  Created by jimcky on 2017/11/30.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DayRoom, HourRoom;

@interface HotelDetailPreviewView : UIView

@property (nonatomic, strong) DayRoom *dayRoom;
@property (nonatomic, strong) HourRoom *hourRoom;

- (void)show;
- (void)hide;

@end
