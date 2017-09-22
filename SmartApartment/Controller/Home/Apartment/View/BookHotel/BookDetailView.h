//
//  BookDetailView.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/27.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomConfig.h"

@interface BookDetailView : UIView


- (void)setCheckInTime:(NSString *)checkInTime
          checkOutTime:(NSString *)checkOutTime
             roomPrice:(NSString *)price
           roomDeposit:(NSString *)deposit
         roomRisePrice:(NSString *)risePrice
             breakfast:(Breakfast *)breakfast
          breakfastNum:(NSString *)breakfastNum
             fivePiece:(FivePiece *)fivePiece
                 aroma:(Aroma *)aroma
            roomLayout:(RoomLayout *)roomLayout
                  wine:(Wine *)wine;

@end
