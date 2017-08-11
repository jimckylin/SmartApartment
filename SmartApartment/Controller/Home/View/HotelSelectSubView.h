//
//  HotelSelectSubView.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/11.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeEnum.h"

@protocol HotelSelectViewDelegate <NSObject>

- (void)hotelSelectViewDidClickBtn:(HotelSelectBtnType)type roomType:(HotelRoomType)roomType;

@end


@interface HotelSelectSubView : UIView

@property (nonatomic, assign) HotelRoomType roomType; // 房型
@property (nonatomic, weak) id<HotelSelectViewDelegate> deletegate;

- (instancetype)initWithFrame:(CGRect)frame  roomType:(HotelRoomType)roomType;

@end
