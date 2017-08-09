//
//  MineViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MineViewController.h"
#import "UIScrollView+HeaderScaleImage.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    
    [_naviBackBtn setHidden:YES];
    _naviLabel.text = NSLocalizedString(@"我的", nil);
    [self addRightNaviButton:@"mine_set_navbariphone" action:@selector(rightBtnClick:)];
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 49, 0)];
    
    // 设置tableView头部缩放图片 *一行代码就集成了*
    _tableView.yz_headerScaleImage = [UIImage imageNamed:@"mine_hand_bgiphone"];
    
    // 设置tableView头部视图，必须设置头部视图背景颜色为clearColor,否则会被挡住
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 140)];
    // 清空头部视图背景颜色
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdetifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkTextColor];
    }
    NSDictionary *dic = @{@"酒店订单":@"mine_order_iciphone", @"我的酒店":@"mine_hotel_iciphone", @"常用信息":@"mine_information_iciphone"};
    cell.imageView.image = [UIImage imageNamed:[dic allValues][indexPath.row]];
    cell.textLabel.text = [dic allKeys][indexPath.row];
    
    return cell;
}


#pragma mark - UIButton Action 

- (void)rightBtnClick:(id)sender {
    
    
}


@end
