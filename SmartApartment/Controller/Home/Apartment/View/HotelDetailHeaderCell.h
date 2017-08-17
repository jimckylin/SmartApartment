//
//  HotelDetailHeaderCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HotelDetailHeaderCellDelegate <NSObject>

- (void)hotelDetailHeaderCellDidClickBtn;

@end


@interface HotelDetailHeaderCell : UITableViewCell

@property (nonatomic, weak) id<HotelDetailHeaderCellDelegate> delegate;

@end
