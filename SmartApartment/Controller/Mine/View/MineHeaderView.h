//
//  MineHeaderView.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/10.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HeaderEventType) {
    
    HeaderEventTypeProfile = 110,    // 个人资料
    HeaderEventTypeBalance,          // 余额
    HeaderEventTypeCoupon,           // 优惠券
    HeaderEventTypeIntegral,         // 积分
};

@protocol MineHeaderViewDelegate <NSObject>

- (void)mineHeaderViewDidClickEvent:(HeaderEventType)type;

@end


@interface MineHeaderView : UIView

@property (nonatomic, weak) id<MineHeaderViewDelegate> delegate;

- (void)setHeaderViewData;

@end
