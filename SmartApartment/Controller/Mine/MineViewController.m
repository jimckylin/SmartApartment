//
//  MineViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MineViewController.h"
#import "PersonInfoViewController.h"
#import "SettingViewController.h"
#import "UIScrollView+HeaderScaleImage.h"
#import "MineHeaderView.h"
#import "AboutViewController.h"
#import "HotelOrderListViewController.h"
#import "UsefullInfoViewController.h"
#import "WalletViewController.h"
#import "CouponViewController.h"
#import <BMLine/UIView+BMLine.h>
#import "MyCommentListViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource, MineHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MineHeaderView *headerView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

- (void)initData {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccess:)
                                                 name:@"kLoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logoutSuccess:)
                                                 name:@"kLogoutSuccess" object:nil];
}

- (void)initUI {
    
    [_naviBackBtn setHidden:YES];
    _naviLabel.text = NSLocalizedString(@"我的", nil);
    
    /*
    UIButton *settingBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame=CGRectMake(kScreenWidth - 45, 22, 40, 40);
    [settingBtn setImage:[UIImage imageNamed:@"mine_set_navbariphone"] forState:UIControlStateNormal];
    settingBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [settingBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];*/

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 10;
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 49, 0)];
    
    [self.view sendSubviewToBack:_tableView];
    
    // 设置tableView头部缩放图片 *一行代码就集成了*
    _tableView.yz_headerScaleImage = [UIImage imageNamed:@"mine_hand_bgiphone"];
    
    // 设置tableView头部视图，必须设置头部视图背景颜色为clearColor,否则会被挡住
    _headerView = [MineHeaderView new];
    [_headerView setHeaderViewData];
    // 清空头部视图背景颜色
    _headerView.backgroundColor = [UIColor clearColor];
    _headerView.delegate = self;
    self.tableView.tableHeaderView = _headerView;
    
    
}


#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSString *cellIdetifier = @"cellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor darkTextColor];
            
            UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 135, 0, 100, 44)];
            [subLabel setTextAlignment:NSTextAlignmentRight];
            [subLabel setTextColor:[UIColor lightGrayColor]];
            [subLabel setFont:[UIFont systemFontOfSize:13.0f]];
            subLabel.tag = 1000;
            [cell addSubview:subLabel];
            
            UIImageView *iconArrow = [[UIImageView alloc] initWithImage:kImage(@"home_arrow_iconiphone")];
            iconArrow.center = CGPointMake(kScreenWidth-25, 22);
            iconArrow.tag = 1001;
            [cell addSubview:iconArrow];
            
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor lightGrayColor];
            [cell addSubview:line];
            [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
            [line autoSetDimension:ALDimensionHeight toSize:0.5];
        }
        UILabel *subLabel = (UILabel *)[cell viewWithTag:1000];
        UIImageView *iconArrow = (UIImageView *)[cell viewWithTag:1001];
        
        if (indexPath.row == 1) {
            subLabel.text = @"常用旅客";
        }else if (indexPath.row == 3){
            iconArrow.hidden = YES;
            subLabel.textColor = ThemeColor;
            subLabel.left = subLabel.left + 20;
            subLabel.text = @"400-4154-451";
        }
        
        
        NSArray *icons = @[@"mine_order_iciphone", @"mine_information_iciphone", @"mine_comment_iciphone", @"mine_information_iciphone"];
        NSArray *titles = @[@"酒店订单", @"常用信息", @"我的点评", @"客服电话"];
        
        cell.imageView.image = [UIImage imageNamed:icons[indexPath.row]];
        cell.textLabel.text = titles[indexPath.row];
        return cell;
        
    }else {
        NSString *cellIdetifier = @"cellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor darkTextColor];
            
            UIImageView *iconArrow = [[UIImageView alloc] initWithImage:kImage(@"home_arrow_iconiphone")];
            iconArrow.center = CGPointMake(kScreenWidth-25, 22);
            iconArrow.tag = 1001;
            [cell addSubview:iconArrow];
            
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor lightGrayColor];
            [cell addSubview:line];
            [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
            [line autoSetDimension:ALDimensionHeight toSize:0.5];
        }
        cell.textLabel.text = @"关于蔓心宿";
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HotelOrderListViewController *vc = [HotelOrderListViewController new];
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }else if (indexPath.row == 1) {
            UsefullInfoViewController *vc = [UsefullInfoViewController new];
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
            
        }else if (indexPath.row == 2) {
            MyCommentListViewController *vc = [MyCommentListViewController new];
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }else {
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-4154-451"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }else {
        AboutViewController *vc = [AboutViewController new];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
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
        case HeaderEventTypeProfile:{
            if ([UserManager manager].isLogin) {
                PersonInfoViewController *vc = [PersonInfoViewController new];
                [[NavManager shareInstance] showViewController:vc isAnimated:YES];
            }else {
                [[NavManager shareInstance] returnToLoginView:YES];
            }
        }
            break;
        case HeaderEventTypeBalance: {
            WalletViewController *vc = [WalletViewController new];
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
                
        }
            break;
        case HeaderEventTypeCoupon: {
            CouponViewController *vc = [CouponViewController new];
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            
            break;
        case HeaderEventTypeIntegral: {
            
            [MBProgressHUD cwgj_showHUDWithText:@"后续开发"];
        }
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


#pragma mark - Notification

- (void)loginSuccess:(NSNotification *)noti {
    
    [_headerView setHeaderViewData];
}

- (void)logoutSuccess:(NSNotification *)noti {
    
    [_headerView setHeaderViewData];
}


@end
