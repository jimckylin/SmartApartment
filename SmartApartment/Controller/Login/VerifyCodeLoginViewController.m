//
//  VerifyCodeLoginViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/30.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "VerifyCodeLoginViewController.h"
#import "VerifyCodeLogin2ViewController.h"
#import "Register1ViewController.h"

#import "VerifyCode1LoginView.h"

#import "CZDWebViewFactory.h"
#import "LoginViewModel.h"


@interface VerifyCodeLoginViewController ()<VerifyCode1LoginViewDelegate>

@property (nonatomic, strong) VerifyCode1LoginView  *verifyCode1LoginView;
@property (nonatomic, strong) LoginViewModel        *viewModel;

@end

@implementation VerifyCodeLoginViewController

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)initData {
    _viewModel = [LoginViewModel new];
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _naviBgView.backgroundColor = [UIColor clearColor];
    _naviLabel.textColor = [UIColor darkTextColor];
    _naviLabel.text = @"动态密码登录";
    [_naviBackBtn setImage:kImage(@"nav_return_iciphone") forState:UIControlStateNormal];
    
    //[self.customNavItem.leftBarButtonItem]
    
    _verifyCode1LoginView = [[VerifyCode1LoginView alloc] init];
    _verifyCode1LoginView.delegate = self;
    [self.view addSubview:_verifyCode1LoginView];
}


#pragma mark - VerifyCode1LoginViewDelegate

- (void)verifyCode1LoginViewBtnClick:(NSString *)phone action:(VerifyCodeLoginAction)action {
    
    switch (action) {
        case VerifyCodeLoginActionGetVerifyCode: {
            VerifyCodeLogin2ViewController *vc = [VerifyCodeLogin2ViewController new];
            vc.phone = phone;
            [[NavManager shareInstance] showViewController:vc isAnimated:YES]; 
        }
            break;
            
            break;
        case VerifyCodeLoginActionNormalLogin:{
            [[NavManager shareInstance] returnToFrontView:YES];
        }
            
            break;
        case VerifyCodeLoginActionRegitster:{
            Register1ViewController *vc = [Register1ViewController new];
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            
            break;
     }
}



@end
