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
#import <MapKit/MapKit.h>
#import "Hotel.h"


@interface MapViewController ()<BMKMapViewDelegate, UIActionSheetDelegate>

@property(nonatomic, assign) CLLocationCoordinate2D coor;
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
    _mapView.delegate = self;
    _mapView.zoomLevel = 18;
    [self.view addSubview:_mapView];
    _mapView.centerCoordinate = self.coor;
    [_mapView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = self.coor;
    annotation.title = _hotel.storeName;
    [_mapView addAnnotation:annotation];
    
    
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navBtn setImage:kImage(@"map_lineiphone") forState:UIControlStateNormal];
    [navBtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navBtn];
    
    [navBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [navBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:25];
    [navBtn autoSetDimensionsToSize:CGSizeMake(99, 95)];
}

- (void)setHotel:(Hotel *)hotel {
    
    NSArray *coors = [hotel.coordinate componentsSeparatedByString:@","];
    NSString *lat = [coors count] > 0 ? coors[0]: @"";
    NSString *lon = [coors count] > 1 ? coors[1]: @"";
    [self setMapCenterCoordinate:lat lon:lon];
    
    _hotel = hotel;
}


- (void)setMapCenterCoordinate:(NSString *)lat lon:(NSString *)lon {
    
    CLLocationCoordinate2D coor;
    coor.latitude = [lat doubleValue];
    coor.longitude = [lon doubleValue];
    self.coor = coor;
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        CGFloat titleWidth = [Utils getContentMaxWidth:annotation.title FontSize:15];
        UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, titleWidth+20, 46)];
        //设置弹出气泡图片
        UIImage *image = [kImage(@"map_landmarkiphone") resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        UIImageView *imageContent = [[UIImageView alloc]initWithImage:image];
        imageContent.frame = CGRectMake(0, 0, popView.width, 39);
        [popView addSubview:imageContent];
        UIImageView *imageBottom = [[UIImageView alloc]initWithImage:kImage(@"map_landmark_lowiphone")];
        imageBottom.contentMode = UIViewContentModeCenter;
        imageBottom.frame = CGRectMake(0, 38, popView.width, 7);
        [popView addSubview:imageBottom];
        
        //自定义显示的内容
        UILabel *title = [[UILabel alloc]initWithFrame:imageContent.bounds];
        title.text = _hotel.storeName;
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        [popView addSubview:title];
        
        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
        //pView.frame = CGRectMake(0, 0, 100, 60);
        newAnnotationView.paopaoView = pView;
        
        return newAnnotationView;
    }
    return nil;
}


#pragma mark - UIButton Action 

- (void)navBtnClick:(id)sender {
    
    UIActionSheet * actionsheet = [[UIActionSheet alloc] initWithTitle:@"请选择地图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"自带地图", nil];
    
    //如果安装高德地图，则添加高德地图选项
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        [actionsheet addButtonWithTitle:@"高德地图"];
        
    }
    //如果安装百度地图，则添加百度地图选项
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        [actionsheet addButtonWithTitle:@"百度地图"];
    }
    
    [actionsheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"numberOfButtons == %ld",actionSheet.numberOfButtons);
    NSLog(@"buttonIndex == %ld",buttonIndex);
    
    if (buttonIndex == 0) {
        NSLog(@"自带地图触发了");
        MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coor addressDictionary:nil]];
        
        [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                                                   MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
    }
    //既安装了高德地图，又安装了百度地图
    if (actionSheet.numberOfButtons == 4) {
        
        if (buttonIndex == 2) {
            NSLog(@"高德地图触发了");
            NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",self.coor.latitude,self.coor.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
        }
        if (buttonIndex == 3) {
            NSLog(@"百度地图触发了");
            NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.coor.latitude,self.coor.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
        }
        
    }
    //安装了高德地图或安装了百度地图
    if (actionSheet.numberOfButtons == 3) {
        
        if (buttonIndex == 2) {
            
            if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
                NSLog(@"只安装的高德地图触发了");
                NSString *urlsting =[[NSString stringWithFormat:@"iosamap://navi?sourceApplication= &backScheme= &lat=%f&lon=%f&dev=0&style=2",self.coor.latitude,self.coor.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication  sharedApplication]openURL:[NSURL URLWithString:urlsting]];
            }
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
                NSLog(@"只安装的百度地图触发了");
                NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.coor.latitude,self.coor.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
            }
        }
        
    }
    
}


@end
