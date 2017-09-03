//
//  HotelDetailRoomListCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DayRoom, HourRoom;

@interface HotelDetailRoomListCell : UITableViewCell

@property (nonatomic, strong) DayRoom *dayRoom;
@property (nonatomic, strong) HourRoom *hourRoom;
@property (nonatomic, strong) NSDictionary *roomPriceDic;

@end
