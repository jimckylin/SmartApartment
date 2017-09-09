//
//  RechargeViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/22.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeView.h"
#import "MineViewModel.h"
#import "PayManager.h"

@interface RechargeViewController () <RechargeViewDelegate>
@property (nonatomic, strong) RechargeView *rechargeView;
@property (nonatomic, strong) MineViewModel  *mineViewModel;

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    
    _mineViewModel = [MineViewModel new];
    [self requestRechargePrice];
}

- (void)initView {
    _naviLabel.text = @"充值";
    
    _rechargeView = [RechargeView new];
    _rechargeView.delegate = self;
    [self.view addSubview:_rechargeView];
}


#pragma mark - Request

- (void)requestRechargePrice {
    
    __WeakObj(self)
    [_mineViewModel requestRechargePrice:^(NSArray *moneyList) {
        selfWeak.rechargeView.moneyList = moneyList;
    }];
}


#pragma mark - RechargeViewDelegate

- (void)rechargeViewDidClickRechargeBtn:(NSString *)payType rechargeDic:(NSDictionary *)rechargeDic {
    
    long rechargeId = [rechargeDic[@"rechargeId"] longValue];
    NSString *rechargeIdStr = [NSString stringWithFormat:@"%ld", rechargeId];
    [_mineViewModel requestWalletRecharge:payType rechargeId:rechargeIdStr complete:^(NSDictionary *orderDict) {
        
        [[PayManager getInstance] requestZFBV2:orderDict[@"orderStr"]];
        [PayManager getInstance].didPayCompleteBlock = ^{
            
            [MBProgressHUD cwgj_showHUDWithText:@"充值成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NavManager shareInstance] returnToFrontView:YES];
            });
        };
    }];
}


@end
