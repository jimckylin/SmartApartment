//
//  HotelOrderListViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelOrderListViewController.h"
#import "CommentHotelViewController.h"

#import "YJSliderView.h"
#import "MyOrderCell.h"
#import "OrderViewModel.h"



@interface HotelOrderListViewController ()<YJSliderViewDelegate, UITableViewDelegate, UITableViewDataSource, MyOrderCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) YJSliderView *sliderView;
@property (nonatomic, strong) OrderViewModel  *orderViewModel;

@end

@implementation HotelOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = @"公寓订单";
    
    self.sliderView = [[YJSliderView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.sliderView.delegate = self;
    [self.view addSubview:self.sliderView];
    
    [self initData];
    [self initSubView];
}

- (void)initData {
    
    _orderViewModel = [OrderViewModel new];
    [self requestData];
}

- (void)initSubView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // [self.view addSubview:_tableView];
    //[_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyOrderCell" bundle:nil] forCellReuseIdentifier:@"MyOrderCell"];
    
    _tableView1 = [[UITableView alloc] init];
    _tableView1.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    // [self.view addSubview:_tableView];
    //[_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    [_tableView1 registerNib:[UINib nibWithNibName:@"MyOrderCell" bundle:nil] forCellReuseIdentifier:@"MyOrderCell"];
    
}


- (NSInteger)numberOfItemsInYJSliderView:(YJSliderView *)sliderView {
    return 2;
}

- (UIView *)yj_SliderView:(YJSliderView *)sliderView viewForItemAtIndex:(NSInteger)index {
    
    
    if (index == 0) {
        return _tableView;
    }
    return _tableView1;
}

- (NSString *)yj_SliderView:(YJSliderView *)sliderView titleForItemAtIndex:(NSInteger)index {
    NSArray *titles = @[@"全部订单", @"待评价"];
    return titles[index];
}

- (NSInteger)initialzeIndexForYJSliderView:(YJSliderView *)sliderView {
    return 0;
}

- (NSInteger)yj_SliderView:(YJSliderView *)sliderView redDotNumForItemAtIndex:(NSInteger)index {
    return 0;
}

- (void)changeCurrrentToIndex:(NSInteger)index {
    NSLog(@"切换到位置%ld", index);
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_orderViewModel.tripOrderList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 198;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderCell" forIndexPath:indexPath];
    cell.delegate = self;
    TripOrder *order = _orderViewModel.tripOrderList[indexPath.row];
    cell.tripOrder = order;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - HttpRequest

- (void)requestData {
    __WeakObj(self)
    [_orderViewModel requestStoreOrderPageNum:1 pageSize:20 complete:^(NSArray *tripOrderList) {
        [selfWeak.tableView reloadData];
    }];
}

- (void)requestCancelOrder:(NSString *)orderNo {
    
    __WeakObj(self)
    [_orderViewModel requestCancelOrder:orderNo refundReason:@"取消订单" complete:^(BOOL isCancel) {
        if (isCancel) {
            [MBProgressHUD cwgj_showHUDWithText:@"取消订单"];
            [selfWeak requestData];
        }
    }];
}


- (void)requestCheckOutRoom:(NSString *)orderNo {
    
    __WeakObj(self)
    [_orderViewModel requestCheckoutRoom:orderNo complete:^(BOOL isCheckout) {
        if (isCheckout) {
            [MBProgressHUD cwgj_showHUDWithText:@"退房成功"];
            [selfWeak requestData];
        }
    }];
}

- (void)requestDeleteHistoryTrip:(NSString *)orderNo {
    
    __WeakObj(self)
    [_orderViewModel requestDelHistoryTrip:orderNo complete:^(BOOL isDelete) {
        if (isDelete) {
            [MBProgressHUD cwgj_showHUDWithText:@"删除成功"];
            [selfWeak requestData];
        }
    }];
}


#pragma mark - TripListCellDelegate

- (void)myOrderCellDidClcikBtnType:(TripCellBtnType)btnType order:(TripOrder *)order {
    
    switch (btnType) {
        case TripCellBtnTypeGetCarVerifyCode: {
            CommentHotelViewController *vc = [CommentHotelViewController new];
            vc.tripOrder = order;
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
            return;
            [self showVerifyCode:order.checkInNo];
        }
            break;
        case TripCellBtnTypeCancelOrder: {
            [self requestCancelOrder:order.orderNo];
        }
            break;
        case TripCellBtnTypeContinueLiving: {
            [self showContinueLivingTip];
        }
            break;
        case TripCellBtnTypeAutoCheckout: {
            [self requestCheckOutRoom:order.orderNo];
        }
            break;
        case TripCellBtnTypeAppOpenDoor: {
            [self showAppOpenDoorTip];
        }
            break;
        case TripCellBtnTypeCommentRoom: {
            CommentHotelViewController *vc = [CommentHotelViewController new];
            vc.tripOrder = order;
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            break;
        case TripCellBtnTypeDeleteOrder: {
            [self requestDeleteHistoryTrip:order.orderNo];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Private

- (void)showVerifyCode:(NSString *)code {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"入住码" message:code delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)showAppOpenDoorTip {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"后续开发" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)showContinueLivingTip {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请到自助机操作" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}



@end
