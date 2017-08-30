//
//  Register2ViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/30.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "Register2ViewController.h"
#import "Register3ViewController.h"

#import "Register2View.h"


@interface Register2ViewController ()<Register2ViewDelegate>

@property (nonatomic, strong) Register2View       *register2View;

@end

@implementation Register2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)initData {
    
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _naviBgView.backgroundColor = [UIColor clearColor];
    _naviLabel.textColor = [UIColor darkTextColor];
    _naviLabel.text = @"注册2/3";
    [_naviBackBtn setImage:kImage(@"nav_return_iciphone") forState:UIControlStateNormal];
    
    
    _register2View = [[Register2View alloc] init];
    _register2View.delegate = self;
    [self.view addSubview:_register2View];
}


#pragma mark - Register1ViewDelegate

- (void)register2ViewVerifyCodeBtnClick {
    
    
}

- (void)register2ViewBtnClick:(NSString *)verifyCode {
    
    Register3ViewController *vc = [Register3ViewController new];
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}




@end
