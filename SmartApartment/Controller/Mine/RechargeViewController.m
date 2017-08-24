//
//  RechargeViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/22.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeView.h"

@interface RechargeViewController ()

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    _naviLabel.text = @"充值";
    
    RechargeView *view = [RechargeView new];
    [self.view addSubview:view];
}


@end
