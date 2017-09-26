//
//  UseCouponListViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/19.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "UseCouponListViewController.h"
#import "CouponListCell.h"
#import <BAButton/BAButton.h>
#import "MineViewModel.h"


@interface UseCouponListViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *coupons;
@property(nonatomic, assign) BOOL useCoupon;   // 是否使用优惠券
@property (nonatomic, strong) MineViewModel  *mineViewModel;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation UseCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)initUI {
    
    _naviLabel.text = @"优惠券";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionHeaderHeight = 10;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[CouponListCell class] forCellReuseIdentifier:@"CouponListCell"];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 80, 0)];
    
    // header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    headerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = headerView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120, 45)];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor darkTextColor];
    label.text = @"使用优惠券";
    [headerView addSubview:label];
    
    UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    switchBtn.onTintColor = ThemeColor;
    switchBtn.center = CGPointMake(kScreenWidth - 40, 22.5);
    [switchBtn addTarget:self action:@selector(switchBtnAciton:) forControlEvents:UIControlEventValueChanged];
    [headerView addSubview:switchBtn];
    
    // footer
    UIView *footerView = [UIView new];
    [self.view addSubview:footerView];
    [footerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [footerView autoSetDimension:ALDimensionHeight toSize:80];
    
    UIButton *addBtn = [UIButton ba_buttonWithFrame:CGRectMake(20, 20, kScreenWidth-40, 44) title:@"完成" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:13] image:nil backgroundColor:ThemeColor];
    [addBtn ba_button_setViewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:4];
    [addBtn ba_button_setButtonLayoutType:BAKit_ButtonLayoutTypeNormal padding:10];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addBtn];
    
    
}


#pragma mark - UIControl

- (void)switchBtnAciton:(UISwitch *)switchBtn {
    
    _useCoupon = switchBtn.on;
    [_tableView reloadData];
}

- (void)addBtnClick:(id)sender {
    
    if (_useCoupon) {
        if (self.didSelectedCoupon && [_coupons count] > 0) {
            self.didSelectedCoupon(_coupons[_selectedIndex]);
        }
    }else {
        if (self.didSelectedCoupon) {
            self.didSelectedCoupon(nil);
        }
    }
    [[NavManager shareInstance] returnToFrontView:YES];
}



#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_useCoupon) {
        if ([_coupons count] > 0) {
            return [_coupons count];
        }else {
            return 1;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 95;
    }
    return 57;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (_useCoupon) {
        return 61;
    }
    return 0;
}


#pragma mark - UITableView DataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 25)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    label.text = @"选择您可用的优惠券";
    [headerView addSubview:label];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 200, 25)];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.font = [UIFont boldSystemFontOfSize:12];
    labelTitle.textColor = [UIColor grayColor];
    labelTitle.text = @"(房间每晚可使用优惠券一张)";
    [headerView addSubview:labelTitle];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    if ([_coupons count] > 0) {
        CouponListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponListCell"];
        cell.couponList = _coupons[row];
        cell.isUse = YES;
        return cell;
    }else {
        
        NSString *cellIdetifier = @"CellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        cell.textLabel.text = @"未找到可用的优惠券";
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    _selectedIndex = indexPath.row;
}





#pragma mark - init Data

- (void)initData {
    _coupons = [[NSMutableArray alloc] initWithCapacity:1];
    _mineViewModel = [MineViewModel new];
    [self requestGetCoupon];
}

#pragma mark - Request

- (void)requestGetCoupon {
    
    __WeakObj(self)
    [_mineViewModel requestGetCoupon:self.roomTypeId storeId:self.storeId complete:^(NSArray *couponList) {
        
        for (CouponList *coupon in couponList) {
            if ([coupon.useStatus intValue] == 1) {
                [selfWeak.coupons addObject:coupon];
            }
        }
        [selfWeak.tableView reloadData];
    }];
}

@end
