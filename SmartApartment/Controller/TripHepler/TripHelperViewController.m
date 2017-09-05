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

#import "TripHelperNoOrderView.h"
#import "TripListCell.h"
#import "OrderViewModel.h"


@interface TripHelperViewController ()<UITableViewDelegate, UITableViewDataSource>

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
    
    __WeakObj(self)
    [_orderViewModel requestGetCurrTripComplete:^(NSArray *tripOrderList) {
        [selfWeak.tableView reloadData];
    }];
    
    
    self.tripHelperNoOrderView.tripHelperNoOrderViewBlock = ^(){
        [[NavManager shareInstance] goToTabbarHome];
    };
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
        TripOrder *order = _orderViewModel.tripOrderList[indexPath.row];
        cell.tripOrder = order;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([UserManager manager].isLogin) {
        HotelDetailViewController *vc = [HotelDetailViewController new];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    }
}


#pragma mark - UIButton Action

- (void)tripHistoryBtnClick:(id)sender {
    
    TripHistoryListViewController *vc = [TripHistoryListViewController new];
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
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
