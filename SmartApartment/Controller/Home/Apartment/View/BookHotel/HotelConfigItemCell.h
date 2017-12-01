//
//  HotelConfigItemCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Aroma, Breakfast, FivePiece, RoomLayout, Wine;

@interface HotelConfigItemCell : UICollectionViewCell

@property (nonatomic, strong) Aroma *aroma;            // 香气
@property (nonatomic, strong) Breakfast *breakfast;    // 早餐
@property (nonatomic, strong) FivePiece *fivePiece;    // 五件套
@property (nonatomic, strong) RoomLayout *roomLayout;  // 房间布局
@property (nonatomic, strong) Wine *wine;              // 酒水

@property (nonatomic, copy) void(^didSelectedBreakfastNum)(NSInteger num);

- (void)setCellSelected:(BOOL)selected;

@end
