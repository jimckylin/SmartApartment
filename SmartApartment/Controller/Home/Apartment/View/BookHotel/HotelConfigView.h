//
//  HotelConfigView.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RoomConfig;

@protocol HotelConfigViewDelete <NSObject>

- (void)hotelConfigViewDidSelectConfig:(NSString *)breakfastId
                          breakfastNum:(NSString *)breakfastNum
                           fivePieceId:(NSString *)fivePieceId
                               aromaId:(NSString *)aromaId
                          roomLayoutId:(NSString *)roomLayoutId
                                wineId:(NSString *)wineId;
@end

@interface HotelConfigView : UIView

@property (nonatomic, strong) RoomConfig *roomConfig;
@property (nonatomic, weak) id<HotelConfigViewDelete> delegate;

- (void)show;
- (void)hide;

@end
