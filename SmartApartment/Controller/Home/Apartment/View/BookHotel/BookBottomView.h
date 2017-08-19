//
//  BookBottomView.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HotelBookBtnType) {
    
    HotelSelectBtnTypeDetail = 1000,   // 明细
    HotelSelectBtnTypeBook,            // 确认预订
};

@protocol BookBottomViewDelegate <NSObject>

- (void)bookBottomViewDickBtn:(HotelBookBtnType)type;
@end

@interface BookBottomView : UIView

@property (nonatomic, weak) id<BookBottomViewDelegate> delegate;

@end
