//
//  ActivityDetailViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/12.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "BookHotelViewController.h"
#import "ActivityTableViewCell.h"

@interface ActivityDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@end

NSString *const kActivityDetailTableViewCell = @"ActivityTableViewCell";


@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = NSLocalizedString(@"活动详情", nil);
    
    [self initSubView];
}

- (void)initSubView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:kActivityDetailTableViewCell];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenHeight - 64;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kActivityDetailTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    UIButton *bookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bookBtn.backgroundColor = ThemeColor;
    [bookBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bookBtn setTitle:@"去预订" forState:UIControlStateNormal];
    [bookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bookBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [bookBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    bookBtn.layer.cornerRadius = 3;
    [cell addSubview:bookBtn];
    
    [bookBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [bookBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:300];
    [bookBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-40, 40)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - UIButton Action

- (void)btnClick:(id)sender {
    
    BookHotelViewController *vc = [BookHotelViewController new];
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}

@end
