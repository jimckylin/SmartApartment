//
//  ForgotPasswordViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ForgotPassword1ViewController.h"
#import "ForgotPassword2ViewController.h"

#import "ForgotPsw1View.h"
#import "LoginViewModel.h"


@interface ForgotPassword1ViewController ()<ForgotPsw1ViewDelegate>

@property (nonatomic, strong) ForgotPsw1View  *forgotPwdView;
@property (nonatomic, strong) LoginViewModel      *viewModel;

@end

@implementation ForgotPassword1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    //[_forgotPwdView phoneTextFieldBecomeFirstResponse];
}

- (void)initData {
    _viewModel = [LoginViewModel new];
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _naviBgView.backgroundColor = [UIColor clearColor];
    _naviLabel.textColor = [UIColor darkTextColor];
    _naviLabel.text = @"重置密码1/2";
    [_naviBackBtn setImage:kImage(@"nav_return_iciphone") forState:UIControlStateNormal];
    
    
    _forgotPwdView = [[ForgotPsw1View alloc] init];
    _forgotPwdView.delegate = self;
    [self.view addSubview:_forgotPwdView];
}


#pragma mark - ForgotPsw1ViewDelegate

- (void)forgotPsw1ViewVerifyCodeBtnClick:(NSString *)phone {
    
    [_viewModel requestVerifyCode:phone complete:nil];
}

- (void)forgotPsw1ViewDidClickBtnAction:(NSString *)phone code:(NSString *)code {
    
    [_viewModel requestCheckVerifyCode:phone code:code complete:^{
        ForgotPassword2ViewController *vc = [ForgotPassword2ViewController new];
        vc.phone = phone;
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    }];
}


@end
