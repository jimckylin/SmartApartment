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

@property (nonatomic, strong) NSMutableArray  *orderList;
@property (nonatomic, assign) NSInteger pageNum;

@end


@implementation TripHistoryListViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"kRefreshOrderList"
                                                  object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = NSLocalizedString(@"历史行程", nil);
    
    [self iniData];
    [self initSubView];
    [self requestDataWithPageNum:_pageNum];
}

- (void)iniData {
    _pageNum = 1;
    _orderList = [[NSMutableArray alloc] initWithCapacity:1];
    _orderViewModel = [OrderViewModel new];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshOrderList:)
                                                 name:@"kRefreshOrderList"
                                               object:nil];
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
    
    
    //默认block方法：设置下拉刷新
    __WeakObj(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.pageNum = 1;
        [selfWeak requestDataWithPageNum:selfWeak.pageNum];
    }];
    
    //默认block方法：设置上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        selfWeak.pageNum ++;
        [selfWeak requestDataWithPageNum:selfWeak.pageNum];
    }];
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_orderList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 373;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TripListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripListCell" forIndexPath:indexPath];
    cell.isHistory = YES;
    cell.delegate = self;
    TripOrder *order = _orderList[indexPath.row];
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

- (void)requestDataWithPageNum:(NSInteger)pageNum {
    
    __WeakObj(self)
    [_orderViewModel requestGetHistoryTripPageNum:pageNum pageSize:20 complete:^(NSArray *tripOrderList) {
        
        if (pageNum == 1) {
            [selfWeak.orderList removeAllObjects];
            [selfWeak.tableView.mj_header endRefreshing];
        }else {
            [selfWeak.tableView.mj_footer endRefreshing];
        }
        [selfWeak.orderList addObjectsFromArray:tripOrderList];
        [selfWeak.tableView reloadData];
    }];
}

- (void)requestDeleteHistoryTrip:(NSString *)orderNo {
    
    __WeakObj(self)
    [_orderViewModel requestDelHistoryTrip:orderNo complete:^(BOOL isDelete) {
        if (isDelete) {
            [MBProgressHUD cwgj_showHUDWithText:@"删除成功"];
            selfWeak.pageNum = 1;
            [selfWeak requestDataWithPageNum:selfWeak.pageNum];
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


#pragma mark - NSNotification

- (void)refreshOrderList:(NSNotification *)noti {
    _pageNum = 1;
    [self requestDataWithPageNum:_pageNum];
}


@end
