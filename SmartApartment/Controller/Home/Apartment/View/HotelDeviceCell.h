//
//  HotelConfigCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/28.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Hotel;

@interface HotelDeviceCell : UITableViewCell

@property (nonatomic, strong) Hotel *hotel;
+ (CGFloat)getCellHeight:(Hotel *)hotel;

@end
