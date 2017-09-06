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

#import "TripHelperNoOrderView.h"
#import "TripListCell.h"
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
    
    _orderViewModel = [OrderViewModel new];
    [self requestData];
    
    self.tripHelperNoOrderView.tripHelperNoOrderViewBlock = ^(){
        [[NavManager shareInstance] goToTabbarHome];
    };
}

- (void)requestData {
    
    __WeakObj(self)
    [_orderViewModel requestGetCurrTripComplete:^(NSArray *tripOrderList) {
        [selfWeak.tableView reloadData];
        if ([tripOrderList count] == 0) {
            [selfWeak.tableView.mj_header setHidden:YES];
        }
        [selfWeak.tableView.mj_header endRefreshing];
    }];
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
    
    __weak typeof(self) weakSelf = self;
    //默认block方法：设置下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([UserManager manager].isLogin) {
        return [_orderViewModel.tripOrderList count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([UserManager manager].isLogin) {
        return 373;
    }
    return 1193;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TripListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripListCell" forIndexPath:indexPath];
    if (![UserManager manager].isLogin) {
        [cell addSubview:self.tripHelperNoOrderView];
    }else {
        cell.delegate = self;
        TripOrder *order = _orderViewModel.tripOrderList[indexPath.row];
        cell.tripOrder = order;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([UserManager manager].isLogin) {
        
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
    
    TripHistoryListViewController *vc = [TripHistoryListViewController new];
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}


#pragma mark - TripListCellDelegate

- (void)tripListCellDidClcikBtnType:(TripCellBtnType)btnType {
    
    switch (btnType) {
        case TripCellBtnTypeGetCarVerifyCode: {
            
        }
            break;
        case TripCellBtnTypeCancelOrder: {
            
        }
            break;
        case TripCellBtnTypeContinueLiving: {
            
        }
            break;
        case TripCellBtnTypeAutoCheckout: {
            
        }
            break;
        case TripCellBtnTypeCommentRoom: {
            
        }
            break;
        case TripCellBtnTypeDeleteOrder: {
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Getter

- (TripHelperNoOrderView *)tripHelperNoOrderView {
    if (!_tripHelperNoOrderView) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"TripHelperNoOrderView"owner:self options:nil];
        _tripHelperNoOrderView = nibView.lastObject;
    }
    return _tripHelperNoOrderView;
}



@end
