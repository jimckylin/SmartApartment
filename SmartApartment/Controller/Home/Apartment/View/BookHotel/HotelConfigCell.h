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

typedef NS_ENUM(NSInteger, HotelConfigType) {
    
    HotelConfigTypeAroma,
    HotelConfigTypeBreakfast,
    HotelConfigTypeFivePiece,
    HotelConfigTypeRoomLayout,
    HotelConfigTypeWine
};

@protocol HotelConfigCollectionCellDelegate <NSObject>

- (void)hotelConfigCollectionCellDidSelectedConfig:(id)object
                                              nums:(NSArray *)nums
                                        configType:(HotelConfigType)configType;
- (void)hotelConfigCollectionCellUpdateSelectedIndex:(HotelConfigType)configType;
- (void)hotelConfigCollectionCellDidTapImage:(NSArray *)imgUrls
                               selectedIndex:(NSInteger)index
                                        view:(UIView *)view;

@end

@interface HotelConfigCell : UITableViewCell

@property (nonatomic, strong) NSArray <Aroma *>*aromaList;            // 香气列表
@property (nonatomic, strong) NSArray <Breakfast *>*breakfastList;    // 早餐列表
@property (nonatomic, strong) NSArray <FivePiece *>*fivePieceList;    // 五件套列表
@property (nonatomic, strong) NSArray <RoomLayout *>*roomLayoutList;  // 房间布局列表
@property (nonatomic, strong) NSArray <Wine *>*wineList;              // 酒水列表

@property (nonatomic, assign) id<HotelConfigCollectionCellDelegate>delegate;

@property (nonatomic, assign) BOOL      clearAroma;
@property (nonatomic, assign) BOOL      clearBreakfast;
@property (nonatomic, assign) BOOL      clearFivePiece;
@property (nonatomic, assign) BOOL      clearRoomLayout;
@property (nonatomic, assign) BOOL      clearWine;
@property (nonatomic, assign) NSInteger      section;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section;

+ (CGFloat)getCellHeight:(NSArray *)arr;

@end
