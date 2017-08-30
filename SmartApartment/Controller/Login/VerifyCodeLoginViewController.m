//
//  VerifyCodeLoginViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/30.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "VerifyCodeLoginViewController.h"

#import "LoginView.h"

#import "CZDWebViewFactory.h"
#import "LoginViewModel.h"


@interface VerifyCodeLoginViewController ()<CZDLoginViewDelegate>

@property (nonatomic, strong) LoginView           *loginView;
@property (nonatomic, strong) LoginViewModel      *viewModel;

@end

@implementation VerifyCodeLoginViewController

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
    NSString *code  = param[@"paramCode"];
    
    switch (action) {
        case CZDLoginActionLogin: {
            [UserManager manager].isLogin = YES;
            [_viewModel requestLoginWithPhone:phone psw:@"psw"];
            //[_viewModel requestLoginWithPhone:phone verifyCode:code];
        }
            break;
            
            break;
        case CZDLoginActionVerifyCodeLoginJump:{
            __WeakObj(self)
            
        }
            
            break;
            
     }
}



@end
