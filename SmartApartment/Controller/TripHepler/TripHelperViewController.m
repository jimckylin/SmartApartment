//
//  TripHelperViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/7.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "TripHelperViewController.h"
#import "HotelDetailViewController.h"
#import "TripHistoryListViewController.h"
#import "OrderDetailViewController.h"
#import "CommentHotelViewController.h"

#import "TripHelperNoOrderView.h"
#import "TripListCell.h"
#import "BlankCell.h"
#import "OrderViewModel.h"


@interface TripHelperViewController ()<UITableViewDelegate, UITableViewDataSource, TripListCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TripHelperNoOrderView *tripHelperNoOrderView;
@property (nonatomic, strong) OrderViewModel  *orderViewModel;

@end


@implementation TripHelperViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_naviBackBtn setHidden:YES];
    _naviLabel.text = NSLocalizedString(@"行程助手", nil);
    [self addRightNaviButton:kImage(@"trip_history_iciphone") highlight:nil action:@selector(tripHistoryBtnClick:)];
    
    [self iniData];
    [self initSubView];
}

- (void)iniData {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccess:)
                                                 name:@"kLoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logoutSuccess:)
                                                 name:@"kLogoutSuccess" object:nil];
    _orderViewModel = [OrderViewModel new];
    [self requestData];
    
    self.tripHelperNoOrderView.tripHelperNoOrderViewBlock = ^(){
        [[NavManager shareInstance] goToTabbarHome];
    };
}


#pragma mark - HttpRequest

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


- (void)requestData {
    
    if ([UserManager manager].isLogin) {
        __WeakObj(self)
        [_orderViewModel requestGetCurrTripComplete:^(NSArray *tripOrderList) {
            [selfWeak.tableView reloadData];
            if ([tripOrderList count] == 0) {
                [selfWeak.tableView.mj_header setHidden:YES];
            }
            [selfWeak.tableView.mj_header endRefreshing];
        }];
    }
}

- (void)initSubView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 49, 0)];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TripListCell" bundle:nil] forCellReuseIdentifier:@"TripListCell"];
    [_tableView registerClass:[BlankCell class] forCellReuseIdentifier:@"BlankCell"];
    
    if ([UserManager manager].isLogin) {
        __weak typeof(self) weakSelf = self;
        //默认block方法：设置下拉刷新
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestData];
        }];
    }
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([UserManager manager].isLogin && [self hasTripOrder]) {
        return [_orderViewModel.tripOrderList count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([UserManager manager].isLogin && [self hasTripOrder]) {
        return 373;
    }
    return 1193;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([UserManager manager].isLogin && [self hasTripOrder]) {
        TripListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripListCell" forIndexPath:indexPath];
        cell.delegate = self;
        TripOrder *order = _orderViewModel.tripOrderList[indexPath.row];
        cell.tripOrder = order;
        
        return cell;
        
    }else {
        BlankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlankCell" forIndexPath:indexPath];
        [cell addSubview:self.tripHelperNoOrderView];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([UserManager manager].isLogin && [self hasTripOrder]) {
        
        TripOrder *order = _orderViewModel.tripOrderList[indexPath.row];
        OrderDetailViewController *vc = [OrderDetailViewController new];
        vc.orderNo = order.orderNo;
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        
//        HotelDetailViewController *vc = [HotelDetailViewController new];
//        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    }
}


#pragma mark - UIButton Action

- (void)tripHistoryBtnClick:(id)sender {
    if (!self.checkIsLogin) return;
    TripHistoryListViewController *vc = [TripHistoryListViewController new];
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}


#pragma mark - TripListCellDelegate

- (void)tripListCellDidClcikBtnType:(TripCellBtnType)btnType order:(TripOrder *)order {
    
    switch (btnType) {
        case TripCellBtnTypeGetCarVerifyCode: {
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

- (BOOL)hasTripOrder {
    
    return [_orderViewModel.tripOrderList count];
}



#pragma mark - Getter

- (TripHelperNoOrderView *)tripHelperNoOrderView {
    if (!_tripHelperNoOrderView) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"TripHelperNoOrderView"owner:self options:nil];
        _tripHelperNoOrderView = nibView.lastObject;
    }
    return _tripHelperNoOrderView;
}


#pragma mark - Notification

- (void)loginSuccess:(NSNotification *)noti {
    
    [self requestData];
}

- (void)logoutSuccess:(NSNotification *)noti {
    [_tableView.mj_header setHidden:YES];
    [_tableView reloadData];
}


@end
