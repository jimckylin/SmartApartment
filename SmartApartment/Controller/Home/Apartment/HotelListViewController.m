//
//  HotelListViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/9.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelListViewController.h"
#import "HotelListCell.h"

NSString *const kHotelListCell = @"kHotelListCell";

@interface HotelListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation HotelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubView];
}

- (void)initSubView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[HotelListCell class] forCellReuseIdentifier:kHotelListCell];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    _tableView.contentInset = UIEdgeInsetsMake(308/2, 0, 0, 0);
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(308/2, 0, 0, 0);
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220/2;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotelListCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelListCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //ActivityDetailViewController *vc = [ActivityDetailViewController new];
    //[[NavManager shareInstance] showViewController:vc isAnimated:YES];
}


#pragma mark - UIButton Action

- (void)tripHistoryBtnClick:(id)sender {
    
    
}



@end
