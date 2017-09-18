//
//  CZDLoginViewModel.m
//  CWGJCarOwner
//
//  Created by jimcky on 2017/7/19.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginView.h"
#import "MBProgressHUD+CWGJ.h"


@interface LoginViewModel ()

@end

@implementation LoginViewModel

- (void)requestVerifyCode:(NSString *)phone complete:(void (^)(void))complete {
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"getCheckCode" params:@{@"mobilePhone": phone} class:nil success:^(id response) {
        if (complete) {
            complete();
        }
        [MBProgressHUD cwgj_hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestCheckVerifyCode:(NSString *)phone code:(NSString *)code complete:(void (^)(void))complete {
    
    NSDictionary *param = @{@"mobilePhone": phone, @"validateCode": code};
    [MBProgressHUD cwgj_showProgressHUDWithText:@""];
    [SAHttpRequest requestWithFuncion:@"getCheckCode" params:param class:nil success:^(id response) {
        [MBProgressHUD cwgj_hideHUD];
        if (complete) {
            complete();
        }
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
    }];
}

- (void)requestLoginWithPhone:(NSString *)phone psw:(NSString *)psw {
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@"登录中..."];
    [SAHttpRequest requestWithFuncion:@"login" params:@{@"username": phone,
                                                               @"pwd": psw} class:[User class] success:^(id response) {
        [[UserManager manager] saveUser:(User *)response];
        [MBProgressHUD cwgj_hideHUD];
        [self gotoMainVc];
        
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}

- (void)requestLoginWithPhone:(NSString *)phone verifyCode:(NSString *)code {
    
    [MBProgressHUD cwgj_showProgressHUDWithText:@"登录中..."];
    [SAHttpRequest requestWithFuncion:@"dynamicLogin" params:@{@"mobilePhone": phone,
                                                        @"validateCode": code} class:[User class] success:^(id response) {
                                                            [[UserManager manager] saveUser:(User *)response];
                                                            [MBProgressHUD cwgj_hideHUD];
                                                            [self gotoMainVc];
                                                            
                                                        } failure:^(NSError *error) {
                                                            [MBProgressHUD cwgj_hideHUD];
                                                            [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
                                                        }];
}

- (void)requestRegisterWithPhone:(NSString *)phone name:(NSString *)name psw:(NSString *)psw {
    
    NSDictionary *param = @{@"mobilePhone": phone,@"name": name,@"pwd": psw};
    [MBProgressHUD cwgj_showProgressHUDWithText:@"注册中..."];
    [SAHttpRequest requestWithFuncion:@"register" params:param class:[User class] success:^(id response) {
                                                            [MBProgressHUD cwgj_hideHUD];
        [[UserManager manager] saveUser:(User *)response];
        [self gotoMainVc];
                                                        } failure:^(NSError *error) {
                                                            [MBProgressHUD cwgj_hideHUD];
                                                            [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
                                                        }];
}

- (void)requestResetPwdWithPhone:(NSString *)phone newPwd:(NSString *)newPwd complete:(void (^)(BOOL))complete {
    
    NSDictionary *param = @{@"mobilePhone": phone, @"pwd": newPwd};
    [MBProgressHUD cwgj_showProgressHUDWithText:@"重置中..."];
    [SAHttpRequest requestWithFuncion:@"resetPwd" params:param class:nil success:^(id response) {
        [MBProgressHUD cwgj_hideHUD];
        if (complete) {
            complete(response);
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD cwgj_hideHUD];
        [MBProgressHUD cwgj_showHUDWithText:error.localizedDescription];
    }];
}


#pragma mark - Private

- (void)gotoMainVc {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccess" object:nil];
    [[NavManager shareInstance] returnToMainView:YES];
}


@end
