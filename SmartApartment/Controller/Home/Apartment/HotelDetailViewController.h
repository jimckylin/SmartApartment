//
//  HotelDetailViewController.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/14.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ParentViewController.h"
#import "Hotel.h"


@interface HotelDetailViewController : ParentViewController

@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *checkInTime;
@property (nonatomic, copy) NSString *checkOutTime;

@property (nonatomic, strong) Hotel *hotel;

@end
