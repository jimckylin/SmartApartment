//
//  HotelListViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/9.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelListViewController.h"
#import "TLCityPickerController.h"
#import "CalendarViewController.h"
#import "HotelDetailViewController.h"

#import "HotelListHeaderView.h"
#import "HotelListCell.h"

#import "ZYCalendarManager.h"

NSString *const kHotelListCell = @"kHotelListCell";

@interface HotelListViewController ()<UITableViewDelegate,
                                      UITableViewDataSource,
                                      HotelListHeaderViewDelegate,
                                      TLCityPickerDelegate>

@property (nonatomic, strong) HotelListHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@end


@implementation HotelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubView];
}

- (void)initSubView {
    
    [_naviView setAlpha:0.f];
    UIView *view = [UIView new];
    [self.view addSubview:view];
    
    // header
    _headerView = [[HotelListHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, 154)];
    _headerView.backgroundColor = ThemeColor;
    _headerView.delegate = self;
    [self.view addSubview:_headerView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HotelListCell class] forCellReuseIdentifier:kHotelListCell];
    _tableView.contentInset = UIEdgeInsetsMake(90, 0, 0, 0);
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(90, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    [self.view bringSubviewToFront:_naviView];
    
    
    UIButton *conditionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    conditionBtn.frame = CGRectMake(40, 20+6.5, kScreenWidth - 55, 31);
    conditionBtn.backgroundColor = [UIColor lightTextColor];
    [conditionBtn setImage:kImage(@"list_city_iciphone") forState:UIControlStateNormal];
    [conditionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [conditionBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [conditionBtn setTitle:@"福州(10)·8月14-15 共1晚" forState:UIControlStateNormal];
    conditionBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [conditionBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
    conditionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    conditionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [conditionBtn addTarget:self action:@selector(conditionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_naviView addSubview:conditionBtn];
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220/2;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotelListCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelListCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotelDetailViewController *vc = [HotelDetailViewController new];
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    CGFloat bounceHeight = 90;
    CGFloat offsetY = scrollView.contentOffset.y + 90;
    CGFloat triggerY = 60;
    
    if (offsetY > triggerY) {
        //NSLog(@"222222:%f  offsetY:%f", scrollView.contentOffset.y, scrollView.contentOffset.y + 90);
        _naviView.alpha = (offsetY - triggerY)/(bounceHeight-triggerY);
    }else {
        _naviView.alpha = 0.f;
    }
    
    [_headerView relayoutHeaderView:scrollView];
    [self exchangeSubview:scrollView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self relayoutTableViewOffset:scrollView];
    [_headerView relayoutHeaderView:scrollView];
    [self exchangeSubview:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)deceleratev {
    [self relayoutTableViewOffset:scrollView];
    [_headerView relayoutHeaderView:scrollView];
    [self exchangeSubview:scrollView];
}


#pragma mark - UIButton Action

- (void)conditionBtnClick:(id)sender {
    [_tableView setContentOffset:CGPointMake(0, -90) animated:YES];
}

- (void)hotelListHeaderViewDidClickBtn:(HotelListHeaderBtnType)type {
    
    if (type == HotelListHeaderBtnTypeBack) {
        [[NavManager shareInstance] returnToFrontView:YES];
        
    }else if (type == HotelListHeaderBtnTypeCity) {
        TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
        [cityPickerVC setDelegate:self];
        
        cityPickerVC.locationCityID = @"1400010000";
        //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
        cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
        [[NavManager shareInstance] showViewController:cityPickerVC isAnimated:YES];
        
    }else {
        CalendarViewController *vc = [CalendarViewController new];
        vc.calendarDateBlock = ^(ZYCalendarManager *manager, NSDate *dayDate) {
            for (NSDate *date in manager.selectedDateArray) {
                NSLog(@"%@", [manager.dateFormatter stringFromDate:date]);
            }
        };
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    }
}


#pragma mark - TLCityPickerDelegate

- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city {
    [[NavManager shareInstance] returnToFrontView:YES];
}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController {
    
}


#pragma mark - Private

- (void)relayoutTableViewOffset:(UIScrollView *)scrollView {
    
    CGFloat bounceHeight = 90;
    CGFloat offsetY = scrollView.contentOffset.y + 90;
    CGFloat triggerY = 60;
    
    if (offsetY > triggerY && offsetY < bounceHeight) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if (offsetY > 0 && offsetY < triggerY) {
        [scrollView setContentOffset:CGPointMake(0, -bounceHeight) animated:YES];
    }
}

- (void)exchangeSubview:(UIScrollView *)scrollView {
    
    NSInteger index1 = [[self.view subviews] indexOfObject:_headerView];
    NSInteger index2 = [[self.view subviews] indexOfObject:_tableView];
    
    CGFloat offsetY = scrollView.contentOffset.y + 90;
    if (offsetY <= 0) {
        if (index1 < index2) {
            [self.view exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
        }
    }else {
        if (index1 > index2) {
            [self.view exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
        }
    }
}


@end
