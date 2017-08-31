//
//  HomeViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "BannerDetailViewController.h"
#import "TLCityPickerController.h"
#import "CalendarViewController.h"
#import "HotelListViewController.h"
#import "ExtraSearchViewController.h"

#import "HotelSelectView.h"
#import "ZYCalendarManager.h"
#import "LocationManager.h"
#import "HomeViewModel.h"

#import "Activity.h"

@interface HomeViewController ()<UITableViewDelegate,
                                 UITableViewDataSource,
                                 SDCycleScrollViewDelegate,
                                 HotelSelectViewDelegate,
                                 TLCityPickerDelegate>

@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) HomeViewModel  *homeViewModel;
@property (nonatomic, strong) NSMutableArray *activityAarr;

@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *checkInTime;
@property (nonatomic, copy) NSString *checkOutTime;
@property (nonatomic, copy) NSString *checkInRoomType;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
}

- (void)initData {
    
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
    
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 500, kScreenWidth, 180) delegate:self placeholderImage:[UIImage imageNamed:@"snapshot"]];
    _bannerView.autoScrollTimeInterval = 5;

    
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


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 300;
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
            HotelSelectView *selectView = [[HotelSelectView alloc] initWithDelegate:self];
            [cell addSubview:selectView];
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
        [SVProgressHUD showInfoWithStatus:@"正在开发中"];
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
    NSLog(@"---点击了第%ld张图片", (long)index);
    BannerDetailViewController *bannerDetail = [BannerDetailViewController new];
    [[NavManager shareInstance] showViewController:bannerDetail isAnimated:YES];
}


#pragma mark - HotelSelectViewDelegate

- (void)hotelSelectViewDidClickBtn:(HotelSelectBtnType)type roomType:(HotelRoomType)roomType {
    
    switch (type) {
        case HotelSelectBtnTypeCitySelect: {
            TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
            [cityPickerVC setDelegate:self];
            
            cityPickerVC.locationCityID = @"1400010000";
            //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
            cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
            [[NavManager shareInstance] showViewController:cityPickerVC isAnimated:YES];
        }
            break;
        case HotelSelectBtnTypeLocate: {
            [SVProgressHUD show];
            [[LocationManager shareManager] startLocate:^(NSDictionary *addressDic) {
               
                
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
                }
            };
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            break;
        case HotelSelectBtnTypeSearchHotel: {
            HotelListViewController *vc = [HotelListViewController new];
            vc.area = self.city;
            vc.storeName = self.storeName;
            vc.checkInTime = self.checkInTime;
            vc.checkOutTime = self.checkOutTime;
            vc.checkInRoomType = @"0";
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            break;
        case HotelSelectBtnTypeExtraSearch: {
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
    [[NavManager shareInstance] returnToFrontView:YES];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController {
    
}


@end
