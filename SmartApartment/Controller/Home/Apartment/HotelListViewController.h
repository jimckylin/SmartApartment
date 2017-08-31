//
//  HotelListViewController.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/9.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ParentViewController.h"

@interface HotelListViewController : ParentViewController

@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *checkInTime;
@property (nonatomic, copy) NSString *checkOutTime;
@property (nonatomic, copy) NSString *checkInRoomType;

@end
