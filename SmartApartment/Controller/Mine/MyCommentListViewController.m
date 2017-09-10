//
//  MyCommentListViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/10.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MyCommentListViewController.h"
#import "HotelCommentListViewController.h"
#import "MyCommentListCell.h"
#import "MineViewModel.h"
#import "HotelList.h"

@interface MyCommentListViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MineViewModel  *mineViewModel;

@end

@implementation MyCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)initData {
    _mineViewModel = [MineViewModel new];
    [self requestGetCoupon];
}

- (void)initUI {
    
    _naviLabel.text = @"我的点评";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionHeaderHeight = 10;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"MyCommentListCell" bundle:nil] forCellReuseIdentifier:@"MyCommentListCell"];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
}



#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_mineViewModel.hotelList.storeList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


#pragma mark - UITableView DataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    MyCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCommentListCell" forIndexPath:indexPath];
    cell.hotel = _mineViewModel.hotelList.storeList[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Hotel *hotel = _mineViewModel.hotelList.storeList[indexPath.row];
    HotelCommentListViewController *vc = [HotelCommentListViewController new];
    vc.storeId = hotel.storeId;
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}





#pragma mark - Request

- (void)requestGetCoupon {
    
    __WeakObj(self)
    [_mineViewModel requestMyReview:^(HotelList *hotelList) {
        
        [selfWeak.tableView reloadData];
    }];
}

@end
