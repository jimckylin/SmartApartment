//
//  HotelConfigItemCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelConfigCell.h"
@class Aroma, Breakfast, FivePiece, RoomLayout, Wine;

@protocol HotelConfigItemCellDelegate <NSObject>

- (void)hotelConfigItemCellTapImageDidSelectedIndex:(NSInteger)index
                                          configTpe:(HotelConfigType)configType
                                               view:(UIView *)view;

@end


@interface HotelConfigItemCell : UIView

@property (nonatomic, strong) Aroma *aroma;            // 香气
@property (nonatomic, strong) Breakfast *breakfast;    // 早餐
@property (nonatomic, strong) FivePiece *fivePiece;    // 五件套
@property (nonatomic, strong) RoomLayout *roomLayout;  // 房间布局
@property (nonatomic, strong) Wine *wine;              // 酒水

@property (nonatomic, assign) HotelConfigType configType;

@property (nonatomic, assign) id<HotelConfigItemCellDelegate> delegate;

@property (nonatomic, copy) void(^didSelectedBreakfastConfigNum)(Breakfast *breakfast, NSInteger num);
@property (nonatomic, copy) void(^didSelectedWineConfigNum)(Wine *wine, NSInteger num);
@property (nonatomic, copy) void(^didChangeSelectedBtnStatus)(NSInteger index, BOOL selected, NSInteger num);

- (void)setSelectedBtnStatus:(BOOL)selected;

@end
