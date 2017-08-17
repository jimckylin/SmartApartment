//
//  HotelDetailDateCell.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/17.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeEnum.h"

@protocol HotelDetailDateViewDelegate <NSObject>

- (void)hotelDetailDateViewDidClick:(HotelSelectBtnType)type;

@end

@interface HotelDetailDateView : UIView

@property (nonatomic, assign) HotelRoomType roomType;
@property (nonatomic, assign) id<HotelDetailDateViewDelegate> delegate;

- (instancetype)initWithRoomType:(HotelRoomType)roomType;

@end
