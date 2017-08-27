//
//  HotelDescrViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDescrViewController.h"
#import "MapViewController.h"

#import "HotelDetailMapCell.h"
#import "HotelListCell.h"


NSString *const kHotelListCell = @"kHotelListCell";

@interface HotelDescrViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation HotelDescrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubView];
}

- (void)initSubView {
    
    _naviLabel.text = @"酒店介绍";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HotelListCell class] forCellReuseIdentifier:kHotelListCell];
    _tableView.contentInset = UIEdgeInsetsMake(90, 0, 0, 0);
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(90, 0, 0, 0);
    [self.view addSubview:_tableView];
}


#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 112;
    }else if (section == 1) {
        return 40;
    }else if (section == 2) {
        return 101;
    }
    return 244;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    if (section == 0) {
        
    }else if (section == 1) {
        
    }else if (section == 2) {
        HotelDetailMapCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelDetailMapCell"];
        [cell setMapCenterCoordinate:@"26.08" lon:@"119.3"];
        cell.mapViewDidClickBlock = ^{
            MapViewController *map = [MapViewController new];
            [map setMapCenterCoordinate:@"26.08" lon:@"119.3"];
            [[NavManager shareInstance] showViewController:map isAnimated:YES];
        };
        return cell;
    }
    
    HotelListCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelListCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



#pragma mark - UIButton Action






@end
