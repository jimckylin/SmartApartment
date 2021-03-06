//
//  BookBottomView.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomConfig.h"

typedef NS_ENUM(NSInteger, HotelBookBtnType) {
    
    HotelSelectBtnTypeDetail = 1000,   // 明细
    HotelSelectBtnTypeBook,            // 确认预订
};

@protocol BookBottomViewDelegate <NSObject>

- (void)bookBottomViewDickBtn:(HotelBookBtnType)type detailShow:(BOOL)show;
@end

@interface BookBottomView : UIView

@property (nonatomic, weak) id<BookBottomViewDelegate> delegate;

- (void)setPriceWithRoomPrice:(NSString *)price
                         days:(NSInteger)days
                  roomDeposit:(NSString *)deposit
                roomRisePrice:(NSString *)risePrice
                   breakfasts:(NSArray <Breakfast *>*)breakfasts
                breakfastNums:(NSArray *)breakfastNums
                    fivePiece:(FivePiece *)fivePiece
                        aroma:(Aroma *)aroma
                   roomLayout:(RoomLayout *)roomLayout
                        wines:(NSArray <Wine *>*)wines
                     wineNums:(NSArray *)wineNums;

@end
