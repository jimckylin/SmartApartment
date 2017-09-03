//
//  HotelDetailHeaderCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Hotel;

typedef NS_ENUM(NSInteger, HotelDetailHeaderType) {
    
    HotelDetailHeaderTypeHotelDetail = 123,    // 详情
    HotelDetailHeaderTypeTelBtn,               // 电话
};


@protocol HotelDetailHeaderCellDelegate <NSObject>

- (void)hotelDetailHeaderCellDidClickBtn:(HotelDetailHeaderType)type;

@end


@interface HotelDetailHeaderCell : UITableViewCell

@property (nonatomic, weak) id<HotelDetailHeaderCellDelegate> delegate;
@property (nonatomic, strong) Hotel *hotel;

@end
