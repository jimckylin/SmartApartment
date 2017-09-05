//
//  OrderDetailView.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderDetail;

typedef NS_ENUM(NSInteger, OrderDetailViewBtnType) {
    
    OrderDetailViewBtnTypePay = 123,    // 去支付
    OrderDetailViewBtnTypeCancel,       // 取消
};

@interface OrderDetailView : UIView

@property (nonatomic, copy) void(^OrderDetailViewBlock)(OrderDetailViewBtnType type);
@property (nonatomic, strong) OrderDetail *orderDetail;

@end
