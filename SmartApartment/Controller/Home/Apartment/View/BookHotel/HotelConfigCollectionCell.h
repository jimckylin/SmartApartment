//
//  HotelConfigCollectionCell.h
//  SmartApartment
//
//  Created by jimcky on 2017/9/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Aroma.h"
#import "Breakfast.h"
#import "FivePiece.h"
#import "RoomLayout.h"
#import "Wine.h"

@interface HotelConfigCollectionCell : UITableViewCell

@property (nonatomic, strong) NSArray <Aroma *>*aromaList;            // 香气列表
@property (nonatomic, strong) NSArray <Breakfast *>*breakfastList;    // 早餐列表
@property (nonatomic, strong) NSArray <FivePiece *>*fivePieceList;    // 五件套列表
@property (nonatomic, strong) NSArray <RoomLayout *>*roomLayoutList;  // 房间布局列表
@property (nonatomic, strong) NSArray <Wine *>*wineList;              // 酒水列表


+ (CGFloat)getCellHeight:(NSArray *)arr;

@end
