//
//  CZDLoginViewController.m
//  CWGJCarOwner
//
//  Created by jimcky on 2017/7/18.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "LoginViewController.h"

#import "CZDLoginView.h"

#import "CZDWebViewFactory.h"
#import "CZDLoginViewModel.h"


@interface LoginViewController ()<CZDLoginViewDelegate>

@property (nonatomic, strong) CZDLoginView           *loginView;
@property (nonatomic, strong) CZDLoginViewModel      *viewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [_loginView phoneTextFieldBecomeFirstResponse];
}

- (void)initData {
    _viewModel = [CZDLoginViewModel new];
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _naviLabel.text = @"登录";
    //[self.customNavItem.leftBarButtonItem]
    
    _loginView = [[CZDLoginView alloc] init];
    _loginView.userInfo = _userInfo;
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
}


#pragma mark - CZDLoginViewDelegate

- (void)loginViewDidClickBtnAction:(CZDLoginAction)action param:(NSDictionary *)param {
    
    NSString *phone = param[@"paramPhone"];
    NSString *code  = param[@"paramCode"];
    
    switch (action) {
        case CZDLoginActionVerifyCodeSend: {
            __WeakObj(_loginView);
            [_viewModel requestVerifyCode:phone type:4 complete:^{
                [_loginViewWeak startCountDown];
            }];
        }

            break;
        case CZDLoginActionVoiceVerifyCodeSend:{
            __WeakObj(self)
            [_viewModel requestVoiceVerifyCode:phone type:4 complete:^{
                
                
            }];
        }
            
            break;
        case CZDLoginActionLogin: {
            [_viewModel requestLoginWithPhone:phone verifyCode:code];
        }
            break;
            
        case CZDLoginActionWXOAuthVerifyCodeSend: {
            __WeakObj(_loginView);
            [_viewModel requestVerifyCode:phone type:7 complete:^{
                
                [_loginViewWeak startCountDown];
            }];
        }
            
            break;
        case CZDLoginActionWXOAuthVoiceVerifyCodeSend:{
            __WeakObj(self)
            [_viewModel requestVoiceVerifyCode:phone type:7 complete:^{
                
                
            }];
        }
            
            break;
        case CZDLoginActionWXOAuthLogin: {
            NSDictionary *param = @{@"telephone":phone,
                                    @"smscode":code,
                                    @"openid":self.userInfo[@"openid"],
                                    @"unionid":self.userInfo[@"unionid"],
                                    @"service_id":@3
                                    };
            [_viewModel requestWeChatLoginWithPhone:param];
        }
            break;
            
        case CZDLoginActionProtocol: {
            CZDWebViewController *vc = [CZDWebViewFactory getWebVcWithType:CZDWebTypeRegisterAgreement];
            [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}




@end
