//
//  HomeViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "CZDWebViewController.h"
#import "TLCityPickerController.h"
#import "CalendarViewController.h"
#import "HotelListViewController.h"
#import "ExtraSearchViewController.h"

#import "HotelSelectView.h"
#import "ZYCalendarManager.h"
#import "LocationManager.h"
#import "HomeViewModel.h"

#import "Activity.h"
#import "NSDate+Utilities.h"

@interface HomeViewController ()<UITableViewDelegate,
                                 UITableViewDataSource,
                                 SDCycleScrollViewDelegate,
                                 HotelSelectViewDelegate,
                                 TLCityPickerDelegate,
                                 UIAlertViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) HomeViewModel  *homeViewModel;
@property (nonatomic, strong) NSMutableArray *activityAarr;
@property (nonatomic, strong) HotelSelectView *selectView;

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *checkInTime;
@property (nonatomic, copy) NSString *checkOutTime;
@property (nonatomic, copy) NSString *checkInRoomType;

// 第一次进入此界面
@property (nonatomic, assign) BOOL isFirstShow;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)initData {
    self.isFirstShow = YES;
    self.city = @"福州";
    NSDate *date = [NSDate date];
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];//后一天
    self.checkInTime = [NSString sia_stringFromDate:date withFormat:@"yyyy-MM-dd"];
    self.checkOutTime = [NSString sia_stringFromDate:nextDay withFormat:@"yyyy-MM-dd"];
    
    _homeViewModel = [HomeViewModel new];
    _activityAarr = [[NSMutableArray alloc] initWithCapacity:1];
    
    [_homeViewModel requestGetTopAd:^(NSArray *ads) {
        [_activityAarr addObjectsFromArray:ads];
        
        NSMutableArray *images = [NSMutableArray array];
        for (Activity *act in ads) {
            [images addObject:act.activityImage];
        }
        _bannerView.imageURLStringsGroup = images;
    }];
    
    __WeakObj(self)
    [[LocationManager shareManager] startLocate:^(NSDictionary *addressDic) {
        selfWeak.city = addressDic[kLocationCity];
    }];
}

- (void)initUI {
    [_naviBackBtn setHidden:YES];
    [_naviView setAlpha:0];
    _naviLabel.text = @"智慧公寓";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    [self.view addSubview:view];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    [self.view addSubview:bgView];
    
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 500, kScreenWidth, 180) delegate:self placeholderImage:[UIImage imageNamed:@"blank_default_nomal_bg"]];
    _bannerView.autoScrollTimeInterval = 5;
    _bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgView addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 49, 0)];
    
    _tableView.tableHeaderView = _bannerView;
    [self.view bringSubviewToFront:_naviView];
}

- (void)viewDidAppear:(BOOL)animated {
   
    [super viewDidAppear:animated];
    if (self.isFirstShow) {
        self.isFirstShow = NO;
        // 判断是否凌晨
        BOOL beforeDawn = [NSDate judgeTimeByStartAndEnd:@"00:00" withExpireTime:@"04:00"];
        if (beforeDawn) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您是否需要预订凌晨房？\n凌晨入住，当天退房。" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            [alertView show];
        }
    }
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 270;
    }else {
        return 174;
    }
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        NSString *cellIdetifier = @"cellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
            cell.backgroundColor = [UIColor clearColor];
            _selectView = [[HotelSelectView alloc] initWithDelegate:self];
            [cell addSubview:_selectView];
        }
        return cell;
    }else {
        NSString *cellIdetifier = @"mallCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 174)];
            imageV.image = [UIImage imageNamed:@"jifen_mall"];
            [cell addSubview:imageV];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        [MBProgressHUD cwgj_showHUDWithText:@"正在开发中"];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > 50) {
        _naviView.alpha = (scrollView.contentOffset.y - 50)/60;
    }else {
        _naviView.alpha = 0.f;
    }
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    Activity *activity = _activityAarr[index];
    CZDWebViewController *vc = [CZDWebViewController new];
    vc.requestUrl = activity.activityUrl;
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}


#pragma mark - HotelSelectViewDelegate

- (void)hotelSelectViewDidClickBtn:(HotelSelectBtnType)type roomType:(HotelRoomType)roomType {
    
    switch (type) {
        case HotelSelectBtnTypeCitySelect: {
            TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
            [cityPickerVC setDelegate:self];
            
            cityPickerVC.locationCityName = self.city;
            //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
            cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
            [[NavManager shareInstance] showViewController:cityPickerVC isAnimated:YES];
        }
            break;
        case HotelSelectBtnTypeLocate: {
            [SVProgressHUD show];
            __WeakObj(self)
            [[LocationManager shareManager] startLocate:^(NSDictionary *addressDic) {
               
                selfWeak.city = addressDic[kLocationCity];
                selfWeak.selectView.cityName = addressDic[kLocationCity];
                [SVProgressHUD dismiss];
            }];
        }
            break;
        case HotelSelectBtnTypeLiveDate:
        case HotelSelectBtnTypeLeaveDate: {
            CalendarViewController *vc = [CalendarViewController new];
            vc.calendarDateBlock = ^(ZYCalendarManager *manager, NSDate *dayDate) {
                if ([manager.selectedDateArray count] > 1) {
                    NSDate *checkinTime = manager.selectedDateArray[0];
                    NSDate *checkoutTime = manager.selectedDateArray[1];
                    self.checkInTime =  [NSString sia_stringFromDate:checkinTime withFormat:@"yyyy-MM-dd"];
                    self.checkOutTime =  [NSString sia_stringFromDate:checkoutTime withFormat:@"yyyy-MM-dd"];
                    
                    _selectView.checkinDate = checkinTime;
                    _selectView.checkoutDate = checkoutTime;
                }
            };
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            break;
        case HotelSelectBtnTypeSearchHotel: {
            HotelListViewController *vc = [HotelListViewController new];
            if ([Utils isBlankString:self.city]) {
                self.city = @"";
            }
            vc.area = [self.city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            vc.storeName = self.storeName;
            vc.checkInTime = self.checkInTime;
            vc.checkOutTime = self.checkOutTime;
            vc.checkInRoomType = @"0";
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            break;
        case HotelSelectBtnTypeExtraSearch: {
            break;
            ExtraSearchViewController *vc = [ExtraSearchViewController new];
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - TLCityPickerDelegate

- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city {
    self.city = city.shortName;
    _selectView.cityName = city.shortName;
    [[NavManager shareInstance] returnToFrontView:YES];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController {
    
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
   
    if (buttonIndex == 1) {
        HotelListViewController *vc = [HotelListViewController new];
        if ([Utils isBlankString:self.city]) {
            self.city = @"";
        }
        vc.area = [self.city stringByReplacingOccurrencesOfString:@"市" withString:@""];
        
        NSDate *date = [NSDate date];
        NSDate *preDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
        self.checkInTime = [NSString sia_stringFromDate:preDay withFormat:@"yyyy-MM-dd"];
        self.checkOutTime = [NSString sia_stringFromDate:date withFormat:@"yyyy-MM-dd"];
        
        vc.storeName = self.storeName;
        vc.checkInTime = self.checkInTime;
        vc.checkOutTime = self.checkOutTime;
        vc.checkInRoomType = @"0";
        vc.beforeDawn = YES;
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    }
}


@end
