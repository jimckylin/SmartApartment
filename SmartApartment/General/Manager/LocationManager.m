//
//  LocationManager.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/16.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "LocationManager.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

NSString *const kLocationState = @"State";    // 省
NSString *const kLocationCity = @"City";      // 市
NSString *const kLocationStreet = @"Street";  // 街道
NSString *const kLocationAddress = @"FormattedAddressLines"; // 详情地址（数组类型）


@interface LocationManager ()<BMKLocationServiceDelegate>

@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, copy)   void (^complete)(NSDictionary *);
@end


@implementation LocationManager

+ (LocationManager *)shareManager {
    static LocationManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^ { instance = [[LocationManager alloc] init]; });
    return instance;
}


-(void)startLocate:(void (^)(NSDictionary *))complete {
    
    if (!_locService) {
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
    }
    //启动LocationService
    [_locService startUserLocationService];
    self.complete = complete;
}


#pragma mark - BMKLocationServiceDelegate

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    CLLocationDegrees latitude = userLocation.location.coordinate.latitude;
    CLLocationDegrees longitude = userLocation.location.coordinate.longitude;
    
    if (latitude != 0 && longitude != 0) {
        [_locService stopUserLocationService];
        [self reverseGeocodeLocation:userLocation.location];
    }else {
        [_locService startUserLocationService];
    }
}

- (void)didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"定位失败:%@", [error localizedDescription]);
}


#pragma mark - 逆编码

- (void)reverseGeocodeLocation:(CLLocation *)location {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0 || error) return;
        
        CLPlacemark *pm = [placemarks lastObject];
        if (self.complete) {
            NSLog(@"city: %@\n", pm.addressDictionary[@"City"]);
            NSLog(@"address: %@\n", pm.addressDictionary[@"FormattedAddressLines"]);
            self.complete(pm.addressDictionary);
        }
    }];
}


#pragma mark - 坐标转换

/// 百度坐标转高德坐标
+ (CLLocationCoordinate2D)GCJ02FromBD09:(CLLocationCoordinate2D)coor {
    CLLocationDegrees x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    CLLocationDegrees x = coor.longitude - 0.0065, y = coor.latitude - 0.006;
    CLLocationDegrees z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    CLLocationDegrees theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    CLLocationDegrees gg_lon = z * cos(theta);
    CLLocationDegrees gg_lat = z * sin(theta);
    return CLLocationCoordinate2DMake(gg_lat, gg_lon);
}

// 高德坐标转百度坐标
+ (CLLocationCoordinate2D)BD09FromGCJ02:(CLLocationCoordinate2D)coor {
    CLLocationDegrees x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    CLLocationDegrees x = coor.longitude, y = coor.latitude;
    CLLocationDegrees z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    CLLocationDegrees theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    CLLocationDegrees bd_lon = z * cos(theta) + 0.0065;
    CLLocationDegrees bd_lat = z * sin(theta) + 0.006;
    return CLLocationCoordinate2DMake(bd_lat, bd_lon);
}

@end



const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
//火星转百度坐标
void bd_encrypt(double gg_lat, double gg_lon, double *bd_lat, double *bd_lon)
{
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    *bd_lon = z * cos(theta) + 0.0065;
    *bd_lat = z * sin(theta) + 0.006;
}
//百度坐标转火星
void bd_decrypt(double bd_lat, double bd_lon, double *gg_lat, double *gg_lon)
{
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    *gg_lon = z * cos(theta);
    *gg_lat = z * sin(theta);
}




