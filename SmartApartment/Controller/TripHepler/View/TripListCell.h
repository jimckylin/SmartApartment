//
//  TripListCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripOrder.h"


typedef NS_ENUM(NSInteger, TripCellBtnType) {
    
     TripCellBtnTypeGetCarVerifyCode,          // 取卡验证码
     TripCellBtnTypeCancelOrder,               // 取消订单
     TripCellBtnTypeContinueLiving,            // 续住
     TripCellBtnTypeAutoCheckout,              // 自助退房
     TripCellBtnTypeAppOpenDoor,               // APP开门
     TripCellBtnTypeCommentRoom,               // 点评
     TripCellBtnTypeDeleteOrder,               // 删除订单
     TripCellBtnTypeNone,                      // 未知
};


@protocol TripListCellDelegate <NSObject>

- (void)tripListCellDidClcikBtnType:(TripCellBtnType)btnType order:(TripOrder *)order;

@end

@interface TripListCell : UITableViewCell

@property (nonatomic, copy) void(^tripListCellBlock)(NSInteger tag);
@property (nonatomic, assign) id <TripListCellDelegate> delegate;
@property (nonatomic, strong) TripOrder *tripOrder;

@end
