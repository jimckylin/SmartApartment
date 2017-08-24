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
// 获取语音验证码
- (void)requestVoiceVerifyCode:(NSString *)phone type:(int)type complete:(void(^)(void))complete;
// 登录
- (void)requestLoginWithPhone:(NSString *)phone psw:(NSString *)psw;
- (void)requestLoginWithPhone:(NSString *)phone verifyCode:(NSString *)code;
// 微信登录
- (void)requestWeChatLoginWithPhone:(NSDictionary *)param;

@end
