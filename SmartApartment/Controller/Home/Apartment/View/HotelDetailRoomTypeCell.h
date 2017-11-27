//
//  HotelDetailRoomTypeCell.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/17.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeEnum.h"
@class HotelDetail;

@protocol HotelDetailRoomTypeCellDelegate <NSObject>

- (void)hotelDetailRoomTypeCellDidClickBtn:(HotelRoomType)type;
@end


@interface HotelDetailRoomTypeCell : UITableViewCell

@property (nonatomic, assign) id<HotelDetailRoomTypeCellDelegate> delegate;
@property (nonatomic, strong) HotelDetail *hotelDetail;
// 是否凌晨房
@property (nonatomic, assign) BOOL beforeDawn;

- (void)setDateViewateStr:(NSString *)checkInTime checkoutDateStr:(NSString *)checkOutTime;

@end
