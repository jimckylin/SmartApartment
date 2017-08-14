//
//  HotelListHeaderView.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/14.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HotelListHeaderBtnType) {
    
    HotelListHeaderBtnTypeBack = 1232,    // 返回
    HotelListHeaderBtnTypeCity,           // 城市
    HotelListHeaderBtnTypeDate,           // 日期
};

@protocol HotelListHeaderViewDelegate <NSObject>

- (void)hotelListHeaderViewDidClickBtn:(HotelListHeaderBtnType)type;

@end



@interface HotelListHeaderView : UIView

@property (nonatomic, weak) id<HotelListHeaderViewDelegate> delegate;
- (void)relayoutHeaderView:(UIScrollView *)scrollView;

@end
