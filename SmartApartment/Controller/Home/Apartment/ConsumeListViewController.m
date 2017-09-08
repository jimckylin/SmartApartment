//
//  ConsumeListViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/8.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ConsumeListViewController.h"
#import "ConsumeListCell.h"
#import <BAButton/BAButton.h>
#import <BMLine/UIView+BMLine.h>

@interface ConsumeListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ConsumeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = @"付款清单";
    
    [self initSubView];
}

- (void)initSubView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    [_tableView registerClass:[ConsumeListCell class] forCellReuseIdentifier:@"ConsumeListCell"];
    
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.consumeList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UILabel *itemLabel = [UILabel new];
    itemLabel.font = [UIFont systemFontOfSize:13];
    itemLabel.textColor = ThemeColor;
    itemLabel.textAlignment = NSTextAlignmentCenter;
    itemLabel.text = @"收费项目";
    [headerView addSubview:itemLabel];
    
    UILabel *countLabel = [UILabel new];
    countLabel.font = [UIFont systemFontOfSize:13];
    countLabel.textColor = ThemeColor;
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.text = @"份数";
    [headerView addSubview:countLabel];
    
    UILabel *priceLabel = [UILabel new];
    priceLabel.font = [UIFont systemFontOfSize:13];
    priceLabel.textColor = ThemeColor;
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.text = @"价格";
    [headerView addSubview:priceLabel];
    
    CGFloat width = kScreenWidth/3;
    [itemLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [itemLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [itemLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [itemLabel autoSetDimension:ALDimensionWidth toSize:width];
    
    [countLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:itemLabel];
    [countLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [countLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [countLabel autoSetDimension:ALDimensionWidth toSize:width];
    
    [priceLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:countLabel];
    [priceLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [priceLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [priceLabel autoSetDimension:ALDimensionWidth toSize:width];
    
    return headerView;
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConsumeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsumeListCell" forIndexPath:indexPath];
    NSDictionary *consumeDic = self.consumeList[indexPath.row];
    cell.consumeDic = consumeDic;
    [cell addLineWithType:BMLineTypeCustomDefault color:nil position:BMLinePostionCustomBottom];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}




@end
