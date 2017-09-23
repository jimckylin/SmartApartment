//
//  OrderDetailHeaderView.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/23.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderDetail;

@protocol OrderDetailHeaderViewDelegate <NSObject>

- (void)orderDetailHeaderViewUpdateHeight:(CGFloat)height;

@end

@interface OrderDetailHeaderView : UIView

@property (nonatomic, strong) OrderDetail *orderDetail;
@property (nonatomic, assign) id <OrderDetailHeaderViewDelegate> delegate;

@end
