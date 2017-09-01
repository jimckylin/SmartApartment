//
//  HotelList.h
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/1.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SAModel.h"
@class Hotel;

@interface HotelList : SAModel

@property (nonatomic ,copy) NSString *area;
@property (nonatomic ,strong) NSArray *storeList;
@property (nonatomic ,copy) NSString *storeNum;

@end
