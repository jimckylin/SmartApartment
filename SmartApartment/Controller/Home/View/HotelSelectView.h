//
//  HotelSelectView.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/7.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HotelSelectBtnType) {
    
    HotelSelectBtnTypeAlldayRoom = 1000,   // 全日房
    HotelSelectBtnTypeHoursRoom,    // 钟点房
    HotelSelectBtnTypeCitySelect,   // 城市选择
    HotelSelectBtnTypeLocate,       // 定位
    HotelSelectBtnTypeLiveDate,     // 入住时间
    HotelSelectBtnTypeLeaveDate,    // 离店时间
    HotelSelectBtnTypeSearchHotel,  // 查找酒店
};

@protocol HotelSelectView <NSObject>

- (void)hotelSelectViewDidClickBtn:(HotelSelectBtnType)type;

@end


@interface HotelSelectView : UIView

@end
