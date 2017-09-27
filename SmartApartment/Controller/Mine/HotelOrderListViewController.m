//
//  HotelOrderListViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelOrderListViewController.h"
#import "CommentHotelViewController.h"
#import "OrderDetailViewController.h"

#import "YJSliderView.h"
#import "MyOrderCell.h"
#import "OrderViewModel.h"



@interface HotelOrderListViewController ()<YJSliderViewDelegate, UITableViewDelegate, UITableViewDataSource, MyOrderCellDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) YJSliderView *sliderView;
@property (nonatomic, strong) OrderViewModel  *orderViewModel;

@property (nonatomic, strong) NSMutableArray  *allOrderList;
@property (nonatomic, strong) NSMutableArray  *evaluateList;

@property (nonatomic, assign) NSInteger  orderType;
@property (nonatomic, copy) NSString *orderNo;

@property (nonatomic, assign) NSInteger  allPageNum;
@property (nonatomic, assign) NSInteger  evaluatePageNum;

@end

@implementation HotelOrderListViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"kRefreshOrderList"
                                                  object:nil];
}

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
    
    _allPageNum = 1;
    _evaluatePageNum = 1;
    _allOrderList = [[NSMutableArray alloc] initWithCapacity:1];
    _evaluateList = [[NSMutableArray alloc] initWithCapacity:1];
    
    _orderViewModel = [OrderViewModel new];
    [self requestAllOrderDataWith:1];
    [self requestEvaluateDataWith:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshOrderList:)
                                                 name:@"kRefreshOrderList"
                                               object:nil];
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
    
    
    //默认block方法：设置下拉刷新
    __WeakObj(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.allPageNum = 1;
        [selfWeak requestAllOrderDataWith:1];
    }];
    self.tableView1.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.evaluatePageNum = 1;
        [selfWeak requestEvaluateDataWith:1];
    }];
    
    //默认block方法：设置上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        selfWeak.allPageNum ++;
        [selfWeak requestAllOrderDataWith:selfWeak.allPageNum];
    }];
    self.tableView1.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        selfWeak.evaluatePageNum ++;
        [selfWeak requestEvaluateDataWith:selfWeak.evaluatePageNum];
    }];
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
    
    if (tableView == _tableView) {
        return [_allOrderList count];
    }
    return [_evaluateList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 198;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderCell" forIndexPath:indexPath];
    cell.delegate = self;
    TripOrder *order = nil;
    if (tableView == _tableView) {
        order = _allOrderList[indexPath.row];
    }else {
        order = _evaluateList[indexPath.row];
    }
    cell.tripOrder = order;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TripOrder *order = nil;
    if (tableView == _tableView) {
        order = _allOrderList[indexPath.row];
    }else {
        order = _evaluateList[indexPath.row];
    }
    OrderDetailViewController *vc = [OrderDetailViewController new];
    vc.orderNo = order.orderNo;
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [self requestConfirmCancelOrder:self.orderNo];
    }
}


#pragma mark - HttpRequest

- (void)requestAllOrderDataWith:(NSInteger)pageNum {
    __WeakObj(self)
    [_orderViewModel requestStoreOrderPageNum:pageNum pageSize:20 orderType:0 complete:^(NSArray *tripOrderList) {
        
        if (pageNum == 1) {
            [selfWeak.allOrderList removeAllObjects];
            [selfWeak.tableView.mj_header endRefreshing];
        }else {
            [selfWeak.tableView.mj_footer endRefreshing];
        }
        [selfWeak.allOrderList addObjectsFromArray:tripOrderList];
        [selfWeak.tableView reloadData];
    }];
}


- (void)requestEvaluateDataWith:(NSInteger)pageNum {
    __WeakObj(self)
    [_orderViewModel requestStoreOrderPageNum:pageNum pageSize:20 orderType:1 complete:^(NSArray *tripOrderList) {
        
        if (pageNum == 1) {
            [selfWeak.evaluateList removeAllObjects];
            [selfWeak.tableView1.mj_header endRefreshing];
        }else {
            [selfWeak.tableView1.mj_footer endRefreshing];
        }
        [selfWeak.evaluateList addObjectsFromArray:tripOrderList];
        [selfWeak.tableView1 reloadData];
    }];
}

- (void)requestCancelOrder:(NSString *)orderNo {
    
    __WeakObj(self)
    [_orderViewModel requestCancelOrder:orderNo complete:^(NSString *msg) {
        
        selfWeak.orderNo = orderNo;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:selfWeak cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }];
}

- (void)requestConfirmCancelOrder:(NSString *)orderNo {
    
    __WeakObj(self)
    [_orderViewModel requestConfirmCancelOrder:orderNo complete:^(BOOL isSuccess) {
        
        if (isSuccess) {
            [MBProgressHUD cwgj_showHUDWithText:@"取消订单"];
            selfWeak.allPageNum = 1;
            selfWeak.evaluatePageNum = 1;
            [selfWeak requestAllOrderDataWith:1];
            [selfWeak requestEvaluateDataWith:1];
        }
    }];
}

- (void)requestCheckOutRoom:(NSString *)orderNo {
    
    __WeakObj(self)
    [_orderViewModel requestCheckoutRoom:orderNo complete:^(BOOL isCheckout) {
        if (isCheckout) {
            [MBProgressHUD cwgj_showHUDWithText:@"退房成功"];
            selfWeak.allPageNum = 1;
            selfWeak.evaluatePageNum = 1;
            [selfWeak requestAllOrderDataWith:1];
            [selfWeak requestEvaluateDataWith:1];
        }
    }];
}

- (void)requestDeleteHistoryTrip:(NSString *)orderNo {
    
    __WeakObj(self)
    [_orderViewModel requestDelHistoryTrip:orderNo complete:^(BOOL isDelete) {
        if (isDelete) {
            [MBProgressHUD cwgj_showHUDWithText:@"删除成功"];
            selfWeak.allPageNum = 1;
            selfWeak.evaluatePageNum = 1;
            [selfWeak requestAllOrderDataWith:1];
            [selfWeak requestEvaluateDataWith:1];
        }
    }];
}


#pragma mark - TripListCellDelegate

- (void)myOrderCellDidClcikBtnType:(TripCellBtnType)btnType order:(TripOrder *)order {
    
    switch (btnType) {
        case TripCellBtnTypeGetCarVerifyCode: {
            
            [self showVerifyCode:order.checkInNo];
        }
            break;
        case TripCellBtnTypeCancelOrder: {
            //FIX-ME:修改
            CommentHotelViewController *vc = [CommentHotelViewController new];
            vc.tripOrder = order;
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
            return;
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



#pragma mark - NSNotification

- (void)refreshOrderList:(NSNotification *)noti {
    _allPageNum = 1;
    _evaluatePageNum = 1;
    [self requestAllOrderDataWith:_allPageNum];
    [self requestEvaluateDataWith:_allPageNum];
}


@end
