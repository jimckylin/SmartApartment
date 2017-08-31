//
//  Register3ViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/30.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "Register3ViewController.h"
#import "LoginViewModel.h"
#import "Register3View.h"


@interface Register3ViewController ()<Register3ViewDelegate>

@property (nonatomic, strong) Register3View        *register3View;
@property (nonatomic, strong) LoginViewModel       *loginViewModel;

@end

@implementation Register3ViewController

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
    _loginViewModel = [[LoginViewModel alloc] init];
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _naviBgView.backgroundColor = [UIColor clearColor];
    _naviLabel.textColor = [UIColor darkTextColor];
    _naviLabel.text = @"注册3/3";
    [_naviBackBtn setImage:kImage(@"nav_return_iciphone") forState:UIControlStateNormal];
    
    
    _register3View = [[Register3View alloc] init];
    _register3View.delegate = self;
    [self.view addSubview:_register3View];
}


#pragma mark - Register1ViewDelegate

- (void)register3ViewBtnClick:(NSString *)pwd {
    
    [_loginViewModel requestRegisterWithPhone:self.phone name:self.name psw:pwd];
}





@end
