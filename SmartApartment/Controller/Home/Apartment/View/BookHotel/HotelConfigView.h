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

- (void)hotelConfigViewDidSelectConfig:(Breakfast *)breakfast
                          breakfastNum:(NSString *)breakfastNum
                           fivePieceId:(FivePiece *)fivePiece
                               aromaId:(Aroma *)aroma
                          roomLayoutId:(RoomLayout *)roomLayout
                                wineId:(Wine *)wine;
@end

@interface HotelConfigView : UIView

@property (nonatomic, strong) RoomConfig *roomConfig;
@property (nonatomic, weak) id<HotelConfigViewDelete> delegate;

- (void)show;
- (void)hide;

@end
