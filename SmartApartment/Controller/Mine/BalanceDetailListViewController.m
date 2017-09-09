//
//  BalanceDetailViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/24.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "BalanceDetailListViewController.h"
#import "YJSliderView.h"
#import "BalanceListCell.h"
#import "MineViewModel.h"


@interface BalanceDetailListViewController ()<YJSliderViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) YJSliderView *sliderView;
@property (nonatomic, strong) MineViewModel  *mineViewModel;


@end

@implementation BalanceDetailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = @"余额明细";
    
    self.sliderView = [[YJSliderView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.sliderView.delegate = self;
    [self.view addSubview:self.sliderView];
    
    [self initSubView];
    [self initData];
    
}

- (void)initData {
    
    _mineViewModel = [MineViewModel new];
    [self requestCardConsumeDetail:1 pageSize:20];
    [self requestCardRechargeDetail:1 pageSize:20];
}

- (void)initSubView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // [self.view addSubview:_tableView];
    //[_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    [_tableView registerNib:[UINib nibWithNibName:@"BalanceListCell" bundle:nil] forCellReuseIdentifier:@"BalanceListCell"];
    
    _tableView1 = [[UITableView alloc] init];
    _tableView1.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    // [self.view addSubview:_tableView];
    //[_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    [_tableView1 registerNib:[UINib nibWithNibName:@"BalanceListCell" bundle:nil] forCellReuseIdentifier:@"BalanceListCell"];
    
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
    NSArray *titles = @[@"消费明细", @"充值明细"];
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
    if (tableView == self.tableView) {
        return [_mineViewModel.consumeList count];
    }else {
        return [_mineViewModel.rechargeList count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 77;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BalanceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BalanceListCell" forIndexPath:indexPath];
    if (tableView == self.tableView) {
        cell.consumeDict = _mineViewModel.consumeList[indexPath.row];
    }else {
        cell.rechargeDict = _mineViewModel.rechargeList[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - Request

- (void)requestCardConsumeDetail:(NSInteger)pageNum pageSize:(NSInteger)pageSize {
    
    __WeakObj(self)
    [_mineViewModel requestCardConsumeDetail:^(NSArray *consumeList) {
        [selfWeak.tableView reloadData];
    }];
}


- (void)requestCardRechargeDetail:(NSInteger)pageNum pageSize:(NSInteger)pageSize {
    
    __WeakObj(self)
    [_mineViewModel requestCardRechargeDetail:^(NSArray *rechargeList) {
        [selfWeak.tableView1 reloadData];
    }];
}


@end
