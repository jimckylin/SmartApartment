//
//  LocationManager.h
//  SmartApartment
//
//  Created by jimcky on 2017/8/16.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

NSString *const kLocationState;
NSString *const kLocationCity;
NSString *const kLocationStreet;
NSString *const kLocationAddress;


@interface LocationManager : NSObject

+ (LocationManager *)shareManager;
-(void)startLocate:(void(^)(NSDictionary *addressDic))complete;


/// 百度坐标转高德坐标
+ (CLLocationCoordinate2D)GCJ02FromBD09:(CLLocationCoordinate2D)coor;
// 高德坐标转百度坐标
+ (CLLocationCoordinate2D)BD09FromGCJ02:(CLLocationCoordinate2D)coor;

@end
