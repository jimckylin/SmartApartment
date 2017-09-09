//
//  CouponViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/23.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "CouponViewController.h"
#import "YJSliderView.h"
#import "CouponListCell.h"
#import "MineViewModel.h"



@interface CouponViewController ()<YJSliderViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) YJSliderView *sliderView;
@property (nonatomic, strong) MineViewModel  *mineViewModel;

@property (nonatomic, strong) NSMutableArray *unUseCouponList;
@property (nonatomic, strong) NSMutableArray *usedCouponList;
@property (nonatomic, strong) NSMutableArray  *expriedCouponList;

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = @"优惠券";
    
    self.sliderView = [[YJSliderView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.sliderView.delegate = self;
    [self.view addSubview:self.sliderView];
    
    [self initData];
    [self initSubView];
}

- (void)initData {
    
    _unUseCouponList = [[NSMutableArray alloc] initWithCapacity:1];
    _usedCouponList = [[NSMutableArray alloc] initWithCapacity:1];
    _expriedCouponList = [[NSMutableArray alloc] initWithCapacity:1];
    
    _mineViewModel = [MineViewModel new];
    [self requestGetCoupon];
}


- (void)initSubView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // [self.view addSubview:_tableView];
    //[_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    [_tableView registerClass:[CouponListCell class] forCellReuseIdentifier:@"CouponListCell"];
    
    _tableView1 = [[UITableView alloc] init];
    _tableView1.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    // [self.view addSubview:_tableView];
    //[_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    [_tableView1 registerClass:[CouponListCell class] forCellReuseIdentifier:@"CouponListCell"];
    
    _tableView2 = [[UITableView alloc] init];
    _tableView2.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    // [self.view addSubview:_tableView];
    //[_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    [_tableView2 registerClass:[CouponListCell class] forCellReuseIdentifier:@"CouponListCell"];
}



#pragma mark - Request

- (void)requestGetCoupon {
    
    __WeakObj(self)
    [_mineViewModel requestGetCoupon:@"" storeId:@"" complete:^(NSArray *couponList) {
        
        [selfWeak pareseCouponList:couponList];
        [selfWeak.tableView reloadData];
    }];
}


#pragma mark - UITableView Delegate

- (NSInteger)numberOfItemsInYJSliderView:(YJSliderView *)sliderView {
    return 3;
}

- (UIView *)yj_SliderView:(YJSliderView *)sliderView viewForItemAtIndex:(NSInteger)index {
    
    
    if (index == 0) {
        return _tableView;
    }else if (index == 1) {
        return _tableView1;
    }
    return _tableView2;
}

- (NSString *)yj_SliderView:(YJSliderView *)sliderView titleForItemAtIndex:(NSInteger)index {
    NSArray *titles = @[@"未使用", @"已使用", @"已过期"];
    return titles[index];
}

- (NSInteger)initialzeIndexForYJSliderView:(YJSliderView *)sliderView {
    return 1;
}

- (NSInteger)yj_SliderView:(YJSliderView *)sliderView redDotNumForItemAtIndex:(NSInteger)index {
    return 0;
}

- (void)changeCurrrentToIndex:(NSInteger)index {
    NSLog(@"切换到位置%ld", index);
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _tableView) {
        return [_unUseCouponList count];
    }else if (tableView == _tableView1) {
        return [_usedCouponList count];
    }
    return [_expriedCouponList count];;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CouponListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponListCell"];
    if (tableView == _tableView) {
        cell.couponList = _unUseCouponList[indexPath.row];
    }else if (tableView == _tableView1) {
        cell.couponList = _usedCouponList[indexPath.row];
    }else if (tableView == _tableView2) {
        cell.couponList = _expriedCouponList[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - Private

- (void)pareseCouponList:(NSArray *)couponList {
    
    for (CouponList *coupon in couponList) {
        // 0-已使用 ，1-未使用，2-已过期
        if ([coupon.useStatus integerValue] == 0) {
            [_usedCouponList addObject:coupon];
        }else if ([coupon.useStatus integerValue] == 1) {
            [_unUseCouponList addObject:coupon];
        }else if ([coupon.useStatus integerValue] == 2) {
            [_expriedCouponList addObject:coupon];
        }
    }
}


@end

