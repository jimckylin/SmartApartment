//
//  CZDLoginViewController.m
//  CWGJCarOwner
//
//  Created by jimcky on 2017/7/18.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "LoginViewController.h"
#import "VerifyCodeLoginViewController.h"
#import "Register1ViewController.h"

#import "LoginView.h"

#import "CZDWebViewFactory.h"
#import "LoginViewModel.h"


@interface LoginViewController ()<CZDLoginViewDelegate>

@property (nonatomic, strong) LoginView           *loginView;
@property (nonatomic, strong) LoginViewModel      *viewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [_loginView phoneTextFieldBecomeFirstResponse];
}

- (void)initData {
    _viewModel = [LoginViewModel new];
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _naviBgView.backgroundColor = [UIColor clearColor];
    _naviLabel.textColor = [UIColor darkTextColor];
    _naviLabel.text = @"会员登录";
    [_naviBackBtn setImage:kImage(@"nav_return_iciphone") forState:UIControlStateNormal];
    
    //[self.customNavItem.leftBarButtonItem]
    
    _loginView = [[LoginView alloc] init];
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
}


#pragma mark - CZDLoginViewDelegate

- (void)loginViewDidClickBtnAction:(CZDLoginAction)action param:(NSDictionary *)param {
    
    NSString *phone = param[@"paramPhone"];
    NSString *pwd  = param[@"paramPwd"];
    
    switch (action) {
        case CZDLoginActionLogin: {
            [UserManager manager].isLogin = YES;
            [_viewModel requestLoginWithPhone:phone psw:pwd];
            //[_viewModel requestLoginWithPhone:phone verifyCode:code];
        }
            break;
        case CZDLoginActionVerifyCodeLoginJump:{
            VerifyCodeLoginViewController *vc = [VerifyCodeLoginViewController new];
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            break;
        case CZDLoginActionForgotPwd: {
            
        }
            break;
        case CZDLoginActionRegister:{
            Register1ViewController *vc = [Register1ViewController new];
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - UIButton Action 

- (void)backClick:(id)sender {
    [[NavManager shareInstance] returnToMainView:YES];
}



@end
