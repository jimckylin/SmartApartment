//
//  TripHistoryListViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "TripHistoryListViewController.h"
#import "CommentHotelViewController.h"
#import "OrderDetailViewController.h"

#import "TripListCell.h"
#import "OrderViewModel.h"


@interface TripHistoryListViewController ()<UITableViewDelegate, UITableViewDataSource, TripListCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderViewModel  *orderViewModel;

@end


@implementation TripHistoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = NSLocalizedString(@"历史行程", nil);
    
    [self iniData];
    [self initSubView];
    [self requestData];
}

- (void)iniData {
    _orderViewModel = [OrderViewModel new];
}

- (void)initSubView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TripListCell" bundle:nil] forCellReuseIdentifier:@"TripListCell"];
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_orderViewModel.tripOrderList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 373;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TripListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripListCell" forIndexPath:indexPath];
    cell.delegate = self;
    TripOrder *order = _orderViewModel.tripOrderList[indexPath.row];
    cell.tripOrder = order;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TripOrder *order = _orderViewModel.tripOrderList[indexPath.row];
    OrderDetailViewController *vc = [OrderDetailViewController new];
    vc.orderNo = order.orderNo;
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}


#pragma mark - HttpRequest

- (void)requestData {
    
    __WeakObj(self)
    [_orderViewModel requestGetHistoryTripPageNum:1 pageSize:20 complete:^(NSArray *tripOrderList) {
        [selfWeak.tableView reloadData];
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

- (void)tripListCellDidClcikBtnType:(TripCellBtnType)btnType order:(TripOrder *)order {
    
    switch (btnType) {
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





@end
