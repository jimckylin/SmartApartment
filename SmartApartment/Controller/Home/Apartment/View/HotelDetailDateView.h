//
//  HotelDetailDateCell.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/17.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeEnum.h"
#import "HotelDetail.h"

@protocol HotelDetailDateViewDelegate <NSObject>

- (void)hotelDetailDateViewDidClick:(HotelSelectBtnType)type;

@end

@interface HotelDetailDateView : UIView

@property (nonatomic, assign) id<HotelDetailDateViewDelegate> delegate;
@property (nonatomic, strong) HotelDetail *hotelDetail;
// 是否凌晨房
@property (nonatomic, assign) BOOL beforeDawn;

- (instancetype)initWithRoomType:(HotelRoomType)roomType;
- (void)setDateViewateStr:(NSString *)checkinDateStr checkoutDateStr:(NSString *)checkoutDateStr;

@end
