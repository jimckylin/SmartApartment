//
//  ForgotPassword2ViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ForgotPassword2ViewController.h"
#import "LoginViewController.h"

#import "ForgotPsw2View.h"
#import "LoginViewModel.h"


@interface ForgotPassword2ViewController ()<ForgotPsw2ViewDelegate>

@property (nonatomic, strong) ForgotPsw2View  *forgotPwdView;
@property (nonatomic, strong) LoginViewModel      *viewModel;

@end

@implementation ForgotPassword2ViewController

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
    
    
    _forgotPwdView = [[ForgotPsw2View alloc] init];
    _forgotPwdView.delegate = self;
    [self.view addSubview:_forgotPwdView];
}


#pragma mark - ForgotPsw2ViewDelegate

- (void)forgotPsw2ViewDidClickResetBtnAction:(NSString *)pwd {
    
    __WeakObj(self)
    [_viewModel requestResetPwdWithPhone:self.phone newPwd:pwd complete:^(BOOL isSuccess) {
        
        for (UIViewController *vc in selfWeak.navigationController.viewControllers) {
            if ([vc isKindOfClass:[LoginViewController class]]) {
                [selfWeak.navigationController popToViewController:vc animated:YES];
                return ;
            }
        }
    }];
}


@end
