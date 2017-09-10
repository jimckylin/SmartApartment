//
//  HotelListHeaderView.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/14.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotelList;

typedef NS_ENUM(NSInteger, HotelListHeaderBtnType) {
    
    HotelListHeaderBtnTypeBack = 1232,    // 返回
    HotelListHeaderBtnTypeCity,           // 城市
    HotelListHeaderBtnTypeDate,           // 日期
};

@protocol HotelListHeaderViewDelegate <NSObject>

- (void)hotelListHeaderViewDidClickBtn:(HotelListHeaderBtnType)type;

@end



@interface HotelListHeaderView : UIView

@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, weak) id<HotelListHeaderViewDelegate> delegate;
- (void)relayoutHeaderView:(UIScrollView *)scrollView;

@property (nonatomic, strong) HotelList *hotelList;

- (void)setHeaderViewDate:(NSDate *)checkinDate checkoutDate:(NSDate *)checkoutDate;
- (void)setHeaderViewDateStr:(NSString *)checkinDateStr checkoutDateStr:(NSString *)checkoutDateStr;

@end
