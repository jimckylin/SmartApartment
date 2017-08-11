//
//  HomeEnum.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/11.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#ifndef HomeEnum_h
#define HomeEnum_h


typedef NS_ENUM(NSInteger, HotelRoomType) {
    
    HotelRoomTypeAllday = 123,    // 全日房
    HotelRoomTypeTypeHours,       // 钟点房
};

typedef NS_ENUM(NSInteger, HotelSelectBtnType) {
    
    HotelSelectBtnTypeAlldayRoom = 1000,   // 全日房
    HotelSelectBtnTypeHoursRoom,    // 钟点房
    HotelSelectBtnTypeCitySelect,   // 城市选择
    HotelSelectBtnTypeLocate,       // 定位
    HotelSelectBtnTypeLiveDate,     // 入住时间
    HotelSelectBtnTypeLeaveDate,    // 离店时间
    HotelSelectBtnTypeExtraSearch,  // 离店时间
    HotelSelectBtnTypeSearchHotel,  // 查找酒店
};

#endif /* HomeEnum_h */
