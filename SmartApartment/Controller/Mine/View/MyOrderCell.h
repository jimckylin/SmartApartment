//
//  MyOrderCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/22.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripListCell.h"
@class TripOrder;

@protocol MyOrderCellDelegate <NSObject>

- (void)myOrderCellDidClcikBtnType:(TripCellBtnType)btnType order:(TripOrder *)order;
@end


@interface MyOrderCell : UITableViewCell

@property (nonatomic, strong) TripOrder *tripOrder;
@property (nonatomic, assign) id <MyOrderCellDelegate> delegate;

@end
