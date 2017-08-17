//
//  HotelDetailRoomTypeCell.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/17.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeEnum.h"

@protocol HotelDetailRoomTypeCellDelegate <NSObject>

- (void)hotelDetailRoomTypeCellDidClickBtn;
@end


@interface HotelDetailRoomTypeCell : UITableViewCell

@property (nonatomic, assign) id<HotelDetailRoomTypeCellDelegate> delegate;

@end
