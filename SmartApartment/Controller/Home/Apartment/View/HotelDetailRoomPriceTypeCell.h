//
//  HotelDetailRoomPriceTypeCell.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/17.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HotelRoomListBtnType) {
    
    HotelRoomListBtnTypeQustion = 123,    // 问号
    HotelRoomListBtnTypeBook,       // 预订
};

@protocol HotelDetailRoomPriceTypeCellDelegate <NSObject>
- (void)hotelDetailRoomPriceTypeCellDidClickBtn:(HotelRoomListBtnType)type;
@end

@interface HotelDetailRoomPriceTypeCell : UITableViewCell

@property (nonatomic, weak) id<HotelDetailRoomPriceTypeCellDelegate> delegate;

- (void)setDic:(NSDictionary *)dic;

@end