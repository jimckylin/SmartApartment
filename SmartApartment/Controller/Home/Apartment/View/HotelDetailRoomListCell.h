//
//  HotelDetailRoomListCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DayRoom, HourRoom, HotelDetailRoomListCell;


@protocol HotelDetailRoomListCellDelegate <NSObject>
- (void)hotelDetailRoomPriceTypeCellDidClickBookBtn:(HotelDetailRoomListCell *)cell;
@end

@interface HotelDetailRoomListCell : UITableViewCell

@property (nonatomic, strong) DayRoom *dayRoom;
@property (nonatomic, strong) HourRoom *hourRoom;
@property (nonatomic, strong) NSDictionary *roomPriceDic;

@property (nonatomic, weak) id<HotelDetailRoomListCellDelegate> delegate;

@end
