//
//  MineViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MineViewController.h"
#import "SettingViewController.h"
#import "UIScrollView+HeaderScaleImage.h"
#import "MineHeaderView.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource, MineHeaderViewDelegate>

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
    
    UIButton *settingBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame=CGRectMake(kScreenWidth - 45, 22, 40, 40);
    [settingBtn setImage:[UIImage imageNamed:@"mine_set_navbariphone"] forState:UIControlStateNormal];
    settingBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [settingBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];

    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 49, 0)];
    
    [self.view sendSubviewToBack:_tableView];
    
    // 设置tableView头部缩放图片 *一行代码就集成了*
    _tableView.yz_headerScaleImage = [UIImage imageNamed:@"mine_hand_bgiphone"];
    
    // 设置tableView头部视图，必须设置头部视图背景颜色为clearColor,否则会被挡住
    MineHeaderView *headerView = [MineHeaderView new];
    // 清空头部视图背景颜色
    headerView.backgroundColor = [UIColor clearColor];
    headerView.delegate = self;
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
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkTextColor];
        
    }
    NSDictionary *dic = @{@"酒店订单":@"mine_order_iciphone", @"我的酒店":@"mine_hotel_iciphone", @"常用信息":@"mine_information_iciphone"};
    cell.imageView.image = [UIImage imageNamed:[dic allValues][indexPath.row]];
    cell.textLabel.text = [dic allKeys][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1) {
        
    }else if (indexPath.row == 2) {
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > 50) {
        _naviView.alpha = (scrollView.contentOffset.y - 50)/60;
    }else {
        _naviView.alpha = 0.f;
    }
}


#pragma mark - MineHeaderViewDelegate

- (void)mineHeaderViewDidClickEvent:(HeaderEventType)type {
    
    switch (type) {
            case HeaderEventTypeProfile:
            
            break;
            case HeaderEventTypeBalance:
            
            break;
            case HeaderEventTypeCoupon:
            
            break;
            case HeaderEventTypeIntegral:
            
            break;
            
        default:
            break;
    }
}


#pragma mark - UIButton Action 

- (void)rightBtnClick:(id)sender {
    
    SettingViewController *vc = [SettingViewController new];
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}


@end
