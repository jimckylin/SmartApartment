//
//  CZDLoginViewModel.h
//  CWGJCarOwner
//
//  Created by jimcky on 2017/7/19.
//  Copyright © 2017年 CheWeiGuanJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginView;

@interface LoginViewModel : UIView

@property (nonatomic, weak) LoginView *loginView;

// 获取验证码
- (void)requestVerifyCode:(NSString *)phone complete:(void(^)(void))complete;
// 验证验证码
- (void)requestCheckVerifyCode:(NSString *)phone code:(NSString *)code complete:(void(^)(void))complete;

// 登录
- (void)requestLoginWithPhone:(NSString *)phone psw:(NSString *)psw;
// 验证码登录
- (void)requestLoginWithPhone:(NSString *)phone verifyCode:(NSString *)code;
// 注册
- (void)requestRegisterWithPhone:(NSString *)phone name:(NSString *)name psw:(NSString *)psw;


@end
