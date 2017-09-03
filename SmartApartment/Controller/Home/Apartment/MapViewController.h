//
//  MapViewController.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/16.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ParentViewController.h"
@class Hotel;

@interface MapViewController : ParentViewController

@property (nonatomic, strong) Hotel *hotel;
- (void)setMapCenterCoordinate:(NSString *)lat lon:(NSString *)lon;

@end
