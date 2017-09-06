//
//  ActivityViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/7.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityTableViewCell.h"
#import "ActivityDetailViewController.h"
#import "ActivityViewModel.h"
#import "CZDWebViewController.h"

@interface ActivityViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ActivityViewModel *viewModel;

@end

 NSString *const kActivityTableViewCell = @"ActivityTableViewCell";


@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_naviBackBtn setHidden:YES];
    _naviLabel.text = NSLocalizedString(@"活动", nil);
    
    [self initData];
    [self initSubView];
}

- (void)initData {
    
    _viewModel = [ActivityViewModel new];
    __WeakObj(self)
    [_viewModel requestGetActivityComplete:^(NSArray *activityArr) {
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
    [_tableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:kActivityTableViewCell];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 49, 0)];
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewModel.activityArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 552/2+10;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kActivityTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    Activity *activity = _viewModel.activityArr[indexPath.row];
    cell.activity = activity;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Activity *activity = _viewModel.activityArr[indexPath.row];
    
    CZDWebViewController *vc = [CZDWebViewController new];
    vc.requestUrl = activity.activityUrl;
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    
//    ActivityDetailViewController *vc = [ActivityDetailViewController new];
//    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}


@end
