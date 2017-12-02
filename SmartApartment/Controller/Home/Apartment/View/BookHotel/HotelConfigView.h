//
//  HotelConfigView.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomConfig.h"

@protocol HotelConfigViewDelete <NSObject>

- (void)hotelConfigViewDidSelectConfig:(NSArray <Breakfast *>*)breakfasts
                         breakfastNums:(NSArray *)breakfastNums
                           fivePieceId:(FivePiece *)fivePiece
                               aromaId:(Aroma *)aroma
                          roomLayoutId:(RoomLayout *)roomLayout
                                 wines:(NSArray <Wine *>*)wines
                              wineNums:(NSArray *)wineNums;

- (void)hotelConfigViewDidTapImage:(NSArray *)imgUrls
                     selectedIndex:(NSInteger)index view:(UIView *)view;

@end

@interface HotelConfigView : UIView

@property (nonatomic, strong) RoomConfig *roomConfig;
@property (nonatomic, weak) id<HotelConfigViewDelete> delegate;

- (void)show;
- (void)hide;

@end
