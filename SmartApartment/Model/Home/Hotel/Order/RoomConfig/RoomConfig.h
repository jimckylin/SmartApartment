//
//  RoomConfig.h
//  SmartApartment
//
//  Created by jimcky on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAModel.h"
#import "Aroma.h"
#import "Breakfast.h"
#import "FivePiece.h"
#import "RoomLayout.h"
#import "Wine.h"

@interface RoomConfig : SAModel

@property (nonatomic, copy) NSString *roomType;  // 房间类型（0-普通房，1-标准房，2-豪华房）
@property (nonatomic, copy) NSString *prompt;    // 提示

@property (nonatomic, strong) NSArray <Aroma *>*aromaList;            // 香气列表
@property (nonatomic, strong) NSArray <Breakfast *>*breakfastList;    // 早餐列表
@property (nonatomic, strong) NSArray <FivePiece *>*fivePieceList;    // 五件套列表
@property (nonatomic, strong) NSArray <RoomLayout *>*roomLayoutList;  // 房间布局列表
@property (nonatomic, strong) NSArray <Wine *>*wineList;              // 酒水列表

@end
