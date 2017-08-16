//
//  HotelDetailMapCell.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailMapCell.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface HotelDetailMapCell ()

@property(nonatomic, strong) BMKMapView *mapView;

@end

@implementation HotelDetailMapCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self initSubView];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)initSubView {
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    _mapView = [BMKMapView new];
    _mapView.zoomLevel = 18;
    [bgView addSubview:_mapView];
    [_mapView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, -80, 0, -80)];
    
    bgView.layer.cornerRadius = 6;
    bgView.layer.masksToBounds = YES;
    _mapView.layer.cornerRadius = 6;
    _mapView.layer.masksToBounds = YES;
}


- (void)setMapCenterCoordinate:(NSString *)lat lon:(NSString *)lon {
    
    CLLocationCoordinate2D coor;
    coor.latitude = [lat doubleValue];
    coor.longitude = [lon doubleValue];
    _mapView.centerCoordinate = coor;
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coor;
    //annotation.title = @"这里是北京";
    [_mapView addAnnotation:annotation];
}



- (void)updateConstraints {
    
    
    [super updateConstraints];
}


@end
