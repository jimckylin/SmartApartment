//
//  MapViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/16.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface MapViewController ()

@property(nonatomic, strong) BMKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    _naviLabel.text = @"地图";
    
    _mapView = [BMKMapView new];
    _mapView.zoomLevel = 18;
    [self.view addSubview:_mapView];
    [_mapView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
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


@end
