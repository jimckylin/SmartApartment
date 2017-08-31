//
//  Regitster1ViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/30.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "Register1ViewController.h"
#import "Register2ViewController.h"

#import "Register1View.h"


@interface Register1ViewController ()<Register1ViewDelegate>

@property (nonatomic, strong) Register1View       *register1View;

@end

@implementation Register1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)initData {
    
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _naviBgView.backgroundColor = [UIColor clearColor];
    _naviLabel.textColor = [UIColor darkTextColor];
    _naviLabel.text = @"注册1/3";
    [_naviBackBtn setImage:kImage(@"nav_return_iciphone") forState:UIControlStateNormal];
    
    //[self.customNavItem.leftBarButtonItem]
    
    _register1View = [[Register1View alloc] init];
    _register1View.delegate = self;
    [self.view addSubview:_register1View];
}


#pragma mark - Register1ViewDelegate

- (void)register1ViewBtnClick:(NSString *)phone name:(NSString *)name {
    
    Register2ViewController *vc = [Register2ViewController new];
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}




@end
