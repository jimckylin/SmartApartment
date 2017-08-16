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

@interface HomeViewController ()<UITableViewDelegate,
                                 UITableViewDataSource,
                                 SDCycleScrollViewDelegate,
                                 HotelSelectViewDelegate,
                                 TLCityPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *city;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initData {
    
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
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    SDCycleScrollView *bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 500, kScreenWidth, 180) delegate:self placeholderImage:[UIImage imageNamed:@"snapshot"]];
    bannerView.imageURLStringsGroup = imagesURLStrings;
    bannerView.autoScrollTimeInterval = 5;

    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgView addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 49, 0)];
    
    _tableView.tableHeaderView = bannerView;
    
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
        case HotelSelectBtnTypeLiveDate:
        case HotelSelectBtnTypeLeaveDate: {
            CalendarViewController *vc = [CalendarViewController new];
            vc.calendarDateBlock = ^(ZYCalendarManager *manager, NSDate *dayDate) {
                for (NSDate *date in manager.selectedDateArray) {
                    NSLog(@"%@", [manager.dateFormatter stringFromDate:date]);
                }
            };
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            break;
        case HotelSelectBtnTypeSearchHotel: {
            HotelListViewController *vc = [HotelListViewController new];
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
