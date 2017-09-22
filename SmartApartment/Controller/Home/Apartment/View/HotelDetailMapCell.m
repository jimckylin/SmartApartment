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
#import "Hotel.h"

@interface HotelDetailMapCell ()<BMKMapViewDelegate>

@property(nonatomic, strong) BMKMapView *mapView;
@property(nonatomic, strong) UILabel *addressLabel;

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
    _mapView.delegate = self;
    _mapView.zoomLevel = 18;
    [bgView addSubview:_mapView];
    [_mapView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, -80, 0, -80)];
    
    // address label
    UIView *addressBg = [UIView new];
    addressBg.backgroundColor = [UIColor whiteColor];
    [_mapView addSubview:addressBg];
    [addressBg autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 80, 0, 80) excludingEdge:ALEdgeTop];
    [addressBg autoSetDimension:ALDimensionHeight toSize:30];
    
    UIImageView *icon = [UIImageView new];
    icon.image = kImage(@"sale_location_iconiphone");
    icon.contentMode = UIViewContentModeCenter;
    [addressBg addSubview:icon];
    [icon autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0) excludingEdge:ALEdgeRight];
    [icon autoSetDimension:ALDimensionWidth toSize:12];
    
    _addressLabel = [UILabel new];
    _addressLabel.font = [UIFont systemFontOfSize:11];
    _addressLabel.textColor = [UIColor grayColor];
    _addressLabel.text = @"福州市台江区中亭街";
    [addressBg addSubview:_addressLabel];
    [_addressLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 33, 0, 0)];
    
    bgView.layer.cornerRadius = 6;
    bgView.layer.masksToBounds = YES;
    _mapView.layer.cornerRadius = 6;
    _mapView.layer.masksToBounds = YES;
}


- (void)setAddress:(NSString *)address {
    
    _addressLabel.text = address;
}


- (void)setHotel:(Hotel *)hotel {
    
    _addressLabel.text = hotel.address;
    NSArray *coors = [hotel.coordinate componentsSeparatedByString:@","];
    NSString *lat = [coors count] > 0 ? coors[0]: @"";
    NSString *lon = [coors count] > 1 ? coors[1]: @"";
    [self setMapCenterCoordinate:lat lon:lon];
    
    _hotel = hotel;
}


- (void)setMapCenterCoordinate:(NSString *)lat lon:(NSString *)lon {
    
    CLLocationCoordinate2D coor;
    coor.latitude = [lat floatValue];
    coor.longitude = [lon doubleValue];
    _mapView.centerCoordinate = coor;
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coor;
    //annotation.title = @"这里是北京";
    [_mapView addAnnotation:annotation];
}


#pragma mark - BMKMapViewDelegate

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    
    if (self.mapViewDidClickBlock) {
        self.mapViewDidClickBlock();
    }
}


- (void)updateConstraints {
    
    [super updateConstraints];
}


@end
