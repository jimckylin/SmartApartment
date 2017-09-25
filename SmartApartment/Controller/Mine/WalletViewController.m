//
//  WalletViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/22.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "WalletViewController.h"
#import "RechargeViewController.h"
#import "BalanceDetailListViewController.h"
#import "WalletView.h"

@interface WalletViewController ()

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    _naviLabel.text = @"钱包";
    
    WalletView *walletView = [WalletView new];
    [self.view addSubview:walletView];
    
    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rechargeBtn.backgroundColor = ThemeColor;
    [rechargeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [rechargeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    rechargeBtn.layer.cornerRadius = 3;
    [self.view addSubview:rechargeBtn];
    
    [rechargeBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [rechargeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:walletView withOffset:60];
    [rechargeBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-80, 40)];
    
    
    [self addRightNaviButton:@"明细" actionBlock:^{
        BalanceDetailListViewController *vc = [BalanceDetailListViewController new];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    }];
}


#pragma mark - UIButton Action

- (void)btnClick:(UIButton *)sender {
    
    [MBProgressHUD cwgj_showHUDWithText:@"正在开发"];
    return;
    
    RechargeViewController *vc = [RechargeViewController new];
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}

@end
