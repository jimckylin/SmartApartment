//
//  HotelDetailMapCell.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HotelDetailMapCell : UITableViewCell

- (void)setMapCenterCoordinate:(NSString *)lat lon:(NSString *)lon;

@end
