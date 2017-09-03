//
//  HotelDetailMapCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class Hotel;

@interface HotelDetailMapCell : UITableViewCell

@property (nonatomic, copy) void(^mapViewDidClickBlock)(void);

- (void)setMapCenterCoordinate:(NSString *)lat lon:(NSString *)lon;
@property (nonatomic, strong) Hotel *hotel;

@end
