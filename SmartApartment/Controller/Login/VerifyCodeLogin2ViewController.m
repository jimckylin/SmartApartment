//
//  VerifyCodeLogin2ViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "VerifyCodeLogin2ViewController.h"

#import "VerifyCode2LoginView.h"
#import "LoginViewModel.h"

@interface VerifyCodeLogin2ViewController ()<VerifyCode2LoginViewDelegate>

@property (nonatomic, strong) VerifyCode2LoginView  *verifyCode2View;
@property (nonatomic, strong) LoginViewModel        *loginViewModel;

@end

@implementation VerifyCodeLogin2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)initData {
    _loginViewModel = [[LoginViewModel alloc] init];
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _naviBgView.backgroundColor = [UIColor clearColor];
    _naviLabel.textColor = [UIColor darkTextColor];
    _naviLabel.text = @"动态密码登录";
    [_naviBackBtn setImage:kImage(@"nav_return_iciphone") forState:UIControlStateNormal];
    
    
    _verifyCode2View = [[VerifyCode2LoginView alloc] init];
    _verifyCode2View.phone = self.phone;
    _verifyCode2View.delegate = self;
    [self.view addSubview:_verifyCode2View];
}


#pragma mark - VerifyCode2LoginViewDelegate

- (void)verifyCode2ViewVerifyCodeBtnClick {
    
    [_loginViewModel requestVerifyCode:self.phone complete:nil];
}

- (void)verifyCode2LoginView:(NSString *)code {
    
    [_loginViewModel requestLoginWithPhone:self.phone verifyCode:code];
}




@end
