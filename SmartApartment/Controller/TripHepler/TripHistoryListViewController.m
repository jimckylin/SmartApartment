//
//  TripHistoryListViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "TripHistoryListViewController.h"
#import "CommentHotelViewController.h"

#import "TripListCell.h"
#import "OrderViewModel.h"


@interface TripHistoryListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderViewModel  *orderViewModel;

@end


@implementation TripHistoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = NSLocalizedString(@"历史行程", nil);
    
    [self iniData];
    [self initSubView];
}

- (void)iniData {
    
    _orderViewModel = [OrderViewModel new];
    
    __WeakObj(self)
    [_orderViewModel requestGetHistoryTripPageNum:1 pageSize:20 complete:^(NSArray *tripOrderList) {
        [selfWeak.tableView reloadData];
    }];
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
    [cell setButtonStyleHistoryTrip];
    TripOrder *order = _orderViewModel.tripOrderList[indexPath.row];
    cell.tripOrder = order;
    cell.tripListCellBlock = ^(NSInteger tag) {
        if (tag == 1) {
            CommentHotelViewController *vc = [CommentHotelViewController new];
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - UIButton Action

- (void)tripHistoryBtnClick:(id)sender {
    
    
}






@end
