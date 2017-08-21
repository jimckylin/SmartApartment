//
//  HotelOrderListViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelOrderListViewController.h"
#import "YJSliderView.h"
#import "MyOrderCell.h"

@interface HotelOrderListViewController ()<YJSliderViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) YJSliderView *sliderView;

@end

@implementation HotelOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = @"酒店订单";
    
    self.sliderView = [[YJSliderView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.sliderView.delegate = self;
    [self.view addSubview:self.sliderView];
    
    [self initSubView];
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
    NSArray *titles = @[@"全部订单", @"未完成"];
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 198;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}




@end
